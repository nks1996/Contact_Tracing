public class LeadTriggerHandler {
    
    public static Boolean alreadyExecuted = false;
    
    public static void beforeInsertHandler(List<Lead> leadRecords){ 
        for(Lead newLeadRecord : leadRecords){
            // if lead source is blank, change it to 'Other'
            if(String.isBlank(newLeadRecord.LeadSource)){
                newLeadRecord.LeadSource = 'Other';
            }
            if(String.isBlank(newLeadRecord.Industry)){
                newLeadRecord.addError('Industry field cannot be blank');
            }
        }
    }
    
    public static void afterInsertHandler(List<Lead> leadRecords){ 
        List<Task> taskListToInsert = new List<Task>();
        for(Lead newLeadRecord : leadRecords){
            taskListToInsert.add(new Task(Subject ='Call', Priority = 'Normal', Status = 'In Progress', WhoId= newLeadRecord.Id, Description='task made by LeadTrigger'));      
        }
        insert taskListToInsert;
        
        if(LeadTriggerHandler.alreadyExecuted == false){
            LeadTriggerHandler.alreadyExecuted=true;
            Lead l = new Lead(LastName ='XYZ',Industry='Agriculture',Status='Open - Not Converted', Company='badmaaashCompany');
            insert l;
            
        }
    }
    
    public static void beforeUpdateHandler(List<Lead> leadRecords, Map<ID,Lead> triggerOldMap){ 
        for(Lead newLeadRecord : leadRecords){
            //preventing status change from open to closed direclty.
            if((newLeadRecord.Status =='Closed - Converted' || newLeadRecord.Status =='Closed - Not Converted' ) && triggerOldMap.get(newLeadRecord.Id).Status == 'Open - Not Contacted'){
                newLeadRecord.Status.addError('You cannot move a lead record from Open - Not Contacted to Closed - Converted / Closed - Not Converted directly!');
                
            }
            if(String.isBlank(newLeadRecord.LeadSource)){
                newLeadRecord.LeadSource = 'Other';
            }
        }
        
    }
    
}