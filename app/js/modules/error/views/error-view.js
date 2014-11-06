/* Error view */

'use strict';

module.exports = function (Module, App, Backbone) {

  var ItemView = Backbone.Marionette.ItemView.extend({

    tagName: 'li',
    template: App.Templates['app/js/modules/error/templates/error.tmpl'],

    className: function () {
      return this.model.attributes.type || this.model.attributes.style || null;
    },

    initialize: function () {
      // Swap in alternate template when needed.
      if (this.model.attributes.type) {
        this.template = App.Templates['app/js/modules/error/templates/error-head.tmpl'];
      }
    }

  });

  var CollectionView = Backbone.Marionette.CollectionView.extend({

    childView: ItemView,
    tagName: 'ul',
    className: 'error list',

    events: {
      'click .filter-head': 'editFilters'
    },

    editFilters: function (e) {
      e.preventDefault();
      Backbone.history.navigate('filter', true);
    }


  });

  Module.Views = Module.Views || {};
  Module.Views.Error = {
    ItemView: ItemView,
    CollectionView: CollectionView
  };

};
