trigger ContactTrigger on Contact (before insert, before update) {
    ContactTriggerHandler handler = new ContactTriggerHandler();
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            handler.onBeforeInsert(Trigger.new);
        }
        else if (Trigger.isUpdate){
            handler.onBeforeUpdate(Trigger.new, Trigger.old);
        }
    }
}