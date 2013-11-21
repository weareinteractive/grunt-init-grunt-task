desc "Create plugin and compare"
task :test do
  system "rm -rf test/grunt-example"
  system "mkdir test/grunt-example"
  Dir.chdir("test/grunt-example") do
    system "grunt-init grunt-task"
  end
  puts "Comparing directories:"
  puts "-------------------------------------------------"
  system "diff -rq test/expected test/grunt-example"
  puts "-------------------------------------------------"
  puts "done"
  puts ""
  Dir.chdir("test/grunt-example") do
    puts "Installing depenencies"
    puts "-------------------------------------------------"
    system "npm install > /dev/null 2>&1"
    puts "done"
    puts ""
    puts "Running tests"
    puts "-------------------------------------------------"
    system "grunt test"
    puts "-------------------------------------------------"
    puts "done"
  end
end