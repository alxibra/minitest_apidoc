require "minitest_apidoc/version"
require_relative 'minitest/test_case_extension'
require_relative 'minitest/api_doc_plugin'
module MinitestApidoc
  mattr_accessor :filename, :skip_fail_test
  @@filename = 'api_documentation.md'
  @@skip_fail_test = true
  def self.setup
    yield self
  end
end
