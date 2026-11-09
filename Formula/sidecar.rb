class Sidecar < Formula
  desc "Connect an iPad as a Sidecar display from the command line"
  homepage "https://github.com/aegatlin/sidecar-cli"
  url "https://github.com/aegatlin/sidecar-cli/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
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
