module Freelancer
  module Job
    #Retrieve the list of current job categories. We frequently tune our job categories. As a result, applications are expected to retrieve and update jobs list dynamically.
    #
    #http://developer.freelancer.com/GetJobList
    def getJobList
      request "/Job/getJobList.json"
    end
  end
end
