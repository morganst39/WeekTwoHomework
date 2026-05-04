public class WeekTwoHomework {
//Your turn! Create a new Apex class called WeekTwoHomework. Create the following methods. You can use any criteria you like, based on the sample data in your developer org,
// with the following requirements.

// (A) A method that includes a query for a List of contacts and includes the Account Name and Industry as well. Use a loop to print the name of each Contact’s Account Name
// with System.debug.
    Public static void ContactsWithAccIndustry() {
    
     List<Contact> ContactsWithAccIndustry = [
            SELECT ID, Name, Account.Industry, Account.Name
            FROM Contact
            WHERE Account.Industry != null ];
    
    for (Contact c : ContactsWithAccIndustry) {
        System.debug('Contact: ' + c.Name);
        System.debug('Account Name: ' + c.Account.Name);
        System.debug('Industry: ' + c.Account.Industry);
     }
   }
}    
// (B) A method that includes a query for a list of Accounts AND includes all their closed-won opportunities in a subquery. Use a loop to print out the name of each Account’s 
//opportunity with System.debug.
   public static void AccountsWithClosedWonOpp() {
    
    List<Account> accountsWithClosedWonOpp = [
        SELECT Id, Name,
            (SELECT Id, Name, StageName FROM Opportunity WHERE StageName = 'Closed Won')
        FROM Account];
    
    for (Account acc : accountsWithClosedWonOpp) {
        for (Opportunity opp : acc.Opportunity) {
            System.debug('Account: ' + acc.Name + ' | Opportunity: ' + opp.Name);
        }
    }
}

//(C) A method that queries for Opportunity records that returns results in a map format.
    public static void Map<Id, Opportunity> getOppMap() {
    Map<Id, Opportunity> oppMap = new Map<Id, Opportunity>([
        SELECT Id, Name, StageName, CloseDate
        FROM Opportunity
    ]);
    
    return oppMap;
}
//(D) An aggregate results query that returns an integer equal to the total number of open opportunities in your org.
//i am getting issue compiling this method with missing signature error 
      public static void OpportunityAggreg() {
       Integer OppCount = [
        SELECT COUNT()
        FROM Opportunity
        WHERE NOT StageName LIKE 'Closed%'];  //stage name to exclude closed won or closed lost
    
        System.debug('We have ' + OppCount + ' Opportunities that are still open');
      }
