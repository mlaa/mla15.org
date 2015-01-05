/* grunt-manifest */

'use strict';

module.exports = {
  generate: {
    options: {
      basePath: 'app',
      network: ['*'],
      fallback: ['/ /'],
      verbose: true,
      timestamp: true
    },
    src: [
      'data/*.json',
      'img/maps/mla/*.png',
      'img/maps/vcc/*.png'
    ],
    dest: 'app/build/cache.manifest'
  }
};
