class Qot < Formula
  desc "Quantum of Thought: capture a note from anywhere (`qot get milk`)"
  homepage "https://quantumofthought.com"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/aegatlin/qot/releases/download/cli/v0.3.0/qot_cli-aarch64-apple-darwin.tar.xz"
      sha256 "7707e96445010f270977965a4b5710956d6fd4d9e89647058f3ad2e5ad63f26d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aegatlin/qot/releases/download/cli/v0.3.0/qot_cli-x86_64-apple-darwin.tar.xz"
      sha256 "c0e3708f5934d988c6ec5eb4c1550499c3ceb4929b483b3252a6f17f8a63d80a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/aegatlin/qot/releases/download/cli/v0.3.0/qot_cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7eb8500acd30c22a84d4d8302117130ca39cf5a3cdc9ecbdd9e274a879ff5fd5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aegatlin/qot/releases/download/cli/v0.3.0/qot_cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4f2ab61b6717f2ba33ffb23fc94890cfaae55f52773830444b0d400389ca18c7"
    end
  end
  license "AGPL-3.0-only"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "qot"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "qot"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "qot"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "qot"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
