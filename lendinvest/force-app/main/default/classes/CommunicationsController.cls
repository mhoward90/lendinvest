public with sharing class CommunicationsController {
    @AuraEnabled
    public static void sendSmsMessage(String messageBody, String toNumber, String fromNumber){
      try {
        TwilioService.sms(messageBody, toNumber, fromNumber);
      } catch (Exception e) {
        throw new AuraHandledException(e.getMessage());
      }
    }
}
