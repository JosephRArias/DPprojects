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
private class CaseTest {

    @isTest
    static void TaskShouldBeCreated() {
        // TO DO: implement unit test
        Case c = new Case(Subject = 'Test Case');
        insert c;
        List<Task> caseRelatedTask = [SELECT Id, WhatId, Subject FROM Task WHERE WhatId = :c.Id];
        System.assertEquals(1, caseRelatedTask.size());
    }
    @isTest
    static void FieldsCheck(){
        Case c = new Case(Subject = 'Test Case');
        insert c;
        Task caseRelatedTask = [SELECT Id, WhatId, Subject, ActivityDate, OwnerId, Priority FROM Task WHERE WhatId = :c.Id LIMIT 1];
        Case createdCase = [SELECT CaseNumber, OwnerId, Id FROM Case WHERE Id = :c.Id LIMIT 1];
        //Assert Subject
        System.assertEquals('Follow up on Case: ' + createdCase.CaseNumber, caseRelatedTask.Subject);
        //Assert Date
        System.assertEquals(Date.today().addDays(3), caseRelatedTask.ActivityDate);
        //Assert Priority
        System.assertEquals('High', caseRelatedTask.Priority);
        //Assert CaseId
        System.assertEquals(createdCase.Id, caseRelatedTask.WhatId);
        //Assert OwnerId
        System.assertEquals(createdCase.OwnerId, caseRelatedTask.OwnerId);
    }
}