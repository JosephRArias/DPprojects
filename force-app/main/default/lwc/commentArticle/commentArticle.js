import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import { refreshApex } from '@salesforce/apex';
import COMMENT_FIELD from '@salesforce/schema/Interaction__c.Comment_Body__c';
import INTERACTION_FIELD from '@salesforce/schema/Interaction__c.Interaction_Type__c';
import saveComment from '@salesforce/apex/InteractionController.createComment';
import getComments from '@salesforce/apex/InteractionController.getComments';

export default class CommentArticle extends LightningElement {
    
    @api recordId;
    commentBody = COMMENT_FIELD;

    @wire(getComments, { relatedRecordId: '$recordId' })
    comments;
    
    commentRec = {
        Comment_Body__c: this.commentBody,
        Blog_Post__c: this.recordId,
        Interaction_Type__c : 'Comment'
    };

    handleChange(event) {
        this.commentRec.Comment_Body__c = event.target.value;
    }
    handlePostComment() {
        this.commentRec.Blog_Post__c = this.recordId;
        console.log('Value--> ' + JSON.stringify(this.commentRec));
        saveComment({ 'commentRec' : this.commentRec })
            .then(() => {
                this.commentRec.Comment_Body__c = '';
            })
            .catch(error => {
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Error Posting Comment',
                    message: error.body.message,
                    variant: 'error'
                }));
            });
    }

}