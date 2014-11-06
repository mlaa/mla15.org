/* Filter data */

'use strict';

module.exports = function (Module, App, Backbone) {

  var _ = Backbone._;

  var filters = [
    {
      style: 'filter-head',
      title: 'Filters'
    },
    {
      style: 'subhead',
      title: 'Day'
    },
    {
      type: 'day',
      href: 'th',
      title: 'Thursday, 9 January'
    },
    {
      type: 'day',
      href: 'fr',
      title: 'Friday, 10 January'
    },
    {
      type: 'day',
      href: 'sa',
      title: 'Saturday, 11 January'
    },
    {
      type: 'day',
      href: 'su',
      title: 'Sunday, 12 January'
    },
    {
      style: 'subhead',
      title: 'Time'
    },
    {
      type: 'tod',
      href: 'mor',
      title: 'Morning'
    },
    {
      type: 'tod',
      href: 'aft',
      title: 'Afternoon'
    },
    {
      type: 'tod',
      href: 'eve',
      title: 'Evening'
    },
    {
      type: 'tod',
      href: 'ln',
      title: 'Late-Night'
    },
    {
      style: 'subhead',
      title: 'Location'
    },
    {
      type: 'venue',
      href: 'sh',
      title: 'Sheraton'
    },
    {
      type: 'venue',
      href: 'ma',
      title: 'Marriott'
    },
    {
      type: 'venue',
      href: 'fa',
      title: 'Fairmont'
    },
    {
      type: 'venue',
      href: 'eh',
      title: 'Exhibit Hall Theater'
    },
    {
      type: 'venue',
      href: 'off',
      title: 'Elsewhere'
    },
    {
      style: 'subhead',
      title: 'Session Type'
    },
    {
      type: 'type',
      href: 'pub',
      title: 'Open to the Public'
    },
    {
      type: 'type',
      href: 'soc',
      title: 'Social Event'
    },
    {
      type: 'type',
      href: 'pre',
      title: 'Presidential Theme'
    },
    {
      style: 'button',
      title: 'Apply'
    }
  ];

  var categories = {
    'th':  'Thursday',
    'fr':  'Friday',
    'sa':  'Saturday',
    'su':  'Sunday',
    'mor': 'Morning',
    'aft': 'Afternoon',
    'eve': 'Evening',
    'ln':  'Late-Night',
    'sh':  'Sheraton',
    'ma':  'Marriott',
    'fa':  'Fairmont',
    'eh':  'Exhibit Hall Theater',
    'off': 'Elsewhere',
    'pub': 'Open to the Public',
    'soc': 'Social Event',
    'pre': 'Presidential Theme'
  };

  // Get description of the current filters.
  Module.GetFilterDescription = function (currentFilters) {

    var filterDescription = 'Filters';

    if (currentFilters.length) {
      filterDescription += ': ' + _.map(currentFilters, function (filter) {
        return categories[filter];
      }).join(', ');
    }

    return filterDescription;

  };

  // Loop through data and "activate" selected filters
  Module.GetActiveFilters = function (selectedFilters) {
    return _.map(filters, function (filter) {
      if (selectedFilters.indexOf(filter.href) !== -1) {
        filter.active = 'active';
      } else {
        filter.active = '';
      }
      return filter;
    });
  };

};
