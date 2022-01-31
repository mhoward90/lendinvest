@isTest
public class OpportunityTriggerTest {
  @isTest 
  private static void ItShouldSendSMSWhenStageIsClosedWonForGoldAccounts() {
    // Create an account with an opportunity, and then try to insert it
    Account acct = new Account(Name='Test Account', AnnualRevenue=90000);
    insert acct;

    Opportunity opp = new Opportunity(
      Name=acct.Name,
      StageName='Closed Won',
      CloseDate=System.today().addMonths(1),
      AccountId=acct.Id
    );

    String mockResponse = '{"error_code":null,"error_message":null,"status":"sent","uri":"/2010-04-01/Accounts/ACXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/Messages/SMXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX.json"}';
    Test.setMock(HttpCalloutMock.class, new HttpResponseMock(mockResponse, 200));
     
    // Perform test
    Test.startTest();
      Database.SaveResult result = Database.insert(opp, false);
    Test.stopTest();

    System.assert(result.isSuccess());
  }
}
