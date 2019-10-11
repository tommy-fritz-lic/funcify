module Funcify

  class Monad

    extend Dry::Monads::Result::Mixin

    class << self

      # > lift.(Success(:ok)) => :ok
      def lift
        -> value { maybe_value_ok?.(value) ? maybe_value.(value) : maybe_failure.(value) }
      end

      # > failure.(:error)  => Failure(:error)
      def failure
        -> value { Failure(value) }
      end

      # > success.(:ok)  => Success(:ok)
      def success
        -> value { Success(value) }
      end

      def maybe_value_ok?
        -> m { m.respond_to?(:success?) && m.success? }
      end

      def maybe_value_fail?
        -> m { m.respond_to?(:failure?) && m.failure? }
      end

      def maybe_value
        ->(v) { v.value_or }
      end

      def maybe_failure
        ->(v) { v.failure }
      end

    end

  end

end
