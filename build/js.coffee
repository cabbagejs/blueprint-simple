staticCompiler = require('broccoli-static-compiler')
mergeTrees = require('broccoli-merge-trees')
broccoliConcat = require('broccoli-concat')

files = require('./build-file-config')()
env = require('./env')()
_ = require('underscore')

NAMESPACE = "cabbage/js"

buildTree = ->

  js = merge(
    sourceTree("vendor/js"),
    sourceTree("app/js"),
    sourceTree("spec", env == "development")
  )

  merge(
    concat(js, "app"),
    concat(js, "spec", env == "development"),
  )

sourceTree = (name, include = true) ->
  return if !include
  staticCompiler name,
    srcDir: '/'
    destDir: "#{NAMESPACE}/#{name}"

merge = (trees...) ->
  mergeTrees(_(trees).compact())

concat = (jsTree, name, include = true) ->
  return if !include
  broccoliConcat jsTree,
    inputFiles: _(files.concat.js[name]).map (path) -> "#{NAMESPACE}/#{path}"
    outputFile: "/js/#{name}.js"
    wrapInFunction: false
    allowNone: true

module.exports = buildTree()
