class Pibox < Formula
  desc "Throwaway Linux VMs for running coding agents on untrusted work"
  homepage "https://github.com/Giardi77/pibox"
  url "https://github.com/Giardi77/pibox/archive/refs/tags/1.2.1.tar.gz"
  sha256 "54082238e69a7b38af4f3ff3f1f2a3dbb6b596d485b6e05d0b9c25f0155d37c5"
  license "MIT"

  depends_on "lima"

  def install
    bin.install "bin/pibox"
    pkgshare.install "templates"
  end

  def post_install
    templates_dir = "#{Dir.home}/.pibox/templates"
    unless File.exist?("#{templates_dir}/default.yaml")
      mkdir_p templates_dir
      cp "#{pkgshare}/templates/default.yaml", "#{templates_dir}/default.yaml"
    end
  end

  def caveats
    <<~EOS
      pibox is installed. Default template seeded at ~/.pibox/templates/default.yaml
      (only on first install — subsequent upgrades don't touch your templates).

      Quick start:
        cd ~/projects/your-project
        pibox new test
    EOS
  end

  test do
    system bin/"pibox", "--help"
  end
end
