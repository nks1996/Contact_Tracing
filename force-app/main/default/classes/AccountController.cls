public class AccountController {
    
    public static List<Account> insertAccounts(List<Account> accountListToInsert){
        insert accountListToInsert;
        return accountListToInsert;
    }
    
    public static Account insertAccount(Account singleAccountToInsert){
        insert singleAccountToInsert;
        return singleAccountToInsert;
    }
    
    public static List<Account> getAllAccounts(){
        List<Account> accList = [SELECT Id, Name, Phone, Rating, Industry FROM Account];
        return accList;
    }
    
    public static void printAllAccounts(){
        List<Account> accList = getAllAccounts();
        for(Account acc : accList){
            System.debug('The Account Name is: '+acc.Name+', The Account Phone is :'+acc.Phone);
        }
    }
    
    public static Integer getAccountSize(){
        List<Account> accList = getAllAccounts();
        return accList.size();
    }
    
    public static void updateAvgCaseResolutionDays(Id accountId){
        Integer totalDays = 0, totalCases = 0;
        // retrieve all the cases for this account
        // get resolution days for each account (ClosedDate - CreatedDate)
        for(Case caseObj : [SELECT Id, CreatedDate, ClosedDate
                             FROM Case
                             WHERE IsClosed=true
                            	AND AccountId =: accountId]){
            // increase number of cases
            totalCases++;
            // get duration in days and add it to totalDays
            totalDays += caseObj.CreatedDate.date().daysBetween(caseObj.ClosedDate.date());
        }
        Decimal resolutionDays = totalDays/totalCases;
        // update account object
        Account acc = new Account(Id=accountId, Avg_Case_Resolution_Days__c = resolutionDays);
        update acc;
    }
    
    public static void updateAvgCaseResolutionDaysMultiple(List<Id> accountIds){
        //Integer totalDays = 0, totalCases = 0;
        Map<Id,Integer> accTotalCasesMap = new Map<Id,Integer>();
        Map<Id,Integer> accTotalDaysMap = new Map<Id,Integer>();
        List<Account> accToUpdate = new List<Account>();

        // retrieve all the cases for this account
        // get resolution days for each account (ClosedDate - CreatedDate)
        for(Case caseObj : [SELECT Id, CreatedDate, ClosedDate, AccountId
                             FROM Case
                             WHERE IsClosed=true
                            	AND AccountId IN :accountIds]){
            
            //only put in the map if the key doesn't already exist
            if(! accTotalCasesMap.containsKey(caseObj.AccountId)){
                accTotalCasesMap.put(caseObj.AccountId,0);
                accTotalDaysMap.put(caseObj.AccountId,0);
            }
            Integer totalCases = accTotalCasesMap.get(caseObj.AccountId);
            totalCases++;
            accTotalCasesMap.put(caseObj.AccountId,totalCases);

            Integer totalDays = accTotalDaysMap.get(caseObj.AccountId);
            totalDays += caseObj.CreatedDate.date().daysBetween(caseObj.ClosedDate.date());
            accTotalDaysMap.put(caseObj.AccountId,totalDays);
           
        }

        for(Id i : accTotalCasesMap.keySet() ){
            Decimal resolutionDays = accTotalDaysMap.get(i)/accTotalCasesMap.get(i);
            accToUpdate.add(new Account(Id=i, Avg_Case_Resolution_Days__c = resolutionDays));
        }

        update accToUpdate;
    }



}