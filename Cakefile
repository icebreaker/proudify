fs = require 'fs'
{exec} = require 'child_process'

system_with_echo = ( cmd ) ->
  console.log cmd
  exec cmd, ( err, stdout, stderr ) ->
    throw err if err
    if stdout.length || stderr.length
      console.log stdout + stderr

set_extension = ( filename, ext ) ->
  filename.substr( 0, filename.lastIndexOf( '.' ) ) + ext

get_options = ( options ) ->
  output = options.output || default_output
  filename = options.filename || default_filename
  [ output, filename ]

default_output = 'build'
default_filename = 'jquery-proudify.js'
css_filename = 'proudify.css'

option '-o', '--output [DIR]', "output directory (default: #{default_output})"
option '-f', '--filename [FILE]', "output filename (default: #{default_filename})"

task 'build', 'builds proudify', ( options ) ->
  [ output, filename ] = get_options options
  system_with_echo "coffee -o #{output} -j #{filename} -c src/"

task 'minify', 'minifies proudify (YUI compressor)', ( options ) ->
  [ output, filename ] = get_options options

  js_minified = set_extension filename, '.min.js'
  css_minified = set_extension css_filename, '.min.css'

  system_with_echo "java -jar /opt/bin/yuic.jar --nomunge #{output}/#{filename} > #{output}/#{js_minified}"
  system_with_echo "java -jar /opt/bin/yuic.jar --nomunge #{css_filename} > #{output}/#{css_minified}"

task 'release', 'builds and minifies proudify', ( options ) ->
  invoke 'build'
  invoke 'minify'
