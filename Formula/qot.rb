class Qot < Formula
  desc "Quantum of Thought: capture a note from anywhere (`qot get milk`)"
  homepage "https://quantumofthought.com"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/aegatlin/qot/releases/download/cli/v0.5.0/qot_cli-aarch64-apple-darwin.tar.xz"
      sha256 "7ef0a3aa9c88eece40084811c5773e56d2e9603ec72645f7fdd08ef139b8f5a2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aegatlin/qot/releases/download/cli/v0.5.0/qot_cli-x86_64-apple-darwin.tar.xz"
      sha256 "3c3239e8451f1fd667caf3e90ae1a78e075cffc01cb24066cfff8b83b995f447"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/aegatlin/qot/releases/download/cli/v0.5.0/qot_cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "68adf60621f5e4302aaf28fbb5ace877025ab9da687a721e5144c4dd7eedc7c4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/aegatlin/qot/releases/download/cli/v0.5.0/qot_cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "916697601411ba76ff722a873a19cc0822aa773cf6bffcef5c41c43a9f3ca0d1"
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
