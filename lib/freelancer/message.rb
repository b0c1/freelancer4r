module Freelancer
  module Message
    #Retrieve private messages sent to the current user.
    #
    #http://developer.freelancer.com/GetInboxMessages
    #
    #<b>Optional:</b>
    #:projectid     => Get the private messages for the specific project
    #:count
    #:page
    def getInboxMessages *args
      options=fill_args [:projectid,:count,:page],[],*args
      request "/Message/getInboxMessages.json", options
    end

    #Retrieve private messages sent by the current user.
    #
    #http://developer.freelancer.com/GetSentMessages
    #
    #<b>Optional:</b>
    #:count
    #:page
    def getSentMessages *args
      options=fill_args [:count,:page],[],*args
      request "/Message/getSentMessages.json", options
    end

    #Retrieve the number of unread messages received by the current user.
    #
    #http://developer.freelancer.com/GetUnreadCount
    def getUnreadCount
      request "/Message/getUnreadCount.json"
    end

    #Send a private message.
    #
    #http://developer.freelancer.com/SendMessage
    #
    #<b>Required:</b>
    #:projectid     => Project Id to identify the message send with
    #:messagetext   => Message text to send
    #:userid        => Receiver userid or username
    #:username      => Receiver userid or username
    def sendMessage *args
      options=fill_args [
        :projectid,:messagetext,:userid,:username
      ],[
        :projectid,:messagetext
      ],*args
      if options[:username]==nil && options[:userid]==nil
        raise "Username or userid is required"
      end
      if options[:username]!=nil && options[:userid]!=nil
        raise "Both username and userid is not allowed"
      end
      request "/Message/sendMessage.json", options
    end

    #Mark an income message as read.
    #
    #http://developer.freelancer.com/MarkMessageAsRead
    #
    #<b>Required:</b>
    #:id            => Message Id to be marked as read
    def markMessageAsRead *args
      options=fill_args [:id],[:id],*args
      request "/Message/markMessageAsRead.json", options
    end
  end
end
