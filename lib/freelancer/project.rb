module Freelancer
  module Project
    #Search Projects
    #
    #http://developer.freelancer.com/SearchProjects
    #
    #<b>Optional:</b>
    # :isfeatured        => boolean
    # :isnonpublic       => boolean
    # :searchkeyword     => string
    # :searchjobtypecsv  => coma separated job types [ PHP, .NET ]
    # :status            => string [ Open | Frozen | Closed| ClosedAwarded| ClosedCanceled ]
    # :budgetmin         => integer or String [ 250 | 750 |1500 |3000 | Any ]
    # :budgetmax         => integer
    # :isfulltime        => boolean
    # :istrial           => boolean
    # :isgoldmembersonly => boolean
    # :bidendsduration   => string [ submitdate (default) | bid_enddate | id | state ]
    # :count             => number
    # :page              => number
    # :tags              => string
    # :sort              => string
    def searchProjects *args
      options=fill_args [
        :isfeatured,
        :isnonpublic,
        :searchkeyword,
        :searchjobtypecsv,
        :status,
        :budgetmin,
        :budgetmax,
        :isfulltime,
        :istrial,
        :isgoldmembersonly,
        :bidendsduration,
        :count,
        :page,
        :tags,
        :sort
      ],[], *args

      request "/Project/searchProjects.json",options
    end

    #Get the cost all the project posting options.
    #
    #http://developer.freelancer.com/GetProjectFees
    def getProjectFees
      request "/Project/getProjectFees.json"
    end

    #Retrieve the details for a particular project
    #
    #http://developer.freelancer.com/GetProjectDetails
    #
    #<b>Required:</b>
    # :projectid   => project id
    def getProjectDetails *args
      options = fill_args [:projectid],[:projectid],*args
      request "/Project/getProjectDetails.json", options
    end

    #Get All bids details to the selected project
    #
    #http://developer.freelancer.com/GetBidsDetails
    #
    #<b>Required:</b>
    # :projectid   => project id
    def getBidsDetails *args
      options = fill_args [:projectid],[:projectid],*args
      request "/Project/getBidsDetails.json",options
    end

    #Retrieve the public messages posted to a project clarification board.
    #
    #http://developer.freelancer.com/GetPublicMessages
    #
    #<b>Required:</b>
    # :projectid   => project id
    def getPublicMessages *args
      options = fill_args [:projectid],[:projectid],*args
      request "/Project/getPublicMessages.json",options
    end

    #Post a public message to project clarification board.
    #
    #http://developer.freelancer.com/PostPublicMessage
    #
    #<b>Required:</b>
    # :projectid   => Project Id associated with the message
    # :messagetext => message text
    def postPublicMessage *args
      options = fill_args [:projectid,:messagetext],[:projectid,:messagetext],*args
      request "/Project/postPublicMessage.json",options
    end
  end
end