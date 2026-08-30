# Copyright (c) 2026 C. Klukas. All rights reserved.
# SPDX-License-Identifier: MIT
# typed: strict
# frozen_string_literal: true

# Builds ckmux from an immutable GitHub release archive.
class Ckmux < Formula
  desc "Terminal multiplexer with a visible interface"
  homepage "https://github.com/cklukas/ckmux"
  url "https://github.com/cklukas/ckmux/archive/refs/tags/v0.1.2.tar.gz"
  version "0.1.2"
  sha256 "a43c407c3b188dbd122db0af6e084c3ad2453dbcf95d84d411518dffe6b861a4"
  license "MIT"

  depends_on "cmake" => :build

  resource "ckvision" do
    url "https://github.com/cklukas/ckVision/archive/refs/tags/v0.1.1.tar.gz"
    sha256 "8b629ecd9b16a9ce2edfcbae941afd97409991746bd3a873a2e38bca281a26d1"
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
