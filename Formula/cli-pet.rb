class CliPet < Formula
  desc "Tiny desktop pet that floats above your terminal and reacts to Claude Code"
  homepage "https://github.com/APapeIsName/cli-pet"
  url "https://github.com/APapeIsName/cli-pet/archive/refs/tags/v0.1.6.tar.gz"
  sha256 "c0969199efcc48e1b3a7b0c5e83df7659406bf5cbfbe998b57c272699c458d1e"
  license "MIT"
  head "https://github.com/APapeIsName/cli-pet.git", branch: "main"

  depends_on :macos

  def install
    system "./build.sh"
    libexec.install "CLIPet.app"
    (bin/"cli-pet").write_exec_script libexec/"CLIPet.app/Contents/MacOS/cli-pet"
  end

  def caveats
    <<~EOS
      Show the pet:
        cli-pet start

      Connect Claude Code and start at login (backs up ~/.claude/settings.json):
        cli-pet install
      Or connect with the Claude Code plugin instead:
        cli-pet install --no-hooks
        /plugin marketplace add APapeIsName/cli-pet
        /plugin install cli-pet@cli-pet

      Make your own pet from PNG files (normal.png, happy.png, ...):
        cli-pet pack new anime-myseries-mychar ~/path/to/pngs
        https://github.com/APapeIsName/cli-pet/blob/main/docs/custom-packs.md

      Before uninstalling, remove the hooks and login item:
        cli-pet uninstall
    EOS
  end

  test do
    assert_match "cli-pet", shell_output("#{bin}/cli-pet --help")
  end
end
