require 'json'
require 'net/http'
require 'cgi'

module Freelancer
  #= Freelancer API module
  #== required for using freelancer api calls
  module Api
    #Method to call request
    #
    #If you not logged in, try to log in.
    def request path, parameters={}
      parameters||={}
      params=parameters.map do |k,v|
        if v.is_a?(TrueClass) || v.is_a?(FalseClass)
          v = v ? "1" : "0"
        end
        "#{CGI.escape(k.to_s)}=#{CGI.escape(v.to_s)}"
      end.join("&")
      if @request_token == nil
        login
      end
      if @access_token == nil
        login_stage3
      end
      result=@access_token.post(path,params)
      JSON.parse(result.body)
    end
  end
end
