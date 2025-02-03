public with sharing class CaseHelper {
    public CaseHelper() {

    }
    public static void createCaseTask(List<Case> createdCases){
        List<Task> createdTasks = new List<Task>();
        for(Case currentCase : createdCases){
            Task relatedTask = new Task();
            relatedTask.Subject = 'Follow up on Case: ' + currentCase.CaseNumber;
            relatedTask.ActivityDate = (Date) currentCase.CreatedDate.date().addDays(3);
            relatedTask.Priority = 'High';
            relatedTask.WhatId = currentCase.Id;
            relatedTask.OwnerId = currentCase.OwnerId;
            createdTasks.add(relatedTask);
        }
        insert createdTasks;
    }
}