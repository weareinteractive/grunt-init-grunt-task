###
grunt-example
https://github.com/weareinteractive/grunt-init-gruntplugin

Copyright (c) 2013 franklin
Licensed under the MIT license.
###

module.exports = (grunt) ->
  "use strict"

  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON "package.json"

    coffeelint:
      files: ["Gruntfile.coffee", "tasks/**/*.coffee", "test/**/*.coffee"]
      options:
        max_line_length:
          value: 200
          level: "error"

    # Before generating any new files, remove any previously-created files.
    clean:
      tests: ['test/tmp']

    # Configuration to be run (and then tested).
    example:
      default_options:
        files:
          'test/tmp/default_options': ['test/fixtures/testing', 'test/fixtures/123']
      custom_options:
        options:
          separator: ': '
          punctuation: ' !!!'
        files:
          'test/tmp/custom_options': ['test/fixtures/testing', 'test/fixtures/123']

    # Unit tests.
    mochacov:
      options:
        bail: true
        ui: 'exports'
        require: 'coffee-script'
        compilers: ['coffee:coffee-script']
        files: 'test/specs/**/*.coffee'
      all:
        options:
          reporter: 'spec'

    # Deployment
    bumper:
      options:
        tasks: ["default"]
        files: ["package.json"]
        updateConfigs: ["pkg"]


  # Actually load this plugin's task(s).
  grunt.loadTasks 'tasks'

  # These plugins provide necessary tasks.
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks "grunt-mocha-cov"
  grunt.loadNpmTasks "grunt-bumper"

  # By default, lint and run all tests.
  grunt.registerTask 'default', ['coffeelint']

  # Whenever the "test" task is run, first clean the "tmp" dir, then run this plugin's task(s), then test the result.
  grunt.registerTask 'test', ['default', 'clean', 'example', 'mochacov']
