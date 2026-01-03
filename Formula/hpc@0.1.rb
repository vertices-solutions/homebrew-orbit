class HpcAT01 < Formula
  desc "Local-first Slurm submissions over SSH"
  homepage "https://hpcd.dev"
  url "https://github.com/hpcd-dev/hpcd/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "efc75376d2e3bdd9ddabdc01ac2b2bc41fe3e80e2b8ada69d8e358a4b82e92fb"
  license "AGPL-3.0-only"
  keg_only :versioned_formula

  bottle do
    root_url "https://github.com/hpcd-dev/homebrew-hpc/releases/download/hpc-0.1.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "f2f3b9271b38130ac98535e2276b8fd43435d7f51c7eb699c4acf201c7a0d91e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a6c7b50f376533e97ffe597a107c50eba9b4293cce3f135bfaddce9d4d092d68"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0f629f94d0cbd0984813c3fa9890330e0ede4fff98917a579ee4406e18d0f0d2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b8ccfa9238ea6523061a1e229f07f5156b692d5b10b6a4969356f7f60fd4d34a"
  end

  depends_on "pkg-config" => :build
  depends_on "rust" => :build
  depends_on "protobuf" => :build
  depends_on "openssl@3" if OS.linux?
  depends_on "sqlite" if OS.linux?

  def install
    system "cargo", "install", *std_cargo_args(path: "cli")
    system "cargo", "install", *std_cargo_args(path: "hpcd")
  end

  service do
    run [opt_bin/"hpcd"]
    keep_alive true
    log_path var/"log/hpcd.log"
    error_log_path var/"log/hpcd.log"
  end

  test do
    system bin/"hpc", "--help"
    system bin/"hpcd", "--help"
  end
end
