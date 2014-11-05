/* AWS credentials */

'use strict';

var grunt = require('grunt');
module.exports = grunt.file.readJSON('aws-credentials.json');
