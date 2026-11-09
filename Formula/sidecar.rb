class Sidecar < Formula
  desc "Connect an iPad as a Sidecar display from the command line"
  homepage "https://github.com/aegatlin/sidecar-cli"
  url "https://github.com/aegatlin/sidecar-cli/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "ea4fdd7a28ffb13c141bd7389475c84794a6c0c0c2add4e4fe58740340b05cde"
  license "MIT"

  # Drives Apple's private SidecarCore framework; there is nothing to build on Linux.
  depends_on :macos

  def install
    # swiftc ships with the Command Line Tools, which Homebrew already requires.
    system "swiftc", "-O", "sidecar.swift", "-o", "sidecar"
    bin.install "sidecar"
  end

  test do
    # --help never reaches SidecarCore, so this works without an iPad.
    assert_match "sidecar connect", shell_output("#{bin}/sidecar --help")
  end
end
