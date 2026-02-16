class OrbitAT015 < Formula
  desc "Local-first Slurm submissions over SSH"
  homepage "https://hpcd.dev"
  url "https://github.com/vertices-solutions/orbit/archive/refs/tags/v0.15.0.tar.gz"
  sha256 "505572bbb2b8b8a23d358cc009ac2b1b283b0960a3cb510fc3fbb051adcaaa4e"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/vertices-solutions/homebrew-orbit/releases/download/orbit-0.15.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "3f171466f031a1568b4bf006cfa89e0454c9666e9a2a784ba2fa301d3b1a6bcd"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c6dc525e578352bc4df7a5edce063c96c9ba6f48825fb8578e984ae6ed05d9cc"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c6e2d0f51355d4be8f035c83007613aa91ea7769b4148482c175a277d5587bcb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5c83eb700e7c23e7dace32e13aa2126aa182a4669f7bfa1fcf1f55983e2bc303"
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
