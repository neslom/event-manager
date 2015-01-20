#task :test do
    #Dir.glob('./spec/**/*_spec.rb') { |file| require file }
#end

begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec) do |t|
    t.rspec_opts = "--color --format doc"
  end

  task :default => :spec
rescue LoadError
  # no rspec available
end
