module Freelancer
  module Employer
    #Post a new project.
    #
    #http://developer.freelancer.com/PostNewProject
    #
    #<b>Required:</b>
    # :projectType    => The type of tye project (:normal,:trial,:draft)
    # :projectname    => Project name to post
    # :projectdesc    => Project description
    # :jobtypecsv     => Job category associated with project
    # :budget         => Budget of the project
    # :duration       => Period of the project
    #
    #<b>Optional:</b> (available on :normal and :draft)
    # :isfeatured     => Set to 1 if post as a featured project.(Default: 0)
    # :isnonpublic    => Set to 1 if post as a nonpublic project.(Default: 0)
    # :isbidhidden    => Set to 1 if post as a sealbids project.(Default: 0)
    def postNewProject *args
      options=fill_args [
        :projectType,
        :projectname,
        :projectdesc,
        :jobtypecsv,
        :budget,
        :duration,
        :isfeatured,
        :isnonpublic,
        :isbidhidden
      ],[
        :projectType,
        :projectname,
        :projectdesc,
        :jobtypecsv,
        :budget,
        :duration
      ],*args
      type=options.delete(:projectType)
      case type
      when :normal
        request "/Employer/postNewProject.json",options
      when :draft
        request "/Employer/postNewDraftProject.json",options
      when :trial
        options.delete(:isfeatured)
        options.delete(:isnonpublic)
        options.delete(:isbidhidden)
        request "/Employer/postNewTrialProject.json",options
      end
    end

    #Allows a project creator to select a freelancer for their project.
    #
    #http://developer.freelancer.com/ChooseWinnerForProject
    #
    #<b>Required:</b>
    # :projectid    => Project identifier
    # :useridcsv    => Allows multiple winner for ALL except full-time jobs. At-least one ID mandatory
    def chooseWinnerForProject *args
      options=fill_args [:projectid,:useridcsv],[:projectid,:useridcsv],*args
      request "/Employer/chooseWinnerForProject.json", options
    end

    #Retrieve the list of projects posted by the current user.
    #
    #http://developer.freelancer.com/GetPostedProjectList
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
    def getPostedProjectList *args
      options=fill_args [:status,:userid,:projectid,:count,:page],[:status],*args
      request "/Employer/getPostedProjectList.json", options
    end

    #Invite a freelancer to bid on a created project.
    #
    #http://developer.freelancer.com/InviteUserForProject
    #
    #<b>Required:</b>
    # :useridcsv         => :useridcsv <b>OR</b> :usernamecsv
    # :usernamecsv       => Can be CSV also to allow multiple user invite
    # :projectid         => Project identifier
    def inviteUserForProject *args
      options=fill_args [:useridcsv,:usernamecsv,:projectid],[:projectid],*args
      if options[:useridcsv]==nil && options[:usernamecsv]==nil
        raise "useridcsv or usernamecsv is required"
      end
      if options[:useridcsv]!=nil && options[:usernamecsv]!=nil
        raise "Both useridcsv and usernamecsv is not allowed"
      end
      request "/Employer/inviteUserForProject.json", options
    end
  end

  #Update the details for a posted project.
  #
  #http://developer.freelancer.com/UpdateProjectDetails
  #
  #<b>Required:</b>
  # :projectid
  #
  #<b>Optional:</b>
  # :projectdesc
  # :jobtypecsv
  def updateProjectDetails *args
    options=fill_args [:projectid,:projectdesc,:jobtypecsv],[:projectid],*args
    request "/Employer/updateProjectDetails.json", options
  end
end
