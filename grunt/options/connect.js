/* grunt-contrib-connect */

'use strict';

module.exports = {
  server: {
    options: {
      base: [
        'app/',
        'app/build/'
      ],
      hostname: '*',
      livereload: true,
      open: true,
      port: 8000
    }
  }
};
