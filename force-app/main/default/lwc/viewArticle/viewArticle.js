import { LightningElement, api, wire } from 'lwc';
import { getFieldValue, getRecord } from 'lightning/uiRecordApi';
import TITLE_FIELD from '@salesforce/schema/Blog_Post__c.Title__c';
import AUTHOR_FIELD from '@salesforce/schema/Blog_Post__c.Author__c';
import AUTHOR_NAME_FIELD from '@salesforce/schema/Blog_Post__c.Author__r.Name';
import CATEGORY_FIELD from '@salesforce/schema/Blog_Post__c.Category__c';
import PUBLISHED_DATE_FIELD from '@salesforce/schema/Blog_Post__c.Published_Date__c';
import CONTENT_FIELD from '@salesforce/schema/Blog_Post__c.Content__c';

const FIELDS = [TITLE_FIELD, AUTHOR_FIELD, AUTHOR_NAME_FIELD, CATEGORY_FIELD, PUBLISHED_DATE_FIELD, CONTENT_FIELD];

export default class ViewArticle extends LightningElement {

    @api recordId;
    title;
    author;
    category;
    publishedDate;
    content;
    currentRecordId;

    connectedCallback(){
        console.log('Record ID:', this.recordId);
    }
    @wire(getRecord, {recordId: '$recordId', fields: FIELDS})
    processRecordData({error, data}){
        if(data){
            this.title = getFieldValue(data, TITLE_FIELD);
            this.author = getFieldValue(data, AUTHOR_NAME_FIELD);
            this.category = getFieldValue(data, CATEGORY_FIELD);
            this.publishedDate = getFieldValue(data, PUBLISHED_DATE_FIELD);
            this.content = getFieldValue(data, CONTENT_FIELD);
        }
        else{
            console.error('Error fetching object data: ', error);
        }
    }
}