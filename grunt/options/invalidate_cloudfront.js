/* grunt-invalidate-cloudfront */

'use strict';

module.exports = {
  options: {
    key: process.env.AWS_ACCESS_KEY_ID,
    secret: process.env.AWS_SECRET_ACCESS_KEY
  },
  staging: {
    options: {
      distribution: 'E30TABZRCX2VMD'
    },
    files: [
      {
        expand: true,
        cwd: 'app/',
        src: ['data/*.json'],
        filter: 'isFile',
        dest: ''
      },
      {
        expand: true,
        cwd: 'app/build/',
        src: [
          'index.html',
          'cache.manifest',
          'src/main.min.css',
          'src/app.min.js'
        ],
        filter: 'isFile',
        dest: ''
      }
    ]
  },
  live: {
    options: {
      distribution: ''
    },
    files: [
      {
        expand: true,
        cwd: 'app/',
        src: ['data/*.json'],
        filter: 'isFile',
        dest: ''
      },
      {
        expand: true,
        cwd: 'app/build/',
        src: [
          'index.html',
          'cache.manifest',
          'src/main.min.css',
          'src/app.min.js'
        ],
        filter: 'isFile',
        dest: ''
      }
    ]
  }
};
