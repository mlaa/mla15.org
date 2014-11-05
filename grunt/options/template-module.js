/* grunt-template-module */

module.exports = {
compile: {
  options: {
    module: true,
    provider: 'underscore'
  },
  files: {
    'app/build/src/compiled-templates.js': [
      'app/js/**/*.tmpl'
    ]
  }
}
};
