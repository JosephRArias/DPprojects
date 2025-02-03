public with sharing class CaseTriggerHandler {
    public CaseTriggerHandler() {

    }
    public void onAfterInsert(List<Case> cases){
        CaseHelper.createCaseTask(cases);
    }
}