class OrbitAT010 < Formula
  desc "Local-first Slurm submissions over SSH"
  homepage "https://hpcd.dev"
  url "https://github.com/vertices-solutions/orbit/archive/refs/tags/v0.10.1.tar.gz"
  sha256 "ac213829e11ef5cf896edc8017a9977b58e4a6978087c83af4194a55474e97f5"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/vertices-solutions/homebrew-orbit/releases/download/orbit-0.10.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "b500574ff50fab2869d7e45ff5817403f2692bb3d71f1e20074316858ba7c684"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2830b718f515745e0a6e1f5997928a78c1693dc93aa71f8dec36a5030701a322"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5506b1d214b2a1cf31d649d49fcaaa7f33f62a08d1d2fd1330b79653578ed76c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7a2b2ba7e51839b7a3c16f8fe978507cfa1e6abd625f65f8b3ed3fc9cccc9d3b"
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
