require 'chef/log'
require 'chef/handler'

class Chef
  class Handler
    class Recap < ::Chef::Handler
      def report
        ::Chef::Log.info "ok=#{run_status.all_resources.length} updated=#{run_status.updated_resources.length}" if run_status.success?
      end
    end
  end
end
