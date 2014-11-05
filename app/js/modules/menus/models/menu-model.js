/* Menu */

module.exports = function (Module, App, Backbone) {

  var Model = Backbone.Model.extend({

    // Set defaults.
    defaults: {
      href: '',
      title: ''
    },

    getLinkAttributes: function () {

      var href = this.get('href');
      var target = '';

      // Determine link type by examining path/protocol.
      if (href.substring(0, 4) === 'http' || href.substring(0, 1) === '/') {
        target = ' target="_blank"';
      } else {
        href = '#' + href;
      }

      return {
        href: href,
        target: target
      };

    },

    formatTitle: function () {

      var title = this.get('title');
      var sequence = this.get('seq');
      var isRegular = /^\d+$/.test(sequence);

      return {
        title: (isRegular) ? sequence + '. ' + title : title
      };

    }

  });

  var Collection = Backbone.Collection.extend({
    model: Model
  });

  Module.Models = Module.Models || {};
  Module.Models.Menu = {
    Model: Model,
    Collection: Collection
  };

};
