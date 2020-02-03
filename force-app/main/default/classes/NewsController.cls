/**
 * @File Name          : NewsController.cls
 * @Description        : 
 * @Author             : eabhijith@wefoxgroup.com
 * @Group              : 
 * @Last Modified By   : eabhijith@wefoxgroup.com
 * @Last Modified On   : 2/3/2020, 10:08:09 PM
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    2/3/2020   eabhijith@wefoxgroup.com     Initial Version
**/
public with sharing class NewsController {

    @AuraEnabled(cacheable=true)
    public static List<NewsItemWrapper>  fetchNewsFromEndpoint() {
        List<NewsItemWrapper> newsItemWrapperList = new List<NewsItemWrapper>();

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://news.yahoo.com/rss/entertainment');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.

        if (response.getStatusCode() == 200) {
            Dom.Document doc = response.getBodyDocument();
            Dom.XMLNode channelItems = doc.getRootElement().getChildElement('channel', null);
            // Deserialize the JSON string into collections of primitive data types.
            Integer count = 0;
            for (Dom.XmlNode nodeItem : channelItems.getChildElements()) {
                if(nodeItem.getName() == 'item'){
                    NewsItemWrapper newsWrapperObj =  new NewsItemWrapper();
                    count++;
                    newsWrapperObj.key = count;
                    newsWrapperObj.title = nodeItem.getChildElement('title', null).getText();
                    newsWrapperObj.description = nodeItem.getChildElement('description', null).getText();
                    //newsWrapperObj.pubDate = Datetime.parse(nodeItem.getChildElement('pubDate', null).getText());
                    newsWrapperObj.link = nodeItem.getChildElement('link', null).getText();
                    newsItemWrapperList.add(newsWrapperObj);
                }
            }
        } else {
            //Throw Aura Exception later here...
        }

        return newsItemWrapperList;
    }

    Class NewsItemWrapper{

        @AuraEnabled
        public Integer key {get;set;}

        @AuraEnabled
        public String title {get;set;}

        @AuraEnabled
        public string description {get;set;}

        @AuraEnabled
        public DateTime pubDate {get;set;}

        @AuraEnabled
        public string link{get;set;}

    }
}
