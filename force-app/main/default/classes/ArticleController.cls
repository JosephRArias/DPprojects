public with sharing class ArticleController {

    @AuraEnabled(cacheable=true)
    public static List<Blog_Post__c> getBlogPosts() {
        return [SELECT Author__c, Id, CreatedDate, CreatedBy.Name, CreatedBy.SmallPhotoURL, Category__c, Title__c, Content__c FROM Blog_Post__c
                ORDER BY CreatedDate DESC];
    }

}