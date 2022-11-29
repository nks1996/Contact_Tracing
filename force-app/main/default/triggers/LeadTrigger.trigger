trigger LeadTrigger on Lead (before insert, after insert, before update, after update) {
    
    switch on Trigger.operationType {
        
     when BEFORE_INSERT{
         LeadTriggerHandler.beforeInsertHandler(Trigger.new);
    }
         
       when AFTER_INSERT{
         LeadTriggerHandler.afterInsertHandler(Trigger.new);
           //to cause recursive trigger problem
           //Lead l = new Lead(LastName='X', Industry ='Agriculture', Company = 'X', Status = 'Open - Not Converted');
           //insert l;
    }
   
     when BEFORE_UPDATE{
          LeadTriggerHandler.beforeUpdateHandler(Trigger.new,Trigger.oldMap);
    }
    }
    
        
}