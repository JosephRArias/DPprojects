public with sharing class InteractionController {
    @AuraEnabled
    public static Interaction__c createComment(Interaction__c commentRec){
        try {
            insert commentRec;
            return commentRec;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }  
    }
    @AuraEnabled(cacheable=true)
    public static List<Interaction__c> getComments(String relatedRecordId) {
        return [SELECT Id, Comment_Body__c, CreatedDate, CreatedBy.Name, CreatedBy.SmallPhotoURL FROM Interaction__c
                WHERE Blog_Post__c = :relatedRecordId ORDER BY CreatedDate DESC];
    }
}