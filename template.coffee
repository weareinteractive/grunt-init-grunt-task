###
grunt-init-grunt-task
https://github.com/weareinteractive/grunt-init-grunt-task

Copyright (c) 2013 We Are Interactive, "Cowboy" Ben Alman, contributors
Licensed under the MIT license.
###
"use strict"

# Basic template description.
exports.description =
  """
  Create a Grunt plugin, including CoffeeScript, Mocha tests, Chai and Bump.Creates an ExtendScript project.
  """

# Template-specific notes to be displayed before question prompts.
exports.notes =
  """
  For more information about Grunt plugin best practices,
  please see the docs at http://gruntjs.com/creating-plugins
  """

# Template-specific notes to be displayed after question prompts.
exports.after =
  """
  You should now install project dependencies with _npm install_.
  After that, you may execute project tasks with _grunt_.
  For more information about installing and configuring Grunt,
  please see the Getting Started guide:

  http://gruntjs.com/getting-started
  """

# Any existing file or directory matching this wildcard will cause a warning.
exports.warnOn = "*"

# The actual init template.
exports.template = (grunt, init, done) ->

  init.process({type: "grunt"}, [
    # Prompt for these values.
    init.prompt("name", (value, props, done) ->
      # Prepend grunt- to default name.
      name = "grunt-#{value}"
      # Replace 'grunt-contrib' with 'grunt' and give a warning
      contribRe = /^grunt-contrib/
      if contribRe.test(name)
        grunt.log.writelns(("Removing 'contrib' from your project's name. The grunt-contrib " + "namespace is reserved for tasks maintained by the grunt team.").red)
        name = name.replace(contribRe, "grunt")
      done(null, name)
    )
    init.prompt("description", "The best Grunt plugin ever.")
    init.prompt("version")
    init.prompt("repository")
    init.prompt("homepage")
    init.prompt("bugs")
    init.prompt("licenses")
    init.prompt("author_name")
    init.prompt("author_email")
    init.prompt("author_url")
    init.prompt("grunt_version")
    init.prompt("node_version", grunt.package.engines.node)
  ], (err, props) ->

    # Set a few grunt-plugin-specific properties.
    props.short_name = props.name.replace(/^grunt[\-_]?/, "").replace(/[\W_]+/g, "_").replace(/^(\d)/, "_$1")
    props.main = "Gruntfile.coffee"
    props.npm_test = "grunt test"
    props.keywords = ["gruntplugin"]
    props.devDependencies = {
      "chai": "~1.8.0"
      "grunt-coffeelint": "0.0.7"
      "grunt-contrib-clean": "~0.5.0"
      "grunt-mocha-cov": "0.0.7"
      "coffee-script": "~1.6.3"
      "grunt-bumper": "~1.0.0"
    }

    props.peerDependencies = { "grunt":props.grunt_version }

    # Files to copy (and process).
    files = init.filesToCopy(props)

    # Add properly-named license files.
    init.addLicenseFiles(files, props.licenses)

    # Actually copy (and process) files.
    init.copyAndProcess(files, props)

    # Generate package.json file.
    init.writePackageJSON("package.json", props)

    # All done!
    done()
  )