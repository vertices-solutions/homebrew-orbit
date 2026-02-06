class OrbitAT014 < Formula
  desc "Local-first Slurm submissions over SSH"
  homepage "https://hpcd.dev"
  url "https://github.com/vertices-solutions/orbit/archive/refs/tags/v0.14.0.tar.gz"
  sha256 "2eadfb5fc422c19fca45b37b652da74b73181212e7c3cbda989008a089e59056"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/vertices-solutions/homebrew-orbit/releases/download/orbit-0.14.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "bbaf9b1b46b963abb262910b14dcff543a41918b71d51b2c1d82adcd38a6d168"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7033d7d2befb22b714cb2999d4c3fda05185eafee644ba9bcb35e9c9c2bd2a5a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "47e9e00172d778242b5b7e39c46e914efb854d2f42f948a696d6c8ed3a7dee09"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "03c77f9e5d91d6b6ffbb8ef02b5882c30739af86ea5bf2aab36185a1f6dcfe85"
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
    generate_completions_from_executable(
      bin/"orbit",
      "completions",
      shells: [:bash, :zsh],
    )
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
