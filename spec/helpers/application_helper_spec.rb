require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#title' do
    let(:title) { helper.content_for(:page_title) }

    before do
      helper.title(value)
    end

    context 'for a blank value' do
      let(:value) { '' }
      it { expect(title).to eq('Search information about legal problems - GOV.UK') }
    end

    context 'for a provided value' do
      let(:value) { 'Test page' }
      it { expect(title).to eq('Test page - Search information about legal problems - GOV.UK') }
    end
  end

  describe '#fallback_title' do
    before do
      allow(Rails).to receive_message_chain(:application, :config, :consider_all_requests_local).and_return(false)
      allow(helper).to receive(:controller_name).and_return('my_controller')
      allow(helper).to receive(:action_name).and_return('an_action')
    end

    it 'should notify in Sentry about the missing translation' do
      expect(Raven).to receive(:capture_exception).with(
        StandardError.new('page title missing: my_controller#an_action')
      )
      helper.fallback_title
    end

    it 'should call #title with a blank value' do
      expect(helper).to receive(:title).with('')
      helper.fallback_title
    end
  end

  describe '#link_button' do
    it 'builds the link markup styled as a button' do
      expect(
        helper.link_button(:start_again, root_path)
      ).to eq('<a class="govuk-button" data-module="govuk-button" href="/">Start again</a>')
    end
  end

  describe '#analytics_tracking_id' do
    it 'retrieves the environment variable' do
      expect(ENV).to receive(:[]).with('GA_TRACKING_ID')
      helper.analytics_tracking_id
    end
  end

  describe 'dev_tools_enabled?' do
    before do
      allow(Rails).to receive_message_chain(:env, :development?).and_return(development_env)
      allow(ENV).to receive(:key?).with('DEV_TOOLS_ENABLED').and_return(dev_tools_enabled)
    end

    context 'for development envs' do
      let(:development_env) { true }
      let(:dev_tools_enabled) { nil }

      it { expect(helper.dev_tools_enabled?).to eq(true) }
    end

    context 'for envs that declare the `DEV_TOOLS_ENABLED` env variable' do
      let(:development_env) { false }
      let(:dev_tools_enabled) { true }

      it { expect(helper.dev_tools_enabled?).to eq(true) }
    end

    context 'for envs without `DEV_TOOLS_ENABLED` env variable' do
      let(:development_env) { false }
      let(:dev_tools_enabled) { false }

      it { expect(helper.dev_tools_enabled?).to eq(false) }
    end
  end
end
