/* grunt-browserify */

'use strict';

module.exports = {
  dist: {
    files: {
      'app/build/src/app.bundle.js': [
        'app/js/main.js'
      ]
    }
  }
};
