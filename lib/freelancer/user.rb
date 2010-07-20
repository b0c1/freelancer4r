module Freelancer
  module User
    #Search for users using various search criteria.
    #
    #http://developer.freelancer.com/GetUsersBySearch
    #
    #<b>Optional:</b>
    #:username        => Username of the person for who you are searching.
    #:expertise_csv   => Comma separated list of job categories, refer to the main page for a list of categories.
    #:country_csv     => Comma separated list of countries
    #:rating          => Minimum rating for the user
    #:count           => (default: 50)
    #:page            => (default: 0)
    def getUsersBySearch *args
      options=fill_args [
        :username,
        :expertise_csv,
        :country_csv,
        :rating,
        :count,
        :page
      ],[], *args
      request "/User/getUsersBySearch.json",options
    end

    #Get feedback received by a particular user.
    #
    #http://developer.freelancer.com/GetUserFeedback
    #
    #<b>Required:</b>
    #:username         => Username or userid is required
    #:userid           => Username or userid is required
    #
    #<b>Optional:</b>
    #:type             => [P = Provider Only, B = Buyer Only, A = Default, All]
    def getUsersFeedback *args
      options=fill_args [:username,:userid,:type],[],*args
      if options[:username]==nil && options[:userid]==nil
        raise "Username or userid is required"
      end
      if options[:username]!=nil && options[:userid]!=nil
        raise "Both username and userid is not allowed"
      end
      request "/User/getUserFeedback.json",options
    end

    #Get the profile information for a particular user.
    #
    #http://developer.freelancer.com/GetUserDetails
    #
    #<b>Required:</b>
    #:username         => Username or userid is required
    #:userid           => Username or userid is required
    def getUserDetails *args
      options=fill_args [:username,:userid],[],*args
      if options[:username]==nil && options[:userid]==nil
        raise "Username or userid is required"
      end
      if options[:username]!=nil && options[:userid]!=nil
        raise "Both username and userid is not allowed"
      end
      request "/User/getUserDetails.json",options
    end
  end
end
