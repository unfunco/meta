require "fileutils"
require "open3"
require "tmpdir"
require "yaml"

root = File.expand_path("..", __dir__)
workflow = YAML.load_file("#{root}/.github/workflows/verify-go.yaml")
steps = workflow.fetch("jobs").fetch("verify").fetch("steps")
script = steps.find { |step| step["name"] == "Check formatting" }.fetch("run")

cases = {
  "formatted" => ["package fixture\n\nfunc Value() int { return 1 }\n", true],
  "unformatted" => ["package fixture\nfunc Value()int{return 1}\n", false],
  "invalid syntax" => ["package fixture\n\nfunc Broken( {\n", false]
}

cases.each do |name, (source, expected_success)|
  Dir.mktmpdir("verify-go-format-") do |directory|
    FileUtils.cp("#{root}/tests/fixtures/go/go.mod", directory)
    File.write("#{directory}/fixture.go", source)
    output, status = Open3.capture2e(
      {"GOWORK" => "off"},
      "bash", "--noprofile", "--norc", "-e", "-o", "pipefail", "-c", script,
      chdir: directory
    )
    unless status.success? == expected_success
      raise "#{name}: unexpected exit status #{status.exitstatus}\n#{output}"
    end
    puts "#{name}: passed"
  end
end
