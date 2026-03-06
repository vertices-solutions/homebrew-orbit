class OrbitAT017 < Formula
  desc "Local-first Slurm submissions over SSH"
  homepage "https://hpcd.dev"
  url "https://github.com/vertices-solutions/orbit/archive/refs/tags/v0.17.0.tar.gz"
  sha256 "d931edb1706eaac8e2dcf239a685b31136778d38aed940797891d03480146a92"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/vertices-solutions/homebrew-orbit/releases/download/orbit-0.17.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "f12d53695a0fd3a747dbd5ad559b363649b00acedfdb90661f2685d65c68cce3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1d03ebdf19faf52eb0a772712140df0e0323bdcca55b5d4d55bdc47306bffba7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8680a8ffb074c2d46d10adabb440892c924bff7400f3444ba53a586d3203271e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "267559b8be508ddb4297db1bcdd14405d9bee557ff1b470d314090b6435f9920"
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
