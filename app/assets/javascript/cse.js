window.addEventListener("DOMNodeInserted", function() {
  // Getting rid of the pesky hardcoded inline styles pulled from google,
  // so we can override them to give the controls a more govuk appearance.
  document.querySelectorAll('input.gsc-input').forEach(function(e) {
    e.removeAttribute('style')
  });

  // Apply the `govuk-link` class to all links in the search results
  document.querySelectorAll('.gsc-control-cse a, .gsc-control-cse [role="link"]').forEach(function(e) {
    e.classList.add('govuk-link')
  });
});
