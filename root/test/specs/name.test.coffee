"use strict"

chai = require('chai')
grunt = require('grunt')

assert = chai.assert
chai.Assertion.includeStack = true

# See http://visionmedia.github.io/mocha/ for Mocha tests.
# See http://chaijs.com/api/assert/ for Chai assertion types.

module.exports =
  before: (done) ->
    # setup here if necessary
    done()
  "Test {%= short_name %} with":
    "default_options": (done) ->
      actual = grunt.file.read 'test/tmp/default_options'
      expected = grunt.file.read 'test/expected/default_options'
      assert.equal actual, expected, 'should describe what the default behavior is.'
      done()
    "custom_options": (done) ->
      actual = grunt.file.read 'test/tmp/custom_options'
      expected = grunt.file.read 'test/expected/custom_options'
      assert.equal actual, expected, 'should describe what the custom option(s) behavior is.'
      done()
