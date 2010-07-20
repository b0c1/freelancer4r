require 'net/http'
require 'json'
require 'cgi'

module Freelancer
  module Widget
    def request_widget path, parameters={}
      params=parameters.map do |k,v|
        if v.is_a?(TrueClass) || v.is_a?(FalseClass)
          v = v ? "1" : "0"
        end
        if v.is_a?(Array)
          v.map do |item|
            "#{CGI.escape(k.to_s)}[]=#{CGI.escape(item.to_s)}"
          end.join("&")
        else
          puts v
          "#{CGI.escape(k.to_s)}=#{CGI.escape(v.to_s)}"
        end
      end.join("&")
      url=api_url+path
      url+="?#{params}" if params.length > 0
      uri=URI.parse(url)
      puts uri
      #      response=Net::HTTP.get_response(uri)
      #    puts response.body
    end

    #= Search projects
    #
    #http://www.freelancer.com/affiliate-api.html#ProjectSearch
    #
    #== Optional
    #:keyword
    #   Search keyword
    #:owner
    #   Username of ID of project owner
    #:winner
    #   Username of ID of project winner
    #:jobs[]
    #   Names of job categories from the available list on Freelancer.com (PHP, .NET, AJAX, etc.). This parameter may be repeated more than once
    #:featured
    #   If 1 - only featured projects, if 0 - only NON-featured projects
    #:trial
    #   If 1 - only trial projects, if 0 - only NON-trial projects
    #:for_gold_members
    #   If 1 - only "For gold members" projects, if 0 - only NON "For gold members" projects
    #:nonpublic
    #   If 1 - only nonpublic projects, if 0 - only public projects
    #:min_budget
    #   Only projects with budget higher or equal to min_budget
    #:max_budget
    #   Only projects with budget lower or equal to max_budget
    #:bidding_ends
    #   Only projects ending sooner than bidding_ends days
    #:order
    #   How to order projects in the result output. See available project order criteria.
    #   types:
    #       :id - order by project ID
    #       :submitdate - order by date when project was added (default)
    #       :state - order by state of project. Active/open projects will be listed first, next - frozen and then closed.
    #       :bid_count - order by number of bids
    #       :bid_avg - order by average bid
    #       :bid_enddate - order by bidding end time
    #       :buyer - order by buyer's username
    #       :budget - order by budget
    #       :relevance - order by relevance of search by keyword. This criterion should be used with the parameter keyword
    #       :rand - order randomly
    #:order_dir
    #   Direction of sorting. If the parameter is equal to asc, results are ordered in ascending way, otherwise - descending (desc).
    #:pg
    #   Page number. Starts from 0. Default page is 0
    #:count
    #   Number of items on a page
    #:apikey
    #   API key, paramater is optional.
    def search *args
      options=fill_args [
        :keyword,
        :owner,
        :winner,
        :jobs,
        :featured,
        :trial,
        :for_gold_members,
        :nonpublic,
        :min_budget,
        :max_budget,
        :bidding_ends,
        :order,
        :order_dir,
        :pg,
        :count,
        :apikey
      ],[],*args

      request_widget("/Project/Search.json",options)
    end

    #= Get the project details
    #
    #http://www.freelancer.com/affiliate-api.html#ProjectProperties
    #
    #== Required
    #:id
    #   the project id
    #
    #== Optional
    #:apikey
    #   API key, paramater is optional.
    def projectDetails *args
      options=fill_args [:id,:apikey],[:id],*args
      request_widget("/Project/Properties.json",options)
    end

    #Get the project details
    #
    #http://www.freelancer.com/affiliate-api.html#UserProperties
    #
    #== Required
    #:id
    #   the user id
    #
    #== Optional
    #:apikey
    #   API key
    def userDetails *args
      options=fill_args [:id,:apikey],[:id],*args
      request_widget("/User/Properties.json",options)
    end

    #= Feedback search
    #
    #http://www.freelancer.com/affiliate-api.html#FeedbackSearch
    #
    #== Required
    #:user
    #   ID or username of a feedback receiver
    #
    #== Optional
    #:project_id
    #   ID of project for which the feedback was made
    #:type
    #   Type of the feedback. S - service provider's (seller's) feedbacks, B - buyer's feedbacks. By default provider's feedbacks are returned
    #:positive
    #   if positive equals to 1, only feedbacks with rating higher than average will be returned
    #:order
    #   How to order feedbacks in result output.  Types:
    #       :active_date - order by date when feedback was activated (default)
    #       :rand - order randomly
    #
    #:order_dir
    #   Direction of sorting. If the parameter is equal to asc, results are ordered in ascending way, otherwise - descending ('desc').
    #:pg
    #   Page number. Starts from 0. Default page is 0
    #:count
    #   Number of items on a page
    #:apikey
    #   API key
    def feedbackSearch
      options=fill_args [
        :user,
        :project_id,
        :type,
        :positive,
        :order,
        :order_dir,
        :pg,
        :count,
        :apikey
      ],[:user],*args

      request_widget("/Feedback/Search.json",options)
    end
  end
end
