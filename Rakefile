require 'puppetlabs_spec_helper/rake_tasks'

PuppetLint.configuration.log_format = '%{path}:%{line}:%{check}:%{KIND}:%{message}' # rubocop:disable Style/FormatStringToken
PuppetLint.configuration.fail_on_warnings = true
PuppetLint.configuration.send('disable_140chars')
PuppetLint.configuration.send('disable_documentation')
exclude_paths = ['spec/**/*.pp', 'pkg/**/*.pp']
PuppetLint.configuration.ignore_paths = exclude_paths
PuppetSyntax.exclude_paths = exclude_paths

desc 'Auto-correct puppet-lint offenses'
task 'lint:auto_correct' do
  PuppetLint.configuration.fix = true
  Rake::Task[:lint].invoke
end
