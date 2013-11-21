###
grunt-example
https://github.com/weareinteractive/grunt-init-gruntplugin

Copyright (c) 2013 franklin
Licensed under the MIT license.
###

"use strict"

module.exports = (grunt) ->

  # Please see the grunt documentation for more information regarding task and
  # helper creation: https://github.com/cowboy/grunt/blob/master/docs/toc.md

  # -----------------------------------------------------------------------------------------------
  # ~ Tasks
  # -----------------------------------------------------------------------------------------------

  grunt.registerMultiTask 'example', 'The best Grunt plugin ever.', ->
    # Merge task-specific and/or target-specific options with these defaults.
    options = @options
      punctuation: '.'
      separator: ', '

    # Iterate over all specified file groups.
    @files.forEach (f) ->
      # Read file source.
      src = f.src.filter((filepath) ->
        # Concat specified files.
        unless grunt.file.exists(filepath)
          # Warn on and remove invalid source files (if nonull was set).
          grunt.log.warn "Source file \"" + filepath + "\" not found."
          false
        else
          true
      ).map((filepath) ->
        grunt.file.read filepath
      ).join(grunt.util.normalizelf(options.separator))

      # Handle options.
      src += options.punctuation

      # Write the destination file.
      grunt.file.write f.dest, src

      # Print a success message.
      grunt.log.writeln "File \"" + f.dest + "\" created."
