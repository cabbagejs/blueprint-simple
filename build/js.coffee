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
    sourceTree("spec", env != "development")
  )

  appJs = broccoliConcat js,
    inputFiles: _(files.concat.js).map (path) -> "#{NAMESPACE}/#{path}"
    outputFile: '/js/app.js'
    wrapInFunction: false
    allowNone: true

  merge(appJs)

sourceTree = (name, include = true) ->
  return unless include
  staticCompiler name,
    srcDir: '/'
    destDir: "#{NAMESPACE}/#{name}"

merge = (trees...) ->
  mergeTrees(_(trees).compact())

module.exports = buildTree()
