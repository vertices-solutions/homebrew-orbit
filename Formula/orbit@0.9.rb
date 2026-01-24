class OrbitAT09 < Formula
  desc "Local-first Slurm submissions over SSH"
  homepage "https://hpcd.dev"
  url "https://github.com/vertices-solutions/orbit/archive/refs/tags/v0.9.0.tar.gz"
  sha256 "3f899bd62cae8cbbfc8dc2fc5f002e248a7b00d4f138933a995fd68d7137d4d7"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/vertices-solutions/homebrew-orbit/releases/download/orbit-0.9.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "e46700fb1f585c63e302e8d3ef6af2b4cb7d40ea7a79f71cfc48f666d75dfca0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e2e96b3829b9a9c3b3346fce4dd7f97cec63841d1c4d166fdc62dc5054064c1d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4e52935c3814308b25002c4999119a71307818c3fb3e47ef1e13b3c84c0c69f6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e193af7793cba9423e6bc1892d545e1fa2bcdcd4afd1b5639d07362906f9f6b5"
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
