public class OppProfileUpdation {

    public static void updateProfile(List<Id> oppIds){
        List<Opportunity> oppListTotal = [SELECT Id, Amount, Profile__c FROM Opportunity WHERE Id =: oppIds];
        List<Opportunity> oppListToUpdate = new List<Opportunity>();
        for(Opportunity opp : oppListTotal){
            // get opp record
            if(opp.Amount == null){
                opp.Profile__c='Low';
            }else if(opp.Amount <10000){
                opp.Profile__c = 'Low';
            } else if (opp.Amount > 50000){
                opp.Profile__c = 'High';
            } else{
                opp.Profile__c = 'Medium';
            }
              oppListToUpdate.add(opp);           
            // update opportunity
        }
        update oppListToUpdate;
    }
}