class Searchtool < Formula
  desc "Local citation-grounded research CLI using Wikipedia and Ollama"
  homepage "https://github.com/stavrosmavros/searchtool"
  url "https://github.com/stavrosmavros/searchtool/archive/refs/tags/v0.1.0.tar.gz"
  version "0.1.0"
  sha256 "8b25b0017951ab4955a4df027ee0c4abe2ea50c437cbcca4d123cdc8f94bf95c"

  depends_on "python@3.11"
  depends_on "ollama"

  def install
    libexec.install Dir["*"]

    system "python3", "-m", "pip", "install",
           "requests",
           "beautifulsoup4",
           "lxml",
           "--target=#{libexec}/vendor",
           "--no-deps"

    (bin/"searchtool").write <<~EOS
      #!/bin/sh
      export PYTHONPATH="#{libexec}/vendor"
      exec python3 "#{libexec}/searchtool.py" "$@"
    EOS
  end
end
