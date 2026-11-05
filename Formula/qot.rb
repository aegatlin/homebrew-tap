class Qot < Formula
  desc "Quantum of Thought: capture a note from anywhere (`qot get milk`)"
  homepage "https://quantumofthought.com"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/aegatlin/qot/releases/download/cli/v0.1.0/qot_cli-aarch64-apple-darwin.tar.xz"
      sha256 "ea46067ef025cf72162349cd98f2092f626eaa49843512712a260b5b5169369e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aegatlin/qot/releases/download/cli/v0.1.0/qot_cli-x86_64-apple-darwin.tar.xz"
      sha256 "282dd016e592d2d93a036f6fee35debd150bd2bed7500bbe4493ffb464f5e3d6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/aegatlin/qot/releases/download/cli/v0.1.0/qot_cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "03d4337709a0448fc5b41cf4f6b92789b7878820e2f18f353fb969f00dfdbd75"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aegatlin/qot/releases/download/cli/v0.1.0/qot_cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "870bf7c14953ee77d5ce651d12942c628b5fda6db2fcd536bfe15f0388fd674e"
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
