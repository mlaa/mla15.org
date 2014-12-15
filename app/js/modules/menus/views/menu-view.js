/* Menu views */

'use strict';

module.exports = function (Module, App, Backbone) {

  var ItemView = Backbone.Marionette.ItemView.extend({

    tagName: 'li',
    template: App.Templates['app/js/modules/menus/templates/menu-item.tmpl'],

    className: function () {
      return this.model.attributes.type || this.model.attributes.style || null;
    },

    serializeData: function () {
      return this.model.toJSON();
    },

    initialize: function () {

      // Swap in alternate template when needed.
      if (this.model.attributes.type) {
        this.template = App.Templates['app/js/modules/menus/templates/menu-head.tmpl'];
      }

      if (this.model.attributes.href) {
        this.template = App.Templates['app/js/modules/menus/templates/menu-item-external.tmpl'];
      }

      if (this.model.attributes.childClass) {
        this.template = App.Templates['app/js/modules/menus/templates/menu-item-icon.tmpl'];
      }

    }

  });

  var CollectionView = Backbone.Marionette.CollectionView.extend({

    childView: ItemView,
    tagName: 'ul',
    className: 'list',

    events: {
      'click a': 'saveMenuState'
    },

    // When user leaves, save scroll position.
    saveMenuState: function () {
      App.vent.trigger('menu:saveMenuState');
    }

  });

  var MapCollectionView = Backbone.Marionette.CollectionView.extend({

    childView: ItemView,
    tagName: 'ul',
    className: 'list',

    events: {
      'click .head': 'loadParentMenu'
    },

    loadParentMenu: function (e) {
      e.preventDefault();
      App.vent.trigger('menu:showParent', 'maps');
    }

  });

  Module.Views = Module.Views || {};
  Module.Views.Menu = {
    ItemView: ItemView,
    CollectionView: CollectionView,
    MapCollectionView: MapCollectionView
  };

};
