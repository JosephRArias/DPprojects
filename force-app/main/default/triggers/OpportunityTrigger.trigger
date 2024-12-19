trigger OpportunityTrigger on Opportunity (after insert, after update) {
    OpportunityTriggerHandler handler = new OpportunityTriggerHandler();
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            handler.onAfterInsert(Trigger.new, Trigger.oldMap);
        }
        else if (Trigger.isUpdate){
            handler.onAfterUpdate(Trigger.new, Trigger.oldMap);
        }
    }
}