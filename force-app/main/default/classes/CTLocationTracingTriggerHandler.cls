public with sharing class CTLocationTracingTriggerHandler {
    
    public static void beforeInsert(List<Location_Tracing__c> newRecordsList){

        List<Location_Tracing__c> lTListReturn = new List<Location_Tracing__c>();
        lTListReturn = CTLocationTracingController.checkDuplicates(newRecordsList);

        List<Location_Tracing__c> lTListToInsert = new List<Location_Tracing__c>();
        
        if(lTListReturn.size()>0){
        for(Location_Tracing__c lT : lTListReturn ){
            lT.addError('Duplicate Found! cannot save this record' +'\nThe duplicate person Id : '+lT.Person__c+' and locationID: '+lT.Location__c);
        }
        }else if(lTListReturn.size()==0){
            for(Location_Tracing__c lT : lTListReturn ){
                lTListToInsert.add(lT);
            }
        }
        insert lTListToInsert;

    }
}