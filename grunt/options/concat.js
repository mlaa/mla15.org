/* grunt-contrib-concat */

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
