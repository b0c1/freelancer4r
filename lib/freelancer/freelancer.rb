module Freelancer
  module FreelancersCall
    #Get the list of projects that have been bid by the current user.
    #
    #http://developer.freelancer.com/GetProjectListForPlacedBids
    #
    #<b>Required:</b>
    # :status
    #         1 - All
    #         2 - Open And Frozen – Default
    #         3 - Frozen Awaiting your action
    #         4 - Awaiting Bidder Action
    #         5 - Closed Won
    #         6 - Closed Lost
    #         7 - Closed Canceled
    #
    #<b>Optional:</b>
    # :userid     => UserID of the Poster
    # :projectid  => Project ID filter
    # :count      => (Default: 50)
    # :page       => (Default: 0)
    def getProjectListForPlacedBids
      options=fill_args [:status,:userid,:projectid,:count,:page],[:status],*args
      request "/Freelancer/getProjectListForPlacedBids.json", options
    end

    #Place bid on project.
    #
    #http://developer.freelancer.com/PlaceBidOnProject
    #
    #<b>Required:</b>
    # :amount        => amount
    # :days          => days
    # :description   => description
    # :projectid     => project identifier
    #
    #<b>Optional:</b>
    # :notificationStatus    => Notification on anyone else bid on this project at a lower price. 0 - no notification, 1 - notification (Default: 0)
    # :highlighted           => Highlight bids. 0 - not highlighted, 1 - highlighted. (Default: 0)
    # :milestone             => The initial milestone percentage declares the terms of your bid. This tells the employer that you require the specified percentage as a milestone payment before you start work.
    def placeBidOnProject *args
      options=fill_args [
        :amount,
        :days,
        :description,
        :projectid,
        :notificationStatus,
        :highlighted,
        :milestone
      ],[
        :amount,
        :days,
        :description,
        :projectid
      ],*args
      request "/Freelancer/placeBidOnProject.json", options
    end

    #Retract a bid that has been placed on a project.
    #
    #http://developer.freelancer.com/RetractBidFromProject
    #
    #<b>Required:</b>
    # :projectid     => project identifier
    def retractBidFromProject *args
      options=fill_args [:projectid],[:projectid],*args
      request "/Freelancer/retractBidFromProject.json", options
    end

    #After a freelancer has been selected for a project, this method should be called to accept the offer.
    #
    #http://developer.freelancer.com/AcceptBidWon
    #
    #<b>Required:</b>
    # :projectid     => project identifier
    # :state         => 0 - decline , 1 - Accept (default)
    def acceptBidWon *args
      options=fill_args [:projectid,:state],[:projectid],*args
      request "/Freelancer/acceptBidWon.json", options
    end
  end
end