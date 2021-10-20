class HomeController < ApplicationController
  def index
    # We only have a locale for now
    @common_terms = CommonTerms.new(locale: 'en')
  end
end
