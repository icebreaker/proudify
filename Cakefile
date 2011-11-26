fs = require 'fs'
{exec} = require 'child_process'
print = console.log

system_with_echo = ( cmd ) ->
  print cmd
  exec cmd, ( err, stdout, stderr ) ->
    throw err if err
    if stdout.length || stderr.length
      print stdout + stderr

set_extension = ( filename, ext ) ->
  filename.substr( 0, filename.lastIndexOf( '.' ) ) + ext

copy_file = ( src, dst ) ->
  fs.readFile src, 'utf8', ( err, text ) ->
    throw err if err
    fs.writeFile dst, text, ( err ) ->
      throw err if err

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
  system_with_echo "coffee -o #{output} -j #{filename} -c src/service.coffee src/services src/proudify.coffee"

task 'minify', 'minifies proudify (YUI compressor)', ( options ) ->
  [ output, filename ] = get_options options

  js_minified = set_extension filename, '.min.js'
  css_minified = set_extension css_filename, '.min.css'

  system_with_echo "java -jar /opt/bin/yuic.jar --nomunge #{output}/#{filename} -o #{output}/#{js_minified}"
  system_with_echo "java -jar /opt/bin/yuic.jar --nomunge #{css_filename} -o #{output}/#{css_minified}"

task 'release', 'builds and minifies proudify', ( options ) ->
  invoke 'build'
  invoke 'minify'

  [ output, filename ] = get_options options

  files = [ set_extension( css_filename, '.min.css' ),
            filename,
            set_extension( filename, '.min.js' ) ]

  for file in files
    copy_file "#{output}/#{file}", file
