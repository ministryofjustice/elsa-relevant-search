class CommonTerms < SimpleDelegator
  attr_reader :locale

  QuickSearchGroup = Struct.new(:category, :terms) do
    def to_partial_path
      'shared/quick_search_group'.freeze
    end
  end

  def initialize(locale:)
    @locale = locale

    super(
      build_config
    )
  end

  private

  def build_config
    configuration.map { |category, terms| QuickSearchGroup.new(category, terms) }
  end

  def configuration
    Rails.configuration.x.common_terms.fetch(locale)
  end
end
