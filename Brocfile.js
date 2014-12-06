// var filterCoffeeScript = require('broccoli-coffee')
// var filterTemplates = require('broccoli-template')
// var uglifyJavaScript = require('broccoli-uglify-js')
// var compileSass = require('broccoli-sass')
var pickFiles = require('broccoli-static-compiler')
var mergeTrees = require('broccoli-merge-trees')
var broccoliConcat = require('broccoli-concat')
// var findBowerTrees = require('broccoli-bower')
// var env = require('broccoli-env').getEnv()

app = pickFiles('app', {
  srcDir: '/',
  destDir: 'cabbage/js/app'
});

vendor = pickFiles('vendor', {
  srcDir: '/',
  destDir: 'cabbage/js/vendor'
});

project = mergeTrees([vendor, app]);

scripts = broccoliConcat(project, {
  inputFiles: [
    'cabbage/js/vendor/**/*.js',
    'cabbage/js/app/**/*.js'
  ],
  outputFile: '/js/app.js',
  wrapInFunction: false
});

module.exports = mergeTrees([scripts])
