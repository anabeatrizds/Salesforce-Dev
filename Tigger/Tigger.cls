/*
Similar to triggers in SQL Server, Apex database triggers execute programming logic before or after events to records in Salesforce. When defining the trigger, you can specify more than one of the following events:

before insert
before update
before delete
after insert
after update
after delete
after undelete
The basic syntax for a trigger looks like the following:

*/

trigger TriggerName on ObjectName (trigger_events) {
   // code_block
}

//You only want to resort to using a trigger when you are absolutely sure that the same thing cannot be accomplished with one of our point-and-click automation tools.


//creating an Apex database trigger that creates an opportunity when a new account is entered. This trigger calls a method from a handler class, so we first need to create that.
public with sharing class AccountHandler {
    public static void CreateNewOpportunity(List<Account> accts) {
        for (Account a : accts) {
            Opportunity opp = new Opportunity();
            opp.Name = a.Name + ' Opportunity';
            opp.AccountId = a.Id;
            opp.StageName = 'Prospecting';
            opp.CloseDate = System.Today().addMonths(1);
            insert opp;
        }
    }
}

//-----exemplo 
trigger AccountTrigger on Account (before insert, before update, before
    delete, after insert, after update, after delete,  after undelete) {
    if (Trigger.isAfter && Trigger.isInsert) {
        AccountHandler.CreateNewOpportunity(Trigger.New);
    }
}

//----- exemplo 
Account acct = new Account(
    Name='Test Account 2',
    Phone='(415)555-8989',
    NumberOfEmployees=50,
    BillingCity='San Francisco');
insert acct;


//
public with sharing class AccountHandler {
    public static void CreateNewOpportunity(List<Account> accts) {
        List<Opportunity> opps = new List<Opportunity>();
        for (Account a : accts) {
            Opportunity opp = new Opportunity();
            opp.Name = a.Name + ' Opportunity';
            opp.AccountId = a.Id;
            opp.StageName = 'Prospecting';
            opp.CloseDate = System.Today().addMonths(1);
            opps.add(opp);
        }
        if (opps.size() > 0) {
            insert opps;
        }
    }
}

//vamos testar para ter certeza de que o gatilho pode lidar com uma carga de 200 registros. Como sabemos, escrever testes de unidade para garantir que o código funcione é uma prática recomendada.

@isTest
private class AccountTrigger_Test {
    @isTest static void TestCreateNewAccountInBulk() {
        // Test Setup data
        // Create 200 new Accounts
        List<Account> accts = new List<Account>();
        for(Integer i=0; i < 200; i++) {
            Account acct = new Account(Name='Test Account ' + i);
            accts.add(acct);
        }              
        // Perform Test
        Test.startTest();
        insert accts;                               
        Test.stopTest();
        // Verify that 200 new Accounts were inserted
        List<Account> verifyAccts = [SELECT Id FROM Account];
        System.assertEquals(200, verifyAccts.size());    
        // Also verify that 200 new Opportunities were inserted
        List<Opportunity> verifyOpps = [SELECT Id FROM Opportunity];                              
        System.assertEquals(200, verifyOpps.size());                             
    }
}



