public with sharing class TwilioService {
    public class TwilioException extends Exception{}
    private static final String TWILIO_ACCOUNT = '12321312';

    public static void sms(String smsText, String to, String numberFrom) {
      try {
        sendRequest(String.format('callout:twilio/2010-04-01/Accounts/{0}}/Messages?to={1}&from={2}&body={3}', new List<String>{TWILIO_ACCOUNT,to,numberFrom,smsText}), 'POST');
      } catch (TwilioException ex) {
        throw new TwilioException(String.format('unable to send sms {0}', new List<String>{ex.getMessage()}));
      }
    }

    private static void sendRequest(String url, String method) {
      HttpRequest req = new HttpRequest();
      req.setEndpoint(url);
      req.setMethod(method);

      Http http = new Http();
      HTTPResponse res;

      try {
        res = http.send(req);
      } catch (Exception ex) {
        throw new TwilioException(res.getBody());
      }
    }
}