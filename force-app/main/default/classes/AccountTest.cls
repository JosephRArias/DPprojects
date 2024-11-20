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
private class AccountTest {

    @isTest
    static void AnnualRevenueGreaterThan500k() {
        Account acc = new Account(Name='Test Account',AnnualRevenue=500100.00);
        insert acc;
        Account updatedAccount = [SELECT Name, Id, Onboarding_Status__c FROM Account WHERE Id = :acc.Id LIMIT 1];
        System.assertEquals('In Progress', updatedAccount.Onboarding_Status__c, 'On Boarding Status should be In Progress');
        AccountHelper helper = new AccountHelper();
        System.assertNotEquals(null, helper);
    }
    @isTest
    static void AnnualRevenueLessThan500k(){
        Account acc = new Account(Name='Test Account',AnnualRevenue=200000);
        insert acc;
        Account updatedAccount = [SELECT Name, Id, Onboarding_Status__c FROM Account WHERE Id = :acc.Id LIMIT 1];
        System.assertEquals('Pending Review', updatedAccount.Onboarding_Status__c, 'On Boarding Status should be Pending Review');
        AccountHelper helper = new AccountHelper();
        System.assertNotEquals(null, helper);
    }
    @isTest
    static void AnnualRevenueChanged(){
        Account acc = new Account(Name='Test Account',AnnualRevenue=300000);
        insert acc;
        Account updatedAccount = [SELECT Name, Id, Onboarding_Status__c FROM Account WHERE Id = :acc.Id LIMIT 1];
        System.assertEquals('Pending Review', updatedAccount.Onboarding_Status__c, 'On Boarding Status should be Pending Review');
        updatedAccount.AnnualRevenue = 700500.00;
        update updatedAccount;
        Account inProgressAccount = [SELECT Name, Id, Onboarding_Status__c FROM Account WHERE Id = :updatedAccount.Id LIMIT 1];
        System.assertEquals('In Progress', inProgressAccount.Onboarding_Status__c, 'On Boarding Status should be In Progress');
        AccountHelper helper = new AccountHelper();
        System.assertNotEquals(null, helper);
    }
    @isTest
    static void AnnualRevenueIsNull(){
        Account acc = new Account(Name='Test Account');
        insert acc;
        Account updatedAccount = [SELECT Name, Id, Onboarding_Status__c FROM Account WHERE Id = :acc.Id LIMIT 1];
        System.assertEquals(null, updatedAccount.Onboarding_Status__c, 'On Boarding Status should be null');
        AccountHelper helper = new AccountHelper();
        System.assertNotEquals(null, helper);
    }
    @isTest
    static void BulkInsertionGreaterThan500k(){
        List<Account> accounts = new List<Account>();
        for(Integer i = 0; i < 250; i++){
           accounts.add(new Account(Name='Test Account ' + i,AnnualRevenue=700000.00));
        }
        insert accounts;
        List<Account> inProgressAccounts = [SELECT Name, Id, Onboarding_Status__c FROM Account WHERE Id IN :accounts];
        for(Account acc : inProgressAccounts){
            System.assertEquals('In Progress', acc.Onboarding_Status__c, 'On Boarding Status should be In Progress');
        }
        AccountHelper helper = new AccountHelper();
        System.assertNotEquals(null, helper);
    }
    @isTest
    static void BulkUpdate(){
        List<Account> accounts = new List<Account>();
        for(Integer i = 0; i < 250; i++){
           accounts.add(new Account(Name='Test Account ' + i));
        }
        insert accounts;
        List<Account> insertedAccounts = [SELECT Name, Id, Onboarding_Status__c FROM Account WHERE Id IN :accounts];
        for(Account acc : insertedAccounts){
            System.assertEquals(null, acc.Onboarding_Status__c, 'On Boarding Status should be null');
        }
        for(Account acc : insertedAccounts){
            acc.AnnualRevenue = 600000;
        }
        update insertedAccounts;
        List<Account> updatedAccounts = [SELECT Name, Id, Onboarding_Status__c FROM Account WHERE Id IN :insertedAccounts];
        for(Account acc : updatedAccounts){
            System.assertEquals('In Progress', acc.Onboarding_Status__c, 'On Boarding Status should be In Progress');
        }
        AccountHelper helper = new AccountHelper();
        System.assertNotEquals(null, helper);
    }
}