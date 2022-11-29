public with sharing class CTHealthHeaderController {
    @AuraEnabled
    public static Map<String, Integer> getPersonHealthStatusCount(){
        return CTPersonController.getHealthStatusCount();
    }
    
    @AuraEnabled
    public static Map<String, Integer> getLocationHealthStatusCount(){
        return CTLocationController.getHealthStatusCount();
    }

    @AuraEnabled
    public static List<Person__c> searchPeople(String searchTerm){
        return CTPersonController.searchPeople(searchTerm);
    }

    @AuraEnabled
    public static List<Location__c> searchLocation(String searchTerm){
        return CTLocationController.searchLocations(searchTerm);
    }
}
