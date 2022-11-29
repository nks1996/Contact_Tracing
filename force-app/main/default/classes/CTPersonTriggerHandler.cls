public with sharing class CTPersonTriggerHandler {
   public static void beforeInsertHandler(List<Person__c> newPersonsList){
    for(Person__c p : newPersonsList){
            p.Health_Status__c='Green';
            p.Token__c=CTPersonController.getToken(p.Mobile__c);
    }
   }

   public static void beforeUpdateHandler(List<Person__c> newPersonsList,Map<Id,Person__c> oldPersonMap){
    for(Person__c p : newPersonsList){
            if(p.Health_Status__c != oldPersonMap.get(p.Id).Health_Status__c ){
                p.Status_Update_Date__c = Date.today();
            }
    }
   }

   public static void afterUpdateHandler(List<Person__c> newPersonsList,Map<Id,Person__c> oldPersonMap){
        Set<Id> statusChange = new Set<Id>();
        Set<Id> redStatus = new Set<Id>();

        for(Person__c p : newPersonsList){
                if(p.Health_Status__c != oldPersonMap.get(p.Id).Health_Status__c ){
                        statusChange.add(p.Id);
                }
                if(p.Health_Status__c == 'Red' && oldPersonMap.get(p.Id).Health_Status__c != 'Red' ){
                        redStatus.add(p.Id);
                }
        }

        Set<Id> alreadyProcessed = new Set<Id>();
        alreadyProcessed.addAll(redStatus);

        Set<Id> orangeStatus = new Set<Id>();
        Set<Id> yellowStatus = new Set<Id>();

        List<Person__c> peopleToUpdate = new List<Person__c>();

        orangeStatus.addAll(CTPersonController.getCohabitants(redStatus, alreadyProcessed));

        //execute all orange status values first as that is of more vulnerability so we process all oranage records first
        // we're simply trying to avoid the code from incorreclty assigning a yellow value when the value should actually be orange...

        Set<Id> primaryContacts = CTPersonController.getPrimaryContacts(redStatus, alreadyProcessed);
        orangeStatus.addAll(primaryContacts);

        //orange first then yellow

        yellowStatus.addAll(CTPersonController.getNeighbours(redStatus, alreadyProcessed));

        yellowStatus.addAll(CTPersonController.getSecondaryContacts(primaryContacts, alreadyProcessed));

        for(Id pId : orangeStatus ){
                peopleToUpdate.add(new Person__c(Id=pId, Health_Status__c = 'Orange'));
        }

        for(Id pId : yellowStatus ){
                peopleToUpdate.add(new Person__c(Id=pId, Health_Status__c = 'Yellow'));
        }
        
        if(peopleToUpdate.size()>0){
        update peopleToUpdate;
        }

        List<Location_Tracing__c> locationTraces = CTLocationTracingController.getLocationsByPersonIds(statusChange);
        if(locationTraces != null && locationTraces.size()>0){
                Set<Id> locationIds = new Set<Id>();
                for(Location_Tracing__c lT : locationTraces ){
                        locationIds.add(lT.Location__c);
                }
                CTLocationController.updateRedScore(locationIds);
                
        }

       }

}