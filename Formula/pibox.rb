class Pibox < Formula
  desc "Throwaway Linux VMs for running coding agents on untrusted work"
  homepage "https://github.com/Giardi77/pibox"
  url "https://github.com/Giardi77/pibox/archive/refs/tags/1.2.3.tar.gz"
  sha256 "bdd702349644394d96b93d1736d9806cc90d5b7db261babad12fe56d4a4ac779"
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
