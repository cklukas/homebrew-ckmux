# Copyright (c) 2026 C. Klukas. All rights reserved.
# SPDX-License-Identifier: MIT
# typed: strict
# frozen_string_literal: true

# Builds ckmux from an immutable GitHub release archive.
class Ckmux < Formula
  desc "Terminal multiplexer with a visible interface"
  homepage "https://github.com/cklukas/ckmux"
  url "https://github.com/cklukas/ckmux/archive/refs/tags/v0.1.6.tar.gz"
  version "0.1.6"
  sha256 "436fd559eebc9215444be0ce865716f11a8cb10daaeaf09c8391c6c8b010a5bf"
  license "MIT"

  depends_on "cmake" => :build

  resource "ckvision" do
    url "https://github.com/cklukas/ckVision/archive/refs/tags/v0.1.7.tar.gz"
    sha256 "4308862076d2589c5cf4ae5d90c963e0a1b5f708a8f1fe8d3cfb229a76a7a2d4"
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
