module Phase2
  class ControllerBase
    attr_reader :req, :res

    # Setup the controller
    def initialize(req, res)
      @req = req
      @res = res
    end

    # Helper method to alias @already_built_response
    def already_built_response?
      @already_build_response ||= false
    end

    # Set the response status code and header
    def redirect_to(url)
      raise "You are trying to double render" if already_built_response?
      @res.header['location'] = url
      @res.status = 302
      @already_build_response = true
    end

    # Populate the response with content.
    # Set the response's content type to the given type.
    # Raise an error if the developer tries to double render.
    def render_content(content, type)
        raise "You are trying to double render" if already_built_response?
        @res.body = content
        @res.content_type = type
        @already_build_response = true
    end
  end
end
