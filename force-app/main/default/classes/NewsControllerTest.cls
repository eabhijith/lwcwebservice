/**
 * @File Name          : NewsControllerTest.cls
 * @Description        : 
 * @Author             : eabhijith@wefoxgroup.com
 * @Group              : 
 * @Last Modified By   : eabhijith@wefoxgroup.com
 * @Last Modified On   : 2/3/2020, 10:12:46 PM
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    2/3/2020   eabhijith@wefoxgroup.com     Initial Version
**/
@isTest
public with sharing class NewsControllerTest implements HttpCalloutMock{

    @isTest static void testGetCallout() {
    // Set mock callout class 
    Test.setMock(HttpCalloutMock.class, new NewsController()); 
    // This causes a fake response to be sent
    // from the class that implements HttpCalloutMock. 
    HttpResponse response = NewsController.fetchNewsFromEndpoint();
    // Verify that the response received contains fake values
    String actualValue = response.getBody();
    System.debug(response.getBody());
    String expectedValue = '{"animals": ["majestic badger", "fluffy bunny", "scary bear", "chicken", "mighty moose"]}';
    System.assertEquals(actualValue, expectedValue);
    System.assertEquals(200, response.getStatusCode());
}
}

