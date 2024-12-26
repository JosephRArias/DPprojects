/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class OpportunityTest {
    @isTest
    static void testStageInsert() {
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        Opportunity testOpportunityInsert = new Opportunity(
            Name = 'Test Opportunity Insert',
            StageName = 'Prospecting',
            CloseDate = Date.today(),
            AccountId = testAccount.Id
        );
        insert testOpportunityInsert;

        Account accountAfterInsert = [SELECT Latest_Opportunity_Stage__c FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals('Prospecting', accountAfterInsert.Latest_Opportunity_Stage__c);
        testOpportunityInsert.StageName = 'Qualification';
        update testOpportunityInsert;

        Account accountAfterUpdate = [SELECT Latest_Opportunity_Stage__c FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals('Qualification', accountAfterUpdate.Latest_Opportunity_Stage__c);
    }
    @isTest

    static void multipleOpportunitiesInsert(){
        Account testAccount = new Account(Name = 'Test Account');
        List<Opportunity> opportunities = new List<Opportunity>();
        List<String> stageNames = new List<String>{'Qualification', 'Prospecting', 'Needs Analysis', 'Value Proposition', 'Closed Won'};
        insert testAccount;

        for(Integer i = 0; i < 5; i++){
            opportunities.add(new Opportunity(
                Name = 'Test Opportunity Insert ' + i,
                StageName = stageNames[i],
                CloseDate = Date.today(),
                AccountId = testAccount.Id
            ));     
        }
        System.debug('Opportunities: ' + opportunities);
        insert opportunities;

        Account accountAfterInsert = [SELECT Latest_Opportunity_Stage__c FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(stageNames[4], accountAfterInsert.Latest_Opportunity_Stage__c);
        opportunities[3].StageName = 'Qualification';
        update opportunities;

        Account accountAfterUpdate = [SELECT Latest_Opportunity_Stage__c FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals('Qualification', accountAfterUpdate.Latest_Opportunity_Stage__c);
    }
    @isTest
    static void noOpportunityStageUpdate(){
        Account testAccount = new Account(Name = 'Test Account');
        List<Opportunity> opportunities = new List<Opportunity>();
        List<String> stageNames = new List<String>{'Qualification', 'Prospecting', 'Needs Analysis', 'Value Proposition', 'Closed Won'};
        insert testAccount;

        for(Integer i = 0; i < 5; i++){
            opportunities.add(new Opportunity(
                Name = 'Test Opportunity Insert ' + i,
                CloseDate = Date.today(),
                AccountId = testAccount.Id,
                StageName = stageNames[i]
            ));     
        }
        insert opportunities;

        Account accountAfterInsert = [SELECT Latest_Opportunity_Stage__c FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(stageNames[4], accountAfterInsert.Latest_Opportunity_Stage__c);
        opportunities[0].StageName = 'Qualification';
        update opportunities;

        Account accountAfterUpdate = [SELECT Latest_Opportunity_Stage__c FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals('Closed Won', accountAfterUpdate.Latest_Opportunity_Stage__c);
    }
    @isTest
    static void multipleOpportunitiesMultipleAccounts(){
        List<Account> testAccounts = new List<Account>();
        for(Integer i = 0; i<5; i++){
            testAccounts.add(new Account(Name = 'Test Account ' + i));
        }
        List<Opportunity> opportunities = new List<Opportunity>();
        List<String> stageNames = new List<String>{'Qualification', 'Prospecting', 'Needs Analysis', 'Value Proposition', 'Closed Won'};
        insert testAccounts;

        for(Integer i = 0; i < 5; i++){                                                                          
            for(Integer j = 0; j<3; j++){
                    opportunities.add(new Opportunity(
                    Name = 'Test Opportunity Insert ' + i,
                    CloseDate = Date.today(),
                    AccountId = testAccounts[i].Id,
                    StageName = stageNames[j]
                ));
                
            }     
        }
        insert opportunities;

        for (Integer i = 0; i < testAccounts.size(); i++) {
            Account account = [SELECT Latest_Opportunity_Stage__c FROM Account WHERE Id = :testAccounts[i].Id];
            System.assertEquals(stageNames[2], account.Latest_Opportunity_Stage__c);
        }
    
        for (Opportunity opp : opportunities) {
            if (opp.StageName == 'Closed Won') {
                opp.StageName = 'Needs Analysis';
            }
        }
        update opportunities;
    
        for (Integer i = 0; i < testAccounts.size(); i++) {
            Account account = [SELECT Latest_Opportunity_Stage__c FROM Account WHERE Id = :testAccounts[i].Id];
            System.assertEquals('Needs Analysis', account.Latest_Opportunity_Stage__c);
        }
    }
}