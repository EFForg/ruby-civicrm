require "benchmark"

module CiviCrm
  module Profiling
    extend ActiveSupport::Concern

    included do
      private

      mattr_accessor :_profile
    end

    module ClassMethods
      def profile(&block)
        self._profile = []

        block.call

        _profile.dup
      ensure
        self._profile = nil
      end

      def time(entity, action, &block)
        time = Benchmark.realtime(&block)

        if _profile
          _profile << [entity, action, time]
        end
      end
    end
  end
end
