class OrbitAT013 < Formula
  desc "Local-first Slurm submissions over SSH"
  homepage "https://hpcd.dev"
  url "https://github.com/vertices-solutions/orbit/archive/refs/tags/v0.13.0.tar.gz"
  sha256 "9a9814a26319963646f34f78eea57a5f4c3e36ff2aa318b396ba64a146a00d4c"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/vertices-solutions/homebrew-orbit/releases/download/orbit-0.13.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "a223efe6c43063a821e7d57099734987695aafd02c772d57552bb8a7b050bca5"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "15c3d28095c9184ab1720c7f8d4e94e4e3d3f34add81cfd66dbecd30fe330e3f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e56d228a76e54017edda6c419842ec01328ba0820c8bb1e267e2991b72dc0510"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4ed5580975557088ac0db21d8c70b189e9b07637c9b6edab4708802ea67430b4"
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
