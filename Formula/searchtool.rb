class Searchtool < Formula
  desc "Local citation-grounded research CLI using Wikipedia and Ollama"
  homepage "https://github.com/stavrosmavros/searchtool"
  url "https://github.com/stavrosmavros/searchtool/archive/refs/heads/main.tar.gz"
  version "0.1.0"
  sha256 "a4d1eda719da7cd38c9a0af06e1890cb079c4b31da25cd5f64a9390b12b8b67e"

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
