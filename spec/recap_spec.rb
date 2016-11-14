require 'spec_helper'

require 'chef/resource'

describe Chef::Handler::Recap do
  before(:each) do
    @handler = Chef::Handler::Recap.new
    @node = Chef::Node.new
    @events = Chef::EventDispatch::Dispatcher.new
    @run_context = Chef::RunContext.new(@node, {}, @events)
    @run_status = Chef::RunStatus.new(@node, @events)

    Chef::Log.level = :info
    @msg = ''
    allow(Chef::Log).to receive(:info) { |str| @msg << str }
  end

  describe 'report' do
    before do
      @run_status.run_context = @run_context
      @all_resources = [Chef::Resource::File.new('a'), Chef::Resource::File.new('b')]
      @run_context.resource_collection.all_resources.replace(@all_resources)
    end

    describe 'resources not updated' do
      before do
        @handler.run_report_unsafe(@run_status)
      end

      it 'report all ok' do
        expect(@msg).to match(/ok=2 updated=0/)
      end
    end

    describe 'resources have been updated' do
      before do
        @all_resources.first.updated_by_last_action(true)
        @handler.run_report_unsafe(@run_status)
      end

      it 'report updated' do
        expect(@msg).to match(/ok=2 updated=1/)
      end
    end
  end
end
