/* grunt-contrib-cssmin */

'use strict';

module.exports = {
  app: {
    options: {
      banner: '<%= pkg.banner %>'
    },
    files: {
      'app/build/src/main.min.css': [
        'app/build/src/main.css'
      ]
    }
  }
};
