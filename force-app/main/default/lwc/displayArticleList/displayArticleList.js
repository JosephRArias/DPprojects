import { LightningElement, wire } from 'lwc';
import getBlogPosts from '@salesforce/apex/ArticleController.getBlogPosts';

export default class DisplayArticleList extends LightningElement {


@wire(getBlogPosts)
blogPosts
}