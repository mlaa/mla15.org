/* Menu data */

'use strict';

module.exports = function (Module) {

  Module.Data = Module.Data || {};

  // Section-level menus
  Module.Data.Menu = {
    program: [
      {
        id: 'program/th',
        title: 'Thursday, 9 January',
        childClass: 'icon-calendar-empty'
      },
      {
        id: 'program/fr',
        title: 'Friday, 10 January',
        childClass: 'icon-calendar-empty'
      },
      {
        id: 'program/sa',
        title: 'Saturday, 11 January',
        childClass: 'icon-calendar-empty'
      },
      {
        id: 'program/su',
        title: 'Sunday, 12 January',
        childClass: 'icon-calendar-empty'
      },
      {
        id: 'filter',
        title: 'Filter by category',
        childClass: 'icon-filter'
      }
    ],
    people: [
      {
        id: 'people/A',
        title: 'A'
      },
      {
        id: 'people/B',
        title: 'B'
      },
      {
        id: 'people/C',
        title: 'C'
      },
      {
        id: 'people/D',
        title: 'D'
      },
      {
        id: 'people/E',
        title: 'E'
      },
      {
        id: 'people/F',
        title: 'F'
      },
      {
        id: 'people/G',
        title: 'G'
      },
      {
        id: 'people/H',
        title: 'H'
      },
      {
        id: 'people/I',
        title: 'I'
      },
      {
        id: 'people/J',
        title: 'J'
      },
      {
        id: 'people/K',
        title: 'K'
      },
      {
        id: 'people/L',
        title: 'L'
      },
      {
        id: 'people/M',
        title: 'M'
      },
      {
        id: 'people/N',
        title: 'N'
      },
      {
        id: 'people/O',
        title: 'O'
      },
      {
        id: 'people/P',
        title: 'P'
      },
      {
        id: 'people/Q',
        title: 'Q'
      },
      {
        id: 'people/R',
        title: 'R'
      },
      {
        id: 'people/S',
        title: 'S'
      },
      {
        id: 'people/T',
        title: 'T'
      },
      {
        id: 'people/U',
        title: 'U'
      },
      {
        id: 'people/V',
        title: 'V'
      },
      {
        id: 'people/W',
        title: 'W'
      },
      {
        id: 'people/X',
        title: 'X'
      },
      {
        id: 'people/Y',
        title: 'Y'
      },
      {
        id: 'people/Z',
        title: 'Z'
      }
    ],
    maps: [
      {
        type: 'menu-head',
        title: 'Vancouver Convention Centre East'
      },
      {
        id: 'maps/vcc-east-convention',
        title: 'Convention Level'
      },
      {
        id: 'maps/vcc-east-meeting',
        title: 'Meeting Level'
      },
      {
        type: 'menu-head',
        title: 'Vancouver Convention Centre West'
      },
      {
        id: 'maps/vcc-west-1',
        title: 'Level 1'
      },
      {
        id: 'maps/vcc-exhibit-area',
        title: 'Exhibit Area, Level 1'
      },
      {
        id: 'maps/vcc-west-2',
        title: 'Level 2'
      },
      {
        id: 'maps/vcc-west-3',
        title: 'Level 3'
      },
      {
        type: 'menu-head',
        title: 'Fairmont Waterfront'
      },
      {
        id: 'maps/fairmont-waterfront',
        title: 'Lobby Level'
      }
    ],
    info: [
      {
        type: 'menu-head',
        title: 'General Information'
      },
      {
        id: 'info/locations',
        title: 'Convention Locations'
      },
      {
        id: 'info/daily',
        title: '<em>Convention Daily</em>'
      },
      {
        id: 'info/program',
        title: 'Program Online'
      },
      {
        id: 'info/twitter',
        title: '<em>Twitter</em>'
      },
      {
        id: 'info/wifi',
        title: 'Wi-Fi Access'
      },
      {
        id: 'info/weather',
        title: 'What to Do in a Weather or Other Emergency'
      },
      {
        type: 'menu-head',
        title: 'Policies'
      },
      {
        id: 'info/taping',
        title: 'Audio- and Videotaping at Sessions'
      },
      {
        id: 'info/badges',
        title: 'Badges'
      },
      {
        id: 'info/canceling',
        title: 'Canceling Sessions'
      },
      {
        id: 'info/fragrance',
        title: 'Fragrance'
      },
      {
        id: 'info/guest-sessions',
        title: 'Guest Passes to Sessions'
      },
      {
        id: 'info/guest-exhibit-hall',
        title: 'Guest Passes to the Exhibit Hall'
      },
      {
        id: 'info/id',
        title: 'Identification'
      },
      {
        id: 'info/in-absentia',
        title: 'Reading in Absentia'
      },
      {
        id: 'info/smoking',
        title: 'Smoking'
      },
      {
        type: 'menu-head',
        title: 'MLA Registration and Welcome Centers'
      },
      {
        id: 'info/registration',
        title: 'About the MLA Registration and Welcome Centers'
      },
      {
        id: 'info/chicago',
        title: 'Chicago Information and Restaurant Reservations'
      },
      {
        id: 'info/disabilities',
        title: 'Disabilities, Facilities and Services for Persons with'
      },
      {
        id: 'info/housing',
        title: 'Housing Desk'
      },
      {
        id: 'info/membership',
        title: 'Membership Desks'
      },
      {
        id: 'info/commons',
        title: '<em>MLA Commons</em>'
      },
      {
        id: 'info/print-program',
        title: 'Print Copies of the Program'
      },
      {
        type: 'menu-head',
        title: 'On-Site Resources'
      },
      {
        id: 'info/business-centers',
        title: 'Business Centers'
      },
      {
        id: 'info/child-care',
        title: 'Child Care'
      },
      {
        id: 'info/bill-w',
        title: 'Friends of Bill W.'
      },
      {
        id: 'info/headquarters',
        title: 'Headquarters Offices'
      },
      {
        id: 'info/internet-in-hotels',
        title: 'Internet Access by Hotel Guests'
      },
      {
        id: 'info/lost-and-found',
        title: 'Lost and Found'
      },
      {
        id: 'info/lounges',
        title: 'Lounges'
      },
      {
        id: 'info/press-office',
        title: 'Press Office'
      },
      {
        id: 'info/shuttle-bus',
        title: 'Shuttle Bus Service'
      },
      {
        id: 'info/ready-rooms',
        title: 'Speaker Ready Rooms'
      },
      {
        id: 'info/transportation',
        title: 'Transportation in Chicago'
      },
      {
        id: 'info/whos-here',
        title: '“Who’s Here” Directory'
      },
      {
        type: 'menu-head',
        title: 'Job Information Center'
      },
      {
        id: 'info/jobs',
        title: 'Fairmont, Imperial Ballroom, level B2'
      },
      {
        type: 'menu-head',
        title: 'Exhibits'
      },
      {
        id: 'info/exhibit-hall',
        title: 'Exhibit Hall'
      },
      {
        id: 'program/eh',
        title: 'Exhibit Hall Theater'
      },
      {
        id: 'info/mla-booth',
        title: 'MLA Exhibit Booth (Booth 100)'
      },
      {
        type: 'menu-head',
        title: 'Event Highlights'
      },
      {
        id: 'info/excursions',
        title: 'Cultural Excursions'
      },
      {
        id: '660',
        title: 'MLA Awards Ceremony (Session 660)'
      },
      {
        id: '421',
        title: 'Presidential Address (Session 421)'
      },
      {
        id: '230',
        title: 'Presidential Forum (Session 230)'
      },
      {
        id: '155A',
        title: 'A Screening of <em>Eight Men Out</em>, a Film by John Sayles (Session 155A)'
      },
      {
        type: 'menu-head',
        title: 'Informational Sessions and Workshops'
      },
      {
        id: 'info/humanities-summit',
        title: 'Chicago Humanities Summit'
      },
      {
        id: 'info/celj',
        title: 'Council of Editors of Learned Journals'
      },
      {
        id: 'info/career-options-phds',
        title: 'Discussion of Career Options for Humanities PhDs'
      },
      {
        id: 'info/ele',
        title: 'Electronic Literature Exhibit: <em>Pathfinders: Twenty-Five Years of Experimental Literary Art</em>'
      },
      {
        id: 'info/government-careers',
        title: 'Government Careers'
      },
      {
        id: 'info/neh',
        title: 'NEH Information'
      },
      {
        type: 'menu-head',
        title: 'Governance'
      },
      {
        id: 'info/delegate-assembly',
        title: 'Delegate Assembly'
      },
      {
        type: 'menu-head',
        title: 'Emergencies'
      },
      {
        id: 'info/medical',
        title: 'Illness and Medical Emergencies'
      },
      {
        type: 'menu-head',
        title: '2015 Convention in Vancouver'
      },
      {
        id: 'info/calls-for-papers',
        title: 'Calls for Papers'
      },
      {
        id: 'info/organizing-sessions',
        title: 'Organizing Sessions'
      },
      {
        id: 'info/vancouver',
        title: 'Vancouver Information'
      }
    ]
  };

  Module.Data.Maps = {
    'vcc-east-convention': {
      title: 'Convention Level',
      imageSrc: '/img/maps/mla/vcc-east-convention.png'
    },
    'vcc-east-meeting': {
      title: 'Meeting Level',
      imageSrc: '/img/maps/mla/vcc-east-meeting.png'
    },
    'vcc-west-1': {
      title: 'Level 1',
      imageSrc: '/img/maps/mla/vcc-west-1.png'
    },
    'vcc-exhibit-area': {
      title: 'Exhibit Area, Level 1',
      imageSrc: '/img/maps/mla/vcc-exhibit-area.png'
    },
    'vcc-west-2': {
      title: 'Level 2',
      imageSrc: '/img/maps/mla/vcc-west-2.png'
    },
    'vcc-west-3': {
      title: 'Level 3',
      imageSrc: '/img/maps/mla/vcc-west-3.png'
    },
    'fairmont-waterfront': {
      title: 'Lobby Level',
      imageSrc: '/img/maps/mla/fairmont-waterfront.png'
    }
  };

};
