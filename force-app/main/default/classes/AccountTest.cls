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
        System.assertEquals('In Progress', inProgressAccount.Onboarding_Status__c, 'On Boarding Status should be Pending Review');
    }
}