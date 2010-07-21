module Freelancer
  module Profile
    #Retrieve the the profile information for the current user.
    #
    #http://developer.freelancer.com/GetAccountDetails
    def getAccountDetails
      request "/Profile/getAccountDetails.json"
    end

    #Retrieve the the profile information for the particular user.
    #
    #http://developer.freelancer.com/GetProfileInfo
    #
    #<b>Required:</b>
    # :userid    => Retrieve the profile information of this user Id.
    def getProfileInfo *args
      options=fill_args [:userid],[:userid],*args
      request "/Profile/getProfileInfo.json",options
    end

    #Update the account information for the current user.
    #
    #http://developer.freelancer.com/SetProfileInfo
    #
    #<b>Optional:</b> (minimum one required)
    # :fullname
    # :company_name
    # :type_of_work
    # :multipartpic
    # :addressline1
    # :addressline2
    # :city
    # :state
    # :country
    # :postalcode
    # :phone
    # :fax
    # :notificationformat
    # :emailnotificationstatus
    # :receivenewsstatus
    # :bidwonnotificationstatus
    # :bidplacednotificationstatus
    # :newprivatemessagestatus
    # :qualificationcsv
    # :profiletext
    # :vision
    # :keywords
    # :hourlyrate
    # :skills
    def setProfileInfo *args
      options=fill_args [
        :fullname,
        :company_name,
        :type_of_work,
        :multipartpic,
        :addressline1,
        :addressline2,
        :city,
        :state,
        :country,
        :postalcode,
        :phone,
        :fax,
        :notificationformat,
        :emailnotificationstatus,
        :receivenewsstatus,
        :bidwonnotificationstatus,
        :bidplacednotificationstatus,
        :newprivatemessagestatus,
        :qualificationcsv,
        :profiletext,
        :vision,
        :keywords,
        :hourlyrate,
        :skills
      ],[],*args
      if options.length==0
        raise "One property requered to change"
      end
      request "/Profile/setProfileInfo.json",options
    end
  end
end
