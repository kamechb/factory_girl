module FactoryGirl
  class Callback
    attr_reader :name

    def initialize(name, block)
      @name  = name.to_sym
      @block = block
      check_name
    end

    def run(instance, evaluator)
      case block.arity
      when 1 then instance_exec(instance, &block)
      when 2 then instance_exec(instance, evaluator, &block)
      else instance_exec(&block)
      end
    end

    def ==(other)
      name == other.name &&
        block == other.block
    end

    protected
    attr_reader :block

    private

    def check_name
      unless FactoryGirl.callback_names.include?(name)
        raise InvalidCallbackNameError, "#{name} is not a valid callback name. " +
          "Valid callback names are #{FactoryGirl.callback_names.inspect}"
      end
    end

    def method_missing(name, *args, &block)
      if syntax_runner.respond_to?(name)
        syntax_runner.send(name, *args, &block)
      else
        super
      end
    end

    def syntax_runner
      @syntax_runner ||= SyntaxRunner.new
    end
  end
end
