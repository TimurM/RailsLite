require 'json'
require 'webrick'

module Phase4
  class Session
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
      @cookie ||= req.cookies.find {|cookie| cookie.name == '_rails_lite_app'}
      if @cookie
        @cookie_hash = JSON.parse(@cookie.value)
      else
        @cookie_hash = {}
      end
    end

    def [](key)
      @cookie_hash[key]
    end

    def []=(key, val)
      @cookie_hash[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
      # @cookie_hash['_rails_lite_app'] = ActiveSupport::JSON.encode(@cookie_hash)
      new_cookie = WEBrick::Cookie.new('_rails_lite_app', @cookie_hash.to_json)
      res.cookies << new_cookie
    end
  end
end
