require 'oauth'
require 'uri'

#Freelancer Authentication Module
#
#Author::     Janos Haber <boci.boci@gmail.com>
#Copyright::  Copyright (c) 2010 Javaportal.hu
#License::
#
#The class automatically detect environment http_proxy variable
#If you need to modify the proxy manual, set the instance.proxy to the proxy
#example:
#freelancer_auth.proxy='http://username:password@proxyhost:proxyport'
module Freelancer
  module Auth

    attr_accessor :application_token, :application_secret, :callback
    attr_accessor :username,:password, :verifier, :authorized
    attr_reader :request_token, :access_token
    #Login stage one
    #
    #Request the token from freelancer
    def login_stage1
      @consumer=OAuth::Consumer.new( @application_token, @application_secret, {
        :site=>api_url,
        :scheme=>:query_string,
        :http_method=>:get,
        :request_token_path=>"/RequestRequestToken/requestRequestToken.json",
        :access_token_path=>"/RequestAccessToken/requestAccessToken.json",
        :authorize_url=>"#{web_url}/users/api-token/auth.php",
        :callback=>@callback,
        :proxy=>proxy
      })
      @request_token=@consumer.get_request_token
    end

    #Login stage two
    #
    #If username and password present and the login_stage1 completed
    #try to login in freelancer website and authorize the application
    #And set the oauth verifier number
    def login_stage2
      if @request_token == nil
        login_stage1
      end
      if @username != nil && @password != nil && @callback == OAuth::OUT_OF_BAND
        if try_to_authorize
          login_stage3
        else
          @request_token.authorize_url
        end
      else
        @request_token.authorize_url
      end
    end

    #Login stage three
    #
    #Set the access token require login stage 1 and stage 2 (authorized user)
    def login_stage3
      result=@consumer.token_request @consumer.http_method, "/RequestAccessToken/getRequestTokenVerifier.json",@request_token
      @verifier=result[:verifier]
      @access_token=@request_token.get_access_token({:oauth_verifier=>@verifier})
    end

    #One step login method
    #
    #If you set the username, password it's try to authorize the request
    #If the verifier not set (bad username/password or username/password not set)
    #it's return the authorize url (need manual set the verifier number)
    def login
      login_stage1              #login stage 1, request unauthorized token
      login_stage2              #login stage 2, try to log in ang get the verifier
      if @authorized
        login_stage3            #if we have verifier, we get the access token key
      else                      #if we not have verifier, authentication or not oob callback selected, request manual login, return the url
        return @request_token.authorize_url
      end
    end

    protected

    #Try to emulate user authorization
    def try_to_authorize
      begin
        require 'mechanize'

        @agent ||= Mechanize.new
        @agent.user_agent_alias='Mac Safari'

        @agent.set_proxy(proxy.host, proxy.port, proxy.user,proxy.password) if proxy != nil
        page = @agent.get(web_url)
        login_form=page.form_with(:name=>'login_form')
        if login_form != nil
          login_form.field_with(:name=>'username').value=@username
          login_form.field_with(:name=>'passwd').value=@password
          @agent.submit(login_form)
        end
        initial_page=@agent.get(@request_token.authorize_url)
        initial_page.forms.each do |form|
          if form.has_field? 'oauth_token'
            result=form.submit
            return true
          end
        end
      rescue LoadError
        false
      end
      false
    end
  end
end
