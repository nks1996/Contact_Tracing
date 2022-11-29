public with sharing class CTPeopleTracingTriggerHandler {
    
    public static void beforeInsert(List<People_Tracing__c> newRecordsList){

        List<People_Tracing__c> pTListReturn = new List<People_Tracing__c>();
        pTListReturn = CTPeopleTracingController.checkDuplicates(newRecordsList);

        List<People_Tracing__c> pTListToInsert = new List<People_Tracing__c>();
        
        if(pTListReturn.size()>0){
        for(People_Tracing__c pT : pTListReturn ){
            pT.addError('Duplicate Found! cannot save this record' +'\nThe duplicate person Ids are: '+pT.Person_1__c+' and '+pT.Person_2__c);
        }
        }else if(pTListReturn.size()==0){
            for(People_Tracing__c pT : pTListReturn ){
                pTListToInsert.add(pT);
            }
        }
        insert pTListToInsert;
    }
}