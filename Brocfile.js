require('coffee-script/register');
var mergeTrees = require('broccoli-merge-trees')

module.exports = mergeTrees([
  require('./build/js')
]);
