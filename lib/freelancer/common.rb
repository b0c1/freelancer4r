module Freelancer
  module Common
    #Submit a request to cancel a project
    #
    #http://developer.freelancer.com/RequestCancelProject
    #
    #<b>Required:</b>
    #:projectid
    #:commenttext
    #:reasoncancellation
    #         1 - Mutual – Default
    #         2 - Service Done,Not Paid
    #         3 - Service Not Done.
    #         4 - No Communication
    #         5 - Quality of Service
    #         6 - Other
    #
    #<b>Optional:</b>
    #:followedguidelinesstatus
    #         1 - I followed
    #         0 - I didn't follow
    #         (This is option is not needed unless felt necessary)
    def requestCancelProject *args
      options=fill_args [
        :projectid,
        :commenttext,
        :reasoncancellation,
        :followedguidelinesstatus
      ],[
        :projectid,
        :commenttext,
        :reasoncancellation
      ],*args
      request "/Common/requestCancelProject.json", options
    end

    #Post a feedback for a user
    #
    #http://developer.freelancer.com/PostFeedback
    #
    #<b>Required:</b>
    #:rating              => 1 to 10
    #:feedbacktext        => Text of feedback
    #:userid              => UserId or username the feedback posted to
    #:username            => UserId or username the feedback posted to
    #:projectid           => Project Id associated with the feedback
    def postFeedback *args
      options=fill_args [
        :rating,:feedbacktext,:userid,:username,:projectid
      ],[
        :rating,:feedbacktext,:projectid
      ],*args

      if options[:username]==nil && options[:userid]==nil
        raise "Username or userid is required"
      end
      if options[:username]!=nil && options[:userid]!=nil
        raise "Both username and userid is not allowed"
      end
      request "/Common/postFeedback.json", options
    end

    #Post a comment in reply to a feedback given to you by another user.
    #
    #http://developer.freelancer.com/PostReplyForFeedback
    #
    #<b>Required:</b>
    #:feedbacktext    => Text of the feedback
    #:userid          => UserId or username the reply posted to
    #:username        => UserId or username the reply posted to
    #:projectid       => Project Id associated with the feedback
    def postReplyForFeedback *args
      options=fill_args [
        :feedbacktext,:userid,:username,:projectid
      ],[
        :feedbacktext,:projectid
      ],*args
      if options[:username]==nil && options[:userid]==nil
        raise "Username or userid is required"
      end
      if options[:username]!=nil && options[:userid]!=nil
        raise "Both username and userid is not allowed"
      end
      request "/Common/postReplyForFeedback.json", options
    end

    #Submit a request to withdraw a feedback posted by another user on a finished project
    #
    #http://developer.freelancer.com/RequestWithdrawFeedback
    #
    #<b>Required:</b>
    #:userid          => UserId or username the reply posted to
    #:username        => UserId or username the reply posted to
    #:projectid       => Project Id associated with the feedback
    def requestWithdrawFeedback *args
      options=fill_args [:userid,:username,:projectid],[:projectid],*args
      if options[:username]==nil && options[:userid]==nil
        raise "Username or userid is required"
      end
      if options[:username]!=nil && options[:userid]!=nil
        raise "Both username and userid is not allowed"
      end
      request "/Common/requestWithdrawFeedback.json", options
    end

    #Get the list of projects that can be rated
    #
    #http://developer.freelancer.com/GetPendingFeedback
    #
    #<b>Optional:</b>
    #:type
    #     P - Provider
    #     B - Buyer,Default
    def getPendingFeedback *args
      options=fill_args [:type],[],*args
      request "/Common/getPendingFeedback.json", options
    end

  end
end
