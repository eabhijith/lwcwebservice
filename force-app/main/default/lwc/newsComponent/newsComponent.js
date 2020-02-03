import { LightningElement,wire,track } from 'lwc';
import getNews from '@salesforce/apex/NewsController.fetchNewsFromEndpoint';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';


export default class NewsComponent extends LightningElement {

    @track filteredNews;
    @track noNewsFound;

    //Wire to Fetch News
    @wire(getNews)
    wiredValues({
        error,
        data
    }) {
        if (data) {
            this.news = [...data];
            this.filteredNews = [...data];
        } else {
            const evt = new ShowToastEvent({
                title: 'Error',
                message: error,
                variant: 'error'
            });
            this.dispatchEvent(evt);
        }
    };

    handleNewsSearch(event) {
        this.filteredNews = this.news.filter(ele => ele.description.toLowerCase().includes(event.target.value.toLowerCase()));
        this.noNewsFound = this.filteredNews.length == 0 ? true : false;
    }

}