module Freelancer
  module Core
    attr_accessor :sandbox

    public
    #Get the proxy settings
    def proxy
      @proxy
    end

    #Set the proxy settings, you can use URI or String
    def proxy=value
      @proxy=value.is_a?(URI) ? value:URI.parse(value)
    end

    #return the used web url
    def web_url
      @sandbox ? "http://www.sandbox.freelancer.com":"http://www.freelancer.com"
    end

    #return the used api url
    def api_url
      @sandbox ? "http://api.sandbox.freelancer.com":"http://api.freelancer.com"
    end
  end
end