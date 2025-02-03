trigger CaseTrigger on Case (after insert) {
CaseTriggerHandler taskHandler = new CaseTriggerHandler();
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            taskHandler.onAfterInsert(Trigger.new);
        }
    }
}