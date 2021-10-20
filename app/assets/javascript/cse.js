window.addEventListener("DOMNodeInserted", function() {
  // Getting rid of the pesky hardcoded inline styles pulled from google,
  // so we can override them to give the controls a more govuk appearance.
  document.querySelectorAll('input.gsc-input').forEach(function(e) {
    e.removeAttribute('style')
  })
});
