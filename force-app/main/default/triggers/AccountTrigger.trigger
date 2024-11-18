trigger AccountTrigger on Account (before insert, before update) {
    AccountTriggerHandler handler = new AccountTriggerHandler();

    if(Trigger.isInsert){
        if(Trigger.isBefore){
            handler.OnBeforeInsert(Trigger.new);
        }
    }
    else if(Trigger.isUpdate){
        if(Trigger.isBefore){
            handler.OnBeforeUpdate(Trigger.new);
        }
    }


}