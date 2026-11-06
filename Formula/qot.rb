class Qot < Formula
  desc "Quantum of Thought: capture a note from anywhere (`qot get milk`)"
  homepage "https://quantumofthought.com"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/aegatlin/qot/releases/download/cli/v0.1.2/qot_cli-aarch64-apple-darwin.tar.xz"
      sha256 "0bd567912f98b995740e160c47c441fbf82824427436bdd866e200f531f060f1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aegatlin/qot/releases/download/cli/v0.1.2/qot_cli-x86_64-apple-darwin.tar.xz"
      sha256 "dedf3041c7255c7657b0d781505527008d31b4f837450ba4f68770e8f38024b6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/aegatlin/qot/releases/download/cli/v0.1.2/qot_cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "81afa620974f4235e07a9a3aa58e4469f6109b65737de3db11041f44dd2e0bc7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aegatlin/qot/releases/download/cli/v0.1.2/qot_cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b3556fb7f11e7e4c918bf7b2688064adb4ef2480ddc25ac894cb48707a7fc5f7"
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
