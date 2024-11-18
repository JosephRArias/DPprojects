public with sharing class ContactTriggerHandler {
    public ContactTriggerHandler() {

    }
    public void onBeforeInsert(List<Contact> contacts){
        ContactHelper.verifyProvidedEmail(contacts);
    }
    public void onBeforeUpdate(List<Contact> updatedContacts, List<Contact> oldContacts){
        List<Contact> emailsToVerify = new List<Contact>();
        for(Integer i = 0; i < updatedContacts.size(); i++){
            Contact updatedContact = updatedContacts[i];
            Contact oldContact = updatedContacts[i];
            if(updatedContact.Email != oldContact.Email){
                emailsToVerify.add(updatedContact);
            }
        }
        if(!emailsToVerify.isEmpty()){
            ContactHelper.verifyProvidedEmail(emailsToVerify);
        }
    }
}