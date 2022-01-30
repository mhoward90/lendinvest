trigger OpportunityTrigger on Opportunity (before insert) {
  private static final String GOLD_STATUS = 'Gold';

 for(Opportunity op : Trigger.new) {
   if (op.StageName == 'Closed Won' && op.Account.Annual_Revenue_Status__c == GOLD_STATUS) {
     TwilioService.sms(
       String.format('Hello {0}, Congratulations on closing your opportunity', new List<String>{op.Account.Name}),
       op.Account.Phone,
       'fetch phone from custom setting'
      );
   }
 }
}