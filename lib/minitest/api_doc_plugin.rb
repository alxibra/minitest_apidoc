require_relative 'markdown'
require_relative 'holder/test'
require_relative 'document'
require_relative 'test_case_extension'
module Minitest
  ActionController::TestCase.include TestCase::Extension

  def self.plugin_api_doc_init(options)
    Minitest.reporter << ApiDocReporter.new
  end

  def self.plugin_api_doc_options(opts, options)
  end

  class ApiDocReporter < AbstractReporter
    attr_accessor :test_holders
    def initialize
      @test_holders = []
    end

    def record result
      return unless  valid_for_doc? result
      klass = result.class
      holder =
        find_holder(klass) ||
        new_holder(klass, klass.test_class_desc)
      holder.perform(result)
    end

    def report
      Document.new(test_holders).print
    end

    private

    def valid_for_doc? result
      result.class < ActionController::TestCase &&
        result.test_desc.present? &&
        result.class.test_class_desc.present?
    end

    def find_holder klass
      test_holders.find do |holder|
        holder.klass == klass
      end
    end

    def new_holder klass, klass_desc
      Holder::Test.new(klass, klass_desc).tap do |h|
        test_holders << h
      end
    end
  end
end
