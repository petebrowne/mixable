fs       = require "fs"
coffee   = require "coffee-script"
uglify   = require "uglify-js"
{ exec } = require "child_process"

SOURCE_FILES = [ "src/mixable.coffee" ]
SPEC_FILES   = [ "spec/include-spec.coffee", "spec/extend-spec.coffee", "spec/mixable-spec.coffee" ]
VERSION      = fs.readFileSync("VERSION", "utf8").replace /\s/g, ""
HEADER       = """
/**
 * Modular.js v#{VERSION}
 * http://github.com/petebrowne/mixable
 * 
 * Copyright (c) 2011, Pete Browne
 * See LICENSE for details
 */

"""

task "build", "Build javascripts from source", ->
  buildSpecs()
  buildSource()

task "watch", "Build whenever there are changes", ->
  invoke "build"
  watchFiles SOURCE_FILES.concat(SPEC_FILES), (file) ->
    invoke "build"
      
task "spec", "Build then run specs", ->
  invoke "build"
  exec "jasmine-node spec", (error, stdout, stderr) ->
    console.log stdout
      
task "spec:browser", "Build then launch the specs in a browser", ->
  invoke "build"
  exec "open spec/index.html"
  
task "version", ->
  console.log VERSION
  
buildSource = ->
  source = (fs.readFileSync file, "utf8" for file in SOURCE_FILES).join "\n"
  source = coffee.compile source
  fs.writeFileSync "dist/mixable.js",     HEADER + source
  fs.writeFileSync "dist/mixable.min.js", HEADER + uglify source

buildSpecs = ->
  for file in SPEC_FILES
    source = fs.readFileSync file, "utf8"
    fs.writeFileSync file.replace(/\.coffee/, ".js"), coffee.compile(source)
  
watchFiles = (files, callback) ->
  for file in files
    do (file) ->
      fs.watchFile file, { persistent: true, interval: 250 }, (curr, prev) ->
        return if curr.size is prev.size and curr.mtime.getTime() is prev.mtime.getTime()
        callback file 
