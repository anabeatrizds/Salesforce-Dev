//Create an Apex class that returns a List of Account objects for a user-specified state.
//Create an Apex class that contains a static method:
//Name: AccountUtils
//Method name: accountsByState
//The method must return the ID and name of all Account objects that match the BillingState for the state abbreviation passed to the method

public class AccountUtils {
    public static List<Account> accountsByState(String acctState){
        List<Account> listaConta = [SELECT Id, Name FROM Account WHERE BillingState = :acctState]; //new List<Account>();
        return listaConta;
    }
}