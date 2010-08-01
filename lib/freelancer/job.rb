module Freelancer
  module Job
    #Retrieve the list of current job categories. We frequently tune our job categories. As a result, applications are expected to retrieve and update jobs list dynamically.
    #
    #http://developer.freelancer.com/GetJobList
    def getJobList
      request "/Job/getJobList.json"
    end

    #Retrieve job list with super category.
    #
    #http://developer.freelancer.com/GetCategoryJobList
    def getCategoryJobList
      request "/Job/getCategoryJobList.json"
    end

    #Retrieve job(skill) list for current user.
    #
    #http://developer.freelancer.com/GetMyJobList
    def getMyJobList
      request "/Job/getMyJobList.json"
    end
  end
end
