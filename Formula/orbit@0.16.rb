class OrbitAT016 < Formula
  desc "Local-first Slurm submissions over SSH"
  homepage "https://hpcd.dev"
  url "https://github.com/vertices-solutions/orbit/archive/refs/tags/v0.16.0.tar.gz"
  sha256 "380744db8403c20d7de43f3c90390e7d3f47ec2943c9aa1ee38e6f290e96ab5e"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/vertices-solutions/homebrew-orbit/releases/download/orbit-0.16.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "882f0091ea24c60a2e74578008d08d64682d3e0aa805f8faf4b704bf7028a384"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "bc8c3d03b63ee29601324b61d4fd6da0cd11b9f1a374ae3ffcc216453a4e58a6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2f00aaab314798f2671015d8e3f710f916fdb4b5fab4c573d5b5637c65587dbe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c286cf4be5d67303ae9cb4d544c10913926c4281fd1ff640bf1dd4140e0fd144"
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
