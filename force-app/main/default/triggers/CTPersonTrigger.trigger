trigger CTPersonTrigger on Person__c (before insert, before update, after insert, after update, before delete, after delete, after undelete) {
switch on Trigger.operationType {
    when BEFORE_INSERT {
        CTPersonTriggerHandler.beforeInsertHandler(Trigger.new);
        
    }
    when BEFORE_UPDATE {
        CTPersonTriggerHandler.beforeUpdateHandler(Trigger.new,Trigger.oldMap);
        
    }
    when BEFORE_DELETE {
        
    }
    when AFTER_INSERT {
            
    }
    when AFTER_UPDATE {
        CTPersonTriggerHandler.afterUpdateHandler(Trigger.new,Trigger.oldMap);
    }
    when AFTER_DELETE {
        
    }
    when AFTER_UNDELETE {
        
    }
}
}