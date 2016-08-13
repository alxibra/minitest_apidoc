module Holder
  class Test
    attr_accessor :klass, :klass_desc, :units
    def initialize klass, klass_desc
      Markdown
      @klass = klass
      @klass_desc = klass_desc
      @units = []
    end

    def perform result
      units << Unit.new(result).tap(&:perform )
    end
  end
  class Unit
    attr_accessor :test_desc, :result, :path, :method, :params,
                  :body, :status, :header, :name
    def initialize result
      @result = result
    end

    def perform
      self.name = humanize_name
      @test_desc = result.test_desc
      hold_request
      hold_response
    end

    def params
     @params.presence || {}
    end

    def body
      @body.presence || {}
    end

    def path_title
     'path' 
    end

    def method_title
      'method'
    end

    def params_title
      'parameter'
    end

    def status_title
      'status'
    end

    def body_title
      'body'
    end

    private

    def hold_request
      request = result.request
      self.path = request.path
      self.method = request.method
      self.params = request.env["action_dispatch.request.request_parameters"].presence ||
                    request.env["action_dispatch.request.query_parameters"].presence
    end

    def hold_response
      response = result.response
      self.body = response.body
      self.status = response.status
      self.header = response.header['Content-Type']
    end

    def humanize_name
      result.name.sub('test_', '').humanize
    end
  end
end

