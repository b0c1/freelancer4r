module Freelancer
  module Payment
    #Retrieve the current user's balance and the details of the last transaction.
    #
    #http://developer.freelancer.com/GetAccountBalanceStatus
    def getAccountBalanceStatus
      request "/Payment/getAccountBalanceStatus.json"
    end

    #Retrieve the list of transactions and details for an account.
    #
    #http://developer.freelancer.com/GetAccountTransactionList
    #
    #<b>Optional:</b>
    #:count     => (Default: 50)
    #:page      => (Default: 0)
    #:datefrom  => Get transactions from the date
    #:dateto    => Get transactions up to the date
    def getAccountTransactionList *args
      options=fill_args [
        :count,:page,:datefrom,:dateto
      ],[],*args
      request "/Payment/getAccountTransactionList.json", options
    end

    #Make a request to withdraw funds.
    #
    #http://developer.freelancer.com/RequestWithdrawal
    #
    #<b>Required:</b>
    #:amount          => Withdraw amount
    #:method          => :paypal | :moneybooker | :wire | :paynoneer (default)
    #:additionaltext  => Required for wire withdraw
    #:paypalemail     => Required for paypal withdraw
    #:mb_account      => Required for moneybooker withdraw
    #:description     => Required for wire withedraw
    #:country_code    => Required for wire withdraw
    def requestWithdrawal *args
      options=fill_args [
        :amount,
        :method,
        :additionaltext,
        :paypalemail,
        :mb_account,
        :description,
        :country_code
      ],[
        :amount,
        :method,
        :additionaltext,
        :paypalemail,
        :mb_account,
        :description,
        :country_code
      ],*args
      request "/Payment/requestWithdrawal.json", options
    end

    #Create a milestone (escrow) payment.
    #
    #http://developer.freelancer.com/CreateMilestonePayment
    #
    #<b>Required:</b>
    #:projectid     => Mandatory if Partial or Full payment for a project.
    #:amount        => Milestone amount
    #:touserid      => Userid or username create milestone payment to
    #:tousername    => Userid or username create milestone payment to
    #:reasontext    => Text attached to transfer
    #:reasontype    => partial|full|other
    def createMilestonePayment *args
      options=fill_args [
        :projectid,
        :amount,
        :touserid,
        :tousername,
        :reasontext,
        :reasontype
      ],[
        :projectid,
        :amount,
        :reasontext,
        :reasontype
      ],*args
      if options[:touserid]==nil && options[:tousername]==nil
        raise "touserid or tousername is required"
      end
      if options[:touserid]!=nil && options[:tousername]!=nil
        raise "Both touserid and tousername is not allowed"
      end
      request "/Payment/createMilestonePayment.json", options
    end

    #Cancel milestone
    #
    #http://developer.freelancer.com/CancelMilestone
    #
    #<b>Required:</b>
    #:transactionid     => Transaction Id
    def cancelMilestone *args
      options=fill_args [:transactionid],[:transactionid],*args
      request "/Payment/cancelMilestone.json", options
    end

    #Get the list of incoming and outgoing milestone(escrow) payments.
    #
    #http://developer.freelancer.com/GetAccountMilestoneList
    #
    #<b>Optional:</b>
    #:type    => Incoming(default) or Outgoing
    #:count   => (Default: 50)
    #:page    => (Default: 0)
    def getAccountMilestoneList *args
      options=fill_args [:type,:count,:page],[],*args
      request "/Payment/getAccountMilestoneList.json", options
    end

    #View the list of withdrawals that have been requested and are pending.
    #
    #http://developer.freelancer.com/GetAccountWithdrawalList
    #
    #<b>Optional:</b>
    #:type    => Incoming(default) or Outgoing
    #:count   => (Default: 50)
    #:page    => (Default: 0)
    def getAccountWithdrawalList *args
      options=fill_args [:type,:count,:page],[],*args
      request "/Payment/getAccountMilestoneList.json", options
    end

    #Send a request to payer for releasing an incoming milestone payment.
    #
    #http://developer.freelancer.com/RequestReleaseMilestone
    #
    #<b>Required:</b>
    #:transactionid     => Transaction Id
    def requestReleaseMilestone *args
      options=fill_args [:transactionid],[:transactionid],*args
      request "/Payment/requestReleaseMilestone.json", options
    end

    #Release a milestone payment.
    #
    #http://developer.freelancer.com/ReleaseMilestone
    #
    #<b>Required:</b>
    #:transactionid     => Transaction Id
    #:fullname          => Fullname of the payer
    def releaseMilestone *args
      options=fill_args [:transactionid,:fullname],[:transactionid,:fullname],*args
      request "/Payment/releaseMilestone.json", options
    end
  end
end
