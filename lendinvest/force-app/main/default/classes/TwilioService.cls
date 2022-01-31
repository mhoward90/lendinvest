public with sharing class TwilioService {
    public class TwilioException extends Exception{}
    private static final String TWILIO_ACCOUNT = '12321312';

    public static SmsMessage sms(String smsText, String to, String numberFrom) {
      try {
        HttpResponse res = sendRequest(
          String.format('callout:twilio/2010-04-01/Accounts/{0}}/Messages?to={1}&from={2}&body={3}', 
          new List<String>{TWILIO_ACCOUNT,to,numberFrom,smsText}), 
          'POST'
        );
        if (res.getStatusCode() != 200) {
          throw new TwilioException('failed to send sms');
        }

        return (SmsMessage) JSON.deserialize(res.getBody(), SmsMessage.class);
      } catch (TwilioException ex) {
        throw new TwilioException(String.format('failed to send sms {0}', new List<String>{ex.getMessage()}));
      }
    }
  
    public class SmsMessage {
      public String date_created;
      public String date_sent;
      public String date_updated;
      public String error_code;
      public String error_message;
      public String status;
      public String uri;
    }

    private static HttpResponse sendRequest(String url, String method) {
      HttpRequest req = new HttpRequest();
      req.setEndpoint(url);
      req.setMethod(method);

      Http http = new Http();
      return http.send(req);
    }
}