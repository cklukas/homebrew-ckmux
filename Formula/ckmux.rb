# Copyright (c) 2026 C. Klukas. All rights reserved.
# SPDX-License-Identifier: MIT
# typed: strict
# frozen_string_literal: true

# Builds ckmux from an immutable GitHub release archive.
class Ckmux < Formula
  desc "Terminal multiplexer with a visible interface"
  homepage "https://github.com/cklukas/ckmux"
  url "https://github.com/cklukas/ckmux/archive/refs/tags/v0.1.8.tar.gz"
  version "0.1.8"
  sha256 "9bba66a4afdafec51578379bb60de14b0e454abc7832c0784d2a558a28e74b34"
  license "MIT"

  depends_on "cmake" => :build

  resource "ckvision" do
    url "https://github.com/cklukas/ckVision/archive/refs/tags/v0.1.18.tar.gz"
    sha256 "3d3ed4e45d8aeac88a7ba69cac31e22b21297d942b713321c536e5c71c238795"
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
