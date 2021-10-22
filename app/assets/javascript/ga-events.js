gaEvents = {
  linkClass: '.ga-pageLink',
  searchTimer: null,

  init: function () {
    let self = this;

    // don't bind anything if the GA object isn't defined
    if (typeof window.gtag !== 'undefined') {
      self.trackSearchEvents();

      if ($(self.linkClass).length) {
        self.trackLinks();
      }
      if ($("a[rel^=external]").length) {
        self.trackExternalLinks();
      }
    }
  },

  trackSearchEvents: function() {
    clearTimeout(self.searchTimer);

    // The search box can take a while to load so we delay this a bit
    // Also there are two ways of triggering the search: pressing enter in
    // the search input, or clicking the search button (either with mouse or
    // with the keyboard, with enter or space bar).
    //
    self.searchTimer = setTimeout(function() {
      $('input.gsc-input').on('keyup', function(e) {
        if (e.key === 'Enter' || e.keyCode === 13) {
          gtag('event', 'search');
        }
      });

      $('button.gsc-search-button').click(function() {
        gtag('event', 'search');
      });
    }, 500);
  },

  trackLinks: function () {
    let self = this,
        $links = $(self.linkClass);

    $links.on('click', function(e) {
      let $el = $(this),
          url = this.href;

      e.preventDefault();

      gtag('event', 'click', {
        'event_category': $el.data('ga-category'),
        'event_label': $el.data('ga-label'),
        'event_callback': function(){ document.location = url }
      });
    });
  },

  // This function will not send to GA the query string, as frequently
  // this may contain personal identification or secure tokens.
  trackExternalLinks: function() {
    $("a[rel^=external]").on('click', function(e) {
      let $el = this,
          url = $el.href,
          event_url = url.replace($el.search, '');

      e.preventDefault();

      gtag('event', 'click', {
        'event_category': 'outbound',
        'event_label': event_url,
        'event_callback': function(){ document.location = url }
      });
    });
  }
};

$(document).on("turbolinks:load", function() {
  gaEvents.init();
});
