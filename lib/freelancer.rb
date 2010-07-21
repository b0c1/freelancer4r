$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'freelancer/core'
require 'freelancer/authentication'
require 'freelancer/util'
require 'freelancer/api'
require 'freelancer/common'
require 'freelancer/employer'
require 'freelancer/freelancer'
require 'freelancer/job'
require 'freelancer/message'
require 'freelancer/notification'
require 'freelancer/profile'
require 'freelancer/project'
require 'freelancer/user'
require 'freelancer/widget'
require 'net/http'

#Freelancer for Ruby
#
#Load all Freelancer modules
module Freelancer
  VERSION = "1.0.2"
  #Initialize the Freelancer Wrapper Class
  #
  #Parameters
  #
  #<b>sandbox</b>   true if we are using freelancer sandbox, default: false
  #<b>username</b>  the username for the automatic authorization, default: nil
  #<b>password</b>  the password for the automatic authorization, default: nil
  #<b>application token</b>   the application token from freelancer
  #<b>application secret</b>   the application secret from freelancer
  def self.new sandbox=false,application_token=nil,application_secret=nil,username=nil,password=nil
    freelancer=Freelancer.new
    freelancer.sandbox=sandbox
    freelancer.application_token||=application_token
    freelancer.application_secret||=application_secret
    freelancer.callback||=OAuth::OUT_OF_BAND
    freelancer.username||=username
    freelancer.password||=password
    if ENV['http_proxy'] != nil
      freelancer.proxy||=URI.parse(ENV['http_proxy'])
    end
    freelancer
  end

  class Freelancer
    include Core
    include Api
    include Auth
    include Util

    include Common
    include Employer
    include FreelancersCall
    include Job
    include Message
    include Notification
    include Profile
    include Project
    include User
  end

  def self.new_widget sandbox=false
    widget=FreelancerWidget.new
    widget.sandbox=sandbox
    widget
  end

  class FreelancerWidget
    include Core
    include Util
    include Widget
  end
end
