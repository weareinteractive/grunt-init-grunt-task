###
{%= name %}
{%= homepage %}

Copyright (c) {%= grunt.template.today('yyyy') %} {%= author_name %}
Licensed under the {%= licenses.join(', ') %} license{%= licenses.length === 1 ? '' : 's' %}.
###

'use strict'

module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON "package.json"

    coffeelint:
      files: ["Gruntfile.coffee", "src/**/*.coffee", "test/**/*.coffee"]
      options:
        max_line_length:
          value: 200
          level: "error"

    coffee:
      tasks:
        options:
          bare: true
        files:
          "tasks/{%= short_name %}.js": "src/{%= short_name %}.coffee"

    # Before generating any new files, remove any previously-created files.
    clean:
      tests: ['test/tmp']

    # Configuration to be run (and then tested).
    {%= short_name %}:
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
    mochaTest:
      test:
        options:
          bail: true
          ui: 'exports'
        src: ['test/specs/**/*.test.coffee']

    # Deployment bump.
    bump:
      options:
        pushTo: 'origin'
        commitFiles: ['-a']
        updateConfigs: ['pkg']
        files: ['package.json']


  # Actually load this plugin's task(s).
  grunt.loadTasks 'tasks'

  # These plugins provide necessary tasks.
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-mocha-test"
  grunt.loadNpmTasks "grunt-bump"

  # By default, lint and run all tests.
  grunt.registerTask 'default', ['coffeelint', 'coffee']

  # Whenever the "test" task is run, first clean the "tmp" dir, then run this plugin's task(s), then test the result.
  grunt.registerTask 'test', ['default', 'clean', '{%= short_name %}', 'mochaTest']
