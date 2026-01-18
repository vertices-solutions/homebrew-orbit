class OrbitAT01 < Formula
  desc "Local-first Slurm submissions over SSH"
  homepage "https://vertices.solutions"
  url "https://github.com/vertices-solutions/orbit/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "2b6a8f9be64af620223294b1e788c97e0ade04e663fb98cb6db68a8506180a28"
  license "AGPL-3.0-only"
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
