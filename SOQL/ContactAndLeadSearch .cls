//To pass this challenge, create an Apex class that returns both contacts and leads that have first or last name matching the incoming parameter.
///The Apex class must be called ContactAndLeadSearch and be in the public scope
//The Apex class must have a public static method called searchContactsAndLeads
///The method must accept an incoming string as a parameter
//The method should then find any contact or lead that matches the string as part of either the first or last name
//The method should finally use a return type of List<List< SObject>>
//Because SOSL indexes data for searching, you must create a Contact record and Lead record before checking this challenge. Both records must have the last name Smith. The challenge uses these records for the SOSL search

public class ContactAndLeadSearch {
    public static List<List<SObject>> searchContactsAndLeads(String search){
        List<List<SObject>> searchList = [FIND 'Smith' IN ALL FIELDS 
                                          RETURNING Contact, Lead (FirstName, LastName)];
        return searchList;
    }
}


/*Put this below code -> debug window ---------------------------------------

// Add account and related contact
Account acct = new Account(
    Name='Smith Computing',
    Phone='(415)555-1212',
    NumberOfEmployees=50,
    BillingCity='San Francisco');
insert acct;

// Once the account is inserted, the sObject will be 
// populated with an ID.
// Get this ID.
ID acctID = acct.ID;

// Add a contact to this account.
Contact con = new Contact(
    FirstName='Carol',
    LastName='Smith',
    Phone='(415)555-1212',
    Department='Wingo',
    AccountId=acctID);
insert con;

// Add account with no contact
Lead newLead = new Lead(
    FirstName='Tizen',
    LastName='Smith',
    Phone='(310)555-1213',
	Company='IGATE',
	LeadSource='Web');
insert newLead;   

*/