module TestCase
  module Extension
    def self.included base
      def base.inherited subclass
        super subclass
        subclass.extend ClassMethods
        subclass.include InstanceMethods
      end
    end

    module ClassMethods
      def desc description
         @test_class_desc = description
      end

      def test_class_desc
        @test_class_desc
      end

    end

    module InstanceMethods
      extend ActiveSupport::Concern
      included do
        attr_reader :test_desc
      end

      def desc description
        @test_desc = description
      end
    end
  end
end
