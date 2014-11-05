/* grunt-contrib-uglify */

'use strict';

module.exports = {
  app: {
    options: {
      banner: '<%= pkg.banner %>',
      wrap: true
    },
    files: {
      'app/build/src/app.min.js': [
        'app/build/src/app.bundle.js'
      ]
    }
  }
};
