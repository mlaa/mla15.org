/* grunt-contrib-concat */

'use strict';

module.exports = {
  app: {
    files: {
      'app/build/src/app.js': [
        'app/js/*/**/*.js',
        'app/js/main.js'
      ]
    }
  }
};
