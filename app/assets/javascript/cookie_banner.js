import common from 'govuk-frontend/govuk/common'

var nodeListForEach = common.nodeListForEach
var cookieBannerHideButtonSelector = '.app--js-cookie-banner-hide'

function CookieBanner($module) {
  this.$module = $module
}

CookieBanner.prototype.init = function () {
  this.$cookieBanner = this.$module
  this.$cookieBannerHideButtons = this.$module.querySelectorAll(cookieBannerHideButtonSelector)

  nodeListForEach(this.$cookieBannerHideButtons, function($cookieBannerHideButton) {
    $cookieBannerHideButton.addEventListener('click', this.hideBanner.bind(this))
  }.bind(this))
};

CookieBanner.prototype.hideBanner = function (e) {
  this.$cookieBanner.setAttribute('hidden', true)
  e.preventDefault()
};

$(document).on("turbolinks:load", function() {
  var $cookieBanner = document.querySelector('[data-module="govuk-cookie-banner"]')
  if ($cookieBanner) {
    new CookieBanner($cookieBanner).init()
  }
});
