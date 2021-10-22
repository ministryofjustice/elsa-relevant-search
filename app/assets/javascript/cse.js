function fixStyling() {
  // We use a timer to avoid function from firing multiple times
  let stylingTimer;

  $('#google-custom-search').on('DOMNodeInserted', function() {
    clearTimeout(stylingTimer);

    stylingTimer = setTimeout(function () {
      // Getting rid of the pesky hardcoded inline styles pulled from google,
      // so we can override them to give the controls a more govuk appearance
      $('input.gsc-input').removeAttr('style');

      // Apply the `govuk-link` class to all links in the search results
      $('.gsc-control-cse a, .gsc-control-cse [role="link"]').addClass('govuk-link');
    }, 5);
  });
}

$(document).on('turbolinks:load', fixStyling);
