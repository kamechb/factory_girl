module FactoryGirl
  class StrategyClassBuilder
    def initialize(block)
      @result_block         = ->(evaluation) { }
      @association_strategy = -> { }
      instance_exec(&block)
    end

    def result(&block)
      @result_block = block
    end

    def association_strategy(&block)
      @association_strategy = block
    end

    def to_strategy_class
      Class.new.tap do |strategy_class|
        strategy_class.send(:define_method, :result,      &result_block)
        strategy_class.send(:define_method, :association, &association_block)
      end
    end

    private
    attr_reader :result_block

    def association_block
      association_strategy = @association_strategy.call

      if association_strategy
        ->(runner) { runner.run(association_strategy) }
      else
        ->(runner) { runner.run }
      end
    end
  end
end
