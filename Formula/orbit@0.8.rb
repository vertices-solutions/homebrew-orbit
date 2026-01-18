class OrbitAT08 < Formula
  desc "Local-first Slurm submissions over SSH"
  homepage "https://hpcd.dev"
  url "https://github.com/vertices-solutions/orbit/archive/refs/tags/v0.8.0.tar.gz"
  sha256 "2e68dc3f3b3fee142f2ac11410298d02a2ab3a4e9fdb90e26b13ee99a929c5c0"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/vertices-solutions/homebrew-orbit/releases/download/orbit-0.8.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "4d086f3a303c3c65f25ab42def581fc7007cba706a59e199063d7c36af8f0f1d"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3df56fa1cb9c75b8388044205481699dfcea6c611bd4826030409262297eb936"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d80dae7d4d62e4b5c1bea3fea3c3126dc884cc214b2e572dcc0b246f39a89991"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "edb1a56b16ca63ec3167c04a88a445e8c97eb721fe75f64490fd4f72f71d18de"
  end

  keg_only :versioned_formula

  depends_on "pkg-config" => :build
  depends_on "rust" => :build
  depends_on "protobuf" => :build
  depends_on "openssl@3" if OS.linux?
  depends_on "sqlite" if OS.linux?

  def install
    system "cargo", "install", *std_cargo_args(path: "orbit")
    system "cargo", "install", *std_cargo_args(path: "orbitd")
  end

  service do
    run [opt_bin/"orbitd"]
    keep_alive true
    log_path var/"log/orbitd.log"
    error_log_path var/"log/orbitd.log"
  end

  test do
    system bin/"orbit", "--help"
    system bin/"orbitd", "--help"
  end
end
