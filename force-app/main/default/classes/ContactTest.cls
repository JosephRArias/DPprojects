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
private class ContactTest {

    @isTest
    static void testVerifyProvidedEmail() {
        // TO DO: implement unit test
        List<Contact> contacts = new List<Contact>();
        //Case 1: Invalid email format
        contacts.add(new Contact(FirstName='Test', LastName='Contact 1', Email='testemail1.email@com'));
        //Case 2: Valid email format but does not belong to either domain
        contacts.add(new Contact(FirstName='Test', LastName='Contact 2', Email='testemail2@example.com'));
        //Case 3: Valid email format and belongs to v2sa domain
        contacts.add(new Contact(FirstName='Test', LastName='Contact 3', Email='testemail3@v2sa.com'));
        //Case 4: Valid email format and belongs to gmail.com domain
        contacts.add(new Contact(FirstName='Test', LastName='Contact 4', Email='testemail4@gmail.com'));
        Test.startTest();
        ContactHelper.verifyProvidedEmail(contacts);
        //Case 1 Assertion
        System.assert(!contacts[0].getErrors().isEmpty(), 'Contact should have an error message');
        System.assertEquals('Introduced email does not fit email format', contacts[0].getErrors()[0].getMessage());
        //Case 2 Assertion
        System.assert(!contacts[1].getErrors().isEmpty(), 'Contact should have an error message');
        System.assertEquals('Introduced email does not belong to the v2sa or gmail domain', contacts[1].getErrors()[0].getMessage());
        //Case 3 Assertion
        System.assert(contacts[2].getErrors().isEmpty(), 'Contact should have no error message');
        //Case 4 Assertion
        System.assert(contacts[3].getErrors().isEmpty(), 'Contact should have no error message');
        Test.stopTest();
    }
    @isTest
    static void testBulkInsert(){
        List<Contact> contacts = new List<Contact>();
        for(Integer i = 0; i < 250; i++){
            contacts.add(new Contact(FirstName='Test', LastName='Contact ' + i, Email='testemail' + i + '@v2sa.com'));
        }
        insert contacts;
        for(Contact contact : contacts){
            System.assert(contact.getErrors().isEmpty(), 'Contact should have no error message');
        }
    }
    @isTest
    static void testErrorInsertion(){
        List<Contact> contacts = new List<Contact>();
        for(Integer i = 0; i < 250; i++){
            contacts.add(new Contact(FirstName='Test', LastName='Contact ' + i, Email='testemail' + i + '@example.com'));
        }
        try{
            insert contacts;
            System.assert(false, 'Insert should have failed due to validation errors.');
        }
        catch(System.DmlException e){
            System.assert(e.getNumDml() == 250, 'All 250 records should have failed.');
        }
    }
}