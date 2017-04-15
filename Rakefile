# frozen_string_literal: true

desc "Starts server in local env"
task :local do
  sh 'ruby ./app.rb CONFIG=local'
end

desc "Starts server in test env"
task :test do
  sh 'ruby ./app.rb CONFIG=test'
end

desc "Starts server in production env"
task :production do
  sh 'ruby ./app.rb CONFIG=production'
end
