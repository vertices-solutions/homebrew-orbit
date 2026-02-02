class OrbitAT012 < Formula
  desc "Local-first Slurm submissions over SSH"
  homepage "https://hpcd.dev"
  url "https://github.com/vertices-solutions/orbit/archive/refs/tags/v0.12.0.tar.gz"
  sha256 "c0f6a97df0076753fdbc625dab1226a2aa347c1e83f7c0865892665649236349"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/vertices-solutions/homebrew-orbit/releases/download/orbit-0.12.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "1e46d8a96f5a89901643ed1d9aca9148107d6fe8f34d0d64c03cbf1effc281f1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ffe0d6ede223e97a9a7bc0cc82aefc932305a747debfd93086e7088bf050259c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "edc09ce7c7dcdf8f5320a4f4c16e7b2badb9716c8516bc573f4f661a66dcae6a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7fe6b06e8d0e8f0dea3daa5f29d44b258d909516b8f5dc9310d47a2b613f72f9"
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
