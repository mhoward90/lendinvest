@isTest
public class TwilioServiceTest {
    @isTest
    private static void itShouldSendSMSAndReturnTwilioData() {
      String mockResponse = '{"error_code":null,"error_message":null,"status":"sent","uri":"/2010-04-01/Accounts/ACXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/Messages/SMXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX.json"}';
      Test.setMock(HttpCalloutMock.class, new HttpResponseMock(mockResponse, 200));

      System.Test.startTest();
        TwilioService.SmsMessage sms = TwilioService.sms('hello lendinvest here', '+12323123', '+123213213');
      System.Test.stopTest();

      TwilioService.SmsMessage mockMessage = (TwilioService.SmsMessage) JSON.deserialize(mockResponse, TwilioService.SmsMessage.class);

      System.assertEquals(mockMessage.uri, sms.uri);
      System.assertEquals(mockMessage.date_created, sms.date_created);
      System.assertEquals(mockMessage.date_sent, sms.date_sent);
      System.assertEquals(mockMessage.date_updated, sms.date_updated);
      System.assertEquals(mockMessage.error_code, sms.error_code);
      System.assertEquals(mockMessage.error_message, sms.error_message);
      System.assertEquals(mockMessage.status, sms.status);
    }

    @isTest
    private static void itShouldSendSMSAndReturnAnException() {
      String mockResponse = '{"error_code":400,"error_message":"not sent"}';
      Test.setMock(HttpCalloutMock.class, new HttpResponseMock(mockResponse, 400));

      Boolean exceptionThrown = false;

      System.Test.startTest();
        try {
          TwilioService.sms('hello lendinvest here', '+12323123', '+123213213');
        } catch (Exception e) {
          exceptionThrown = true;
        }
      System.Test.stopTest();

      System.assertEquals(true, exceptionThrown);
    }
}
