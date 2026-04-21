class Pibox < Formula
  desc "Throwaway Linux VMs for running coding agents on untrusted work"
  homepage "https://github.com/Giardi77/pibox"
  url "https://github.com/Giardi77/pibox/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  license "MIT"

  depends_on "lima"

  def install
    bin.install "bin/pibox"
    pkgshare.install "templates"
  end

  def post_install
    templates_dir = "#{Dir.home}/.pibox/templates"
    unless File.exist?("#{templates_dir}/default.yaml")
      FileUtils.mkdir_p(templates_dir)
      FileUtils.cp("#{pkgshare}/templates/default.yaml", "#{templates_dir}/default.yaml")
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
    system "#{bin}/pibox", "--help"
  end
end
