trigger OpportunityTrigger on Opportunity (after insert) {
  private static final String GOLD_STATUS = 'Gold';
  private static SMSNumber__c smsNumber = SMSNumber__c.getValues('Twilio');

 for(Opportunity op : Trigger.new) {
   try {
    if (op.StageName == 'Closed Won' && op.Account.Annual_Revenue_Status__c == GOLD_STATUS) {
      TwilioService.sms(
        String.format('Hello {0}, Congratulations on closing your opportunity', new List<String>{op.Account.Name}),
        op.Account.Phone,
        smsNumber.Twilio__c
      );
    }
  } catch (Exception ex) {
    // use a logging framework to log the exception here
  }
 }
}