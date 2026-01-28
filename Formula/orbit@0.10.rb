class OrbitAT010 < Formula
  desc "Local-first Slurm submissions over SSH"
  homepage "https://hpcd.dev"
  url "https://github.com/vertices-solutions/orbit/archive/refs/tags/v0.10.2.tar.gz"
  sha256 "e543262c6cdb792a6a158736493eb98260765eaae20f5366871f7a6ef045e22f"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/vertices-solutions/homebrew-orbit/releases/download/orbit-0.10.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "404c0bd300a46596e50f8ac8b926e66c5eae2adb7ed3887e30738ad1330c5ec5"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "642c748e03e350a63d0ec609014f6aeca9aa9425b96eaf1428e040d5828932a4"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ea2bae013d6e1b94b398ec92c0a824c3fd14907ae8076cd94645b6849798aac3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9b4749b393b59b77f5eac2c3e7c8242fbbf5bd584f2f9b4f10bcb18465a90e8c"
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
