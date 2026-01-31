class OrbitAT011 < Formula
  desc "Local-first Slurm submissions over SSH"
  homepage "https://hpcd.dev"
  url "https://github.com/vertices-solutions/orbit/archive/refs/tags/v0.11.0.tar.gz"
  sha256 "5b6a34c6fbd1f737e85a0ae772f5296a25b026bd86c5ca0149c58229b5549cc5"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/vertices-solutions/homebrew-orbit/releases/download/orbit-0.11.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "d3d68b7e35af208ffd6fe05866e95045fb5aefde164d4029339768b99688b63e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4ae5bbe00f7eac65a7d7aae683744ec1e960a51ab1da272f04f78aad7a5930b1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9edb200383be3467681092051684fdb6379a7daf0c6eb40103c4c4f5f5a6bc15"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6f83eafc283234bb3ef673c838c518cd5fd592b8f850c4c710bf30f41fbe0a40"
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
