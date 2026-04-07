class Gerry < Formula
  desc "CLI tool for Gerrit code review workflows"
  homepage "https://github.com/drakeaharper/gerrit-cli"
  url "https://github.com/drakeaharper/gerrit-cli/archive/refs/tags/v0.6.2.tar.gz"
  sha256 "56bf23c1cefdb2afcacdfab15a649f8ff130d04db04a48cd3d346ea558aa32bf"
  head "https://github.com/drakeaharper/gerrit-cli.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -X main.Version=#{version}
      -X main.BuildTime=#{time.iso8601}
    ]
    system "go", "build", *std_go_args(ldflags:), "./cmd/gerry"
    man1.install "gerry.1"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gerry version")
  end
end
