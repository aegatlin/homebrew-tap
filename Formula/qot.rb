class Qot < Formula
  desc "Quantum of Thought: capture a note from anywhere (`qot get milk`)"
  homepage "https://quantumofthought.com"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/aegatlin/qot/releases/download/cli/v0.4.0/qot_cli-aarch64-apple-darwin.tar.xz"
      sha256 "73e57c20eee228cd2a91c8e2ec6c1612cb1c6b0cc016a77c4ed5bc3c4e44cbdd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aegatlin/qot/releases/download/cli/v0.4.0/qot_cli-x86_64-apple-darwin.tar.xz"
      sha256 "ba10eacbf290f1cbb8b9aa9326fa7a23701a7ee4e18a0097220315428dd83027"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/aegatlin/qot/releases/download/cli/v0.4.0/qot_cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5457d92760a1ad0a5289920c2837ad4cb633fec3738e291f99284c26fc9c9a81"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aegatlin/qot/releases/download/cli/v0.4.0/qot_cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bfe125351219f96f1b19abda6dadd57e8d3a782465e9362c80ab2bcb9191e7d2"
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
