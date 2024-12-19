public with sharing class OpportunityTriggerHandler {
    public OpportunityTriggerHandler() {

    }
    public void onAfterInsert(List<Opportunity> opportunities, Map<Id,Opportunity> opportunityOldMap){
        Map<Id,Account> accountsToUpdate = OpportunityHelper.returnAccountsToUpdate(opportunities, opportunityOldMap);
        if(!accountsToUpdate.isEmpty()){
            update accountsToUpdate.values();
        }
    }
    public void onAfterUpdate(List<Opportunity> opportunities, Map<Id,Opportunity> opportunityOldMap){
        Map<Id,Account> accountsToUpdate = OpportunityHelper.returnAccountsToUpdate(opportunities, opportunityOldMap);
        if(!accountsToUpdate.isEmpty()){
            update accountsToUpdate.values();
        }
    }
}