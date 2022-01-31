@isTest
public class CommunicationsControllerTest {
    @isTest
    private static void itShouldThrowExceptionWithTwilioError() {
      String mockResponse = '{"error_code":"200","error_message":"there was a problem with sending your message"}';
      Test.setMock(HttpCalloutMock.class, new HttpResponseMock(mockResponse, 200));

      String exceptionMessage;

      System.Test.startTest();
        try {
          CommunicationsController.sendSmsMessage('hello message body', '+44123213123');
        } catch (Exception e) {
          exceptionMessage = e.getMessage();
        }
      System.Test.stopTest();

      System.assertEquals('there was a problem with sending your message', exceptionMessage);
    }
}
