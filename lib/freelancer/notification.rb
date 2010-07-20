module Freelancer
  module Notification
    #Get alert messages for the current user. This information is quite important if exists, applications are advised to show this information as soon as possible if it is available.
    #
    #http://developer.freelancer.com/GetNotification
    def getNotification
      request "/Notification/getNotification.json"
    end

    #Get the current news items posted by the Freelancer.com staff. Like the coming events.
    #
    #http://developer.freelancer.com/GetNews
    def getNews
      request "/Notification/getNews.json"
    end
  end
end
