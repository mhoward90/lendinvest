trigger OpportunityTrigger on Opportunity (after update, after insert) {
  String GOLD_STATUS = 'Gold';

  for(Opportunity op : Trigger.new) {
    try {
      if (op.StageName == 'Closed Won' && op.Account.Annual_Revenue_Status__c == GOLD_STATUS) {
        CommunicationsController.sendSmsMessage(
          String.format('Hello {0}, Congratulations on closing your opportunity', new List<String>{op.Account.Name}),
          op.Account.Phone
        );
      }
    } catch (Exception ex) {
      // use a logging framework to log the exception here
    }
  }
}