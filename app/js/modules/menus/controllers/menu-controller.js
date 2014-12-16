/* Menu controller */

'use strict';

module.exports = function (Module, App, Backbone) {

  var $ = Backbone.$;

  // Element cache
  var $els = {
    body: $('body'),
    content: $('#content'),
    actions: $('#home-actions'),
    tabs: {
      all: $('#tabs li'),
      program: $('#program-tab'),
      filters: $('#program-tab'),
      people: $('#people-tab'),
      maps: $('#maps-tab'),
      info: $('#info-tab')
    }
  };

  // Active navigation tab.
  var _activateTab = function (section) {

    // Test for home page.
    var isHome = (Backbone.history.fragment === '');

    // Scroll to top of the window.
    document.body.scrollTop = document.documentElement.scrollTop = 0;

    // Remove "collapsed" class, if present.
    $els.content.removeClass('collapsed');

    // Show "skyline" expanded header on home page.
    $els.body.toggleClass('home', isHome);

    // Show actions on home page.
    $els.actions.toggle(isHome);

    // Add "here" class to show active tab.
    $els.tabs.all.removeClass('here');
    $els.tabs[section].addClass('here');

  };

  // Save menu state.
  var _saveMenuState = function () {
    Module.stateCache.push({
      fragment: Backbone.history.fragment,
      scrollPos: document.body.scrollTop || document.documentElement.scrollTop || 0
    });
  };

  // Create the appearance of restoring the parent menu.
  var _showParent = function (section) {

    // Get previous state.
    var state = Module.stateCache.pop() || Module.fallbackState;

    // Change URL.
    Backbone.history.navigate(state.fragment || section || '', true);

    // Set scroll position.
    document.body.scrollTop = document.documentElement.scrollTop = state.scrollPos;

  };

  // Generate section-level view.
  var _showMenu = function (section) {

    section = section || 'program';

    // Set menu tab.
    _activateTab(section);

    // Append the views to the content region.
    App.Content.show(new Module.Views.Menu.CollectionView({
      collection: new Module.Models.Menu.Collection(Module.Data.Menu[section])
    }));

  };

  // Menu state cache
  Module.stateCache = [];

  // Fallback menu state
  Module.fallbackState = {
    fragment: '',
    scrollPos: 0
  };

  // Bind to custom events.
  App.vent.bind('menu:tab', _activateTab);
  App.vent.bind('menu:showParent', _showParent);
  App.vent.bind('menu:saveMenuState', _saveMenuState);

  return Backbone.Marionette.Controller.extend({

    showMenu: _showMenu,

    // Maps are just a big menu.
    showMaps: function (map) {

      // Set menu tab.
      _activateTab('maps');

      if (Module.Data.Maps[map]) {
        // Append the views to the content region.
        App.Content.show(
          new Module.Views.Menu.MapCollectionView({
            collection: new Module.Models.Menu.Collection(Module.Data.Maps[map])
          })
        );
      } else {
        App.vent.trigger('error:notfound');
      }

    }

  });

};
