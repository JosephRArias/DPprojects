public with sharing class AccountHelper {
    public AccountHelper() {

    }
    public static void updateAccountOnboarding(List<Account> accounts){
        for(Account acc : accounts){
            
            if(acc.AnnualRevenue != null){
                
                if(acc.AnnualRevenue > 500000){
                    acc.Onboarding_Status__c = 'In Progress';
                }
                else if(acc.AnnualRevenue <= 500000){
                    acc.Onboarding_Status__c = 'Pending Review';
                }

            }
        }

    }
}