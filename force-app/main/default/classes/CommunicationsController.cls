public with sharing class CommunicationsController {
    private static SMS__mdt twilio = SMS__mdt.getInstance('Twilio');

    @AuraEnabled
    public static void sendSmsMessage(String messageBody, String toNumber) {
      TwilioService.SmsMessage sms;

      try {
        sms = TwilioService.sms(messageBody, toNumber, twilio.number__c);
      } catch (Exception e) {
        throw new AuraHandledException(e.getMessage());
      }

      if (String.isNotBlank(sms.error_message)) {
        AuraHandledException ahe = new AuraHandledException(sms.error_message);
        ahe.setMessage(sms.error_message);
        throw ahe;
      }
    }
}
