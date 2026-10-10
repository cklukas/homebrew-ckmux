# Copyright (c) 2026 C. Klukas. All rights reserved.
# SPDX-License-Identifier: MIT
# typed: strict
# frozen_string_literal: true

# Builds ckmux from an immutable GitHub release archive.
class Ckmux < Formula
  desc "Terminal multiplexer with a visible interface"
  homepage "https://github.com/cklukas/ckmux"
  url "https://github.com/cklukas/ckmux/archive/refs/tags/v0.1.9.tar.gz"
  version "0.1.9"
  sha256 "a7e9a25c2f7856717864607344216e3b91ee85fa0af21ef80c5132f480b9fa07"
  license "MIT"

  depends_on "cmake" => :build

  resource "ckvision" do
    url "https://github.com/cklukas/ckVision/archive/refs/tags/v1.0.0.tar.gz"
    sha256 "9edb412d660cbd2913c7a0f88145ce1769cd3fc56f76e33db9e0e7f5b90d153a"
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
