public with sharing class AccountTriggerHandler {
    public AccountTriggerHandler() {

    }
    public void OnBeforeInsert(List<Account> accounts){
        AccountHelper.updateAccountOnboarding(accounts);
    }
    public void OnBeforeUpdate(List<Account> accounts){
        AccountHelper.updateAccountOnboarding(accounts);
    }
}