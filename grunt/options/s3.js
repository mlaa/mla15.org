/* grunt-aws */

'use strict';

module.exports = {
  options: {
    accessKeyId: process.env.AWS_ACCESS_KEY_ID,
    secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
    region: process.env.AWS_DEFAULT_REGION
  },
  staging: {
    options: {
      bucket: 'staging.mla15.org'
    },
    files: [
      {
        cwd: 'app/build/',
        src: '**/*'
      },
      {
        cwd: 'app/html/',
        src: 'robots.txt'
      },
      {
        cwd: 'app/data/',
        src: '*',
        dest: 'data/'
      },
      {
        cwd: 'app/img/',
        src: '**/*',
        dest: 'img/'
      },
      {
        cwd: 'app/js/',
        src: '**/*.js',
        dest: 'js/'
      }
    ]
  },
  live: {
    options: {
      bucket: 'mla15.org'
    },
    files: [
      {
        cwd: 'app/build/',
        src: '**/*'
      },
      {
        cwd: 'app/data/',
        src: '*',
        dest: 'data/'
      },
      {
        cwd: 'app/img/',
        src: '**/*',
        dest: 'img/'
      },
      {
        cwd: 'app/js/',
        src: '**/*.js',
        dest: 'js/'
      }
    ]
  }
};
