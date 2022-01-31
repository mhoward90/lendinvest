public class HttpResponseMock implements HttpCalloutMock {
  String response;
  Integer statusCode;

  public HttpResponseMock(String response, Integer statusCode) {
    this.response = response;
    this.statusCode = statusCode;
  }
  public HTTPResponse respond(HTTPRequest req) {
      HTTPResponse res = new HTTPResponse();
      res.setBody(this.response);
      res.setStatusCode(this.statusCode);
      return res;
  }
}