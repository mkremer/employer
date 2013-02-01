require_relative "../errors"

module Employer
  module Employees
    class AbstractEmployee
      attr_reader :job

      def work(job)
        raise Employer::Errors::EmployeeBusy unless free?
        @job = job
      end

      def perform_job
        job.perform
      end

      def wait_for_completion
        work_state(true)
      end

      def stop_working
        return if work_completed? || work_failed?
        force_work_stop
      end

      def free?
        job.nil?
      end

      def work_in_progress?
        true if work_state == :busy
      end

      def work_completed?
        true if work_state == :complete
      end

      def work_failed?
        true if work_state == :failed
      end

      def free
        return unless work_completed? || work_failed?
        @work_state = nil
        @job = nil
      end

      def work_state(wait = false)
      end

      def force_work_stop
      end
    end
  end
end
