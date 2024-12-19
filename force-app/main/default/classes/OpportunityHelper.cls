public with sharing class OpportunityHelper {
    public OpportunityHelper() {

    }
    public static Map<Id,Account> returnAccountsToUpdate(List<Opportunity> opportunities, Map<Id,Opportunity> opportunitiesOldMap){
        Map<Id,Account> accountsToUpdate = new Map<Id,Account>();

        for(Opportunity opp : opportunities){
            if(opportunitiesOldMap == null && opp.AccountId != null){
                    accountsToUpdate.put(opp.AccountId, new Account(
                        Id = opp.AccountId,
                        Latest_Opportunity_Stage__c = opp.StageName
                    ));
            }
            else if(opportunitiesOldMap != null){
                Opportunity oldOpportunity = opportunitiesOldMap.get(opp.Id);
                if(opp.StageName != oldOpportunity.StageName && opp.AccountId != null){
                        accountsToUpdate.put(opp.AccountId, new Account(
                            Id = opp.AccountId,
                            Latest_Opportunity_Stage__c = opp.StageName
                        ));
                }
            }
        }
        return accountsToUpdate;
    }
}