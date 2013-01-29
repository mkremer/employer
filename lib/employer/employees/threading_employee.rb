require_relative "abstract_employee"

module Employer
  module Employees
    class ThreadingEmployee < AbstractEmployee
      def work(job)
        super
        @work_state = :busy

        @thread = Thread.new do
          begin
            job.perform
            @work_state = :complete
          rescue => exception
          ensure
            @work_state = :failed if @work_state == :busy
          end
        end
      end

      def free
        super
        @thread = nil
      end

      def work_state(wait = false)
        @thread.join if wait
        return @work_state
      end
    end
  end
end
