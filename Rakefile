require 'rake'
require 'spec'
require 'spec/rake/spectask'

desc 'Run Specs'
Spec::Rake::SpecTask.new do |t|
    t.spec_files = Rake::FileList['spec/**/*_spec.rb']
      t.spec_opts = ['-cufn']
end

task :default => [:spec]

