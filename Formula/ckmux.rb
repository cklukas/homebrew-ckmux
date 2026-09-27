# Copyright (c) 2026 C. Klukas. All rights reserved.
# SPDX-License-Identifier: MIT
# typed: strict
# frozen_string_literal: true

# Builds ckmux from an immutable GitHub release archive.
class Ckmux < Formula
  desc "Terminal multiplexer with a visible interface"
  homepage "https://github.com/cklukas/ckmux"
  url "https://github.com/cklukas/ckmux/archive/refs/tags/v0.1.7.tar.gz"
  version "0.1.7"
  sha256 "8a7957651af0e9dac6fa79720addda0d0ad0fad9cd011b70ad9cba27bd2128d9"
  license "MIT"

  depends_on "cmake" => :build

  resource "ckvision" do
    url "https://github.com/cklukas/ckVision/archive/refs/tags/v0.1.8.tar.gz"
    sha256 "401d39a8e5b4bbf43db02cf19c3144515133abf0373d8251adbf7ff7d7993119"
  end

  def install
    resource("ckvision").stage buildpath/"ckvision"
    system "cmake", "-S", ".", "-B", "build",
           "-DCMAKE_BUILD_TYPE=Release",
           "-DCKMUX_BUILD_TESTING=OFF",
           "-DCKMUX_CKVISION_SOURCE_DIR=#{buildpath}/ckvision",
           "-DCKMUX_PREFER_CKVISION_SOURCE=ON",
           *std_cmake_args
    system "cmake", "--build", "build", "--parallel"
    system "cmake", "--install", "build"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ckmux --version")
  end
end
