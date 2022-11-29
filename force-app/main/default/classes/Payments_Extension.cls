public class Payments_Extension {
    
    
    //payment__c record variable to hold the payment information
    //
   
    public Payment__c thisPayment {get;set;}
    public Statement__c thisStatement {get;set;}
    public Map<Id,String> recordTypeMap {get;set;}
    public boolean success {get;set;}
    
    public Payments_Extension(ApexPages.StandardController scon){
        
        if(scon.getRecord() instanceOf Statement__c){
            thisStatement = [SELECT Id, Name, Rental_Agreement__r.Renter__c, Balance__c FROM Statement__c WHERE Id =: scon.getId() ];
        }
        success=false;
        recordTypeMap = new Map<Id,String>();
        
        //query all the record types in the Payment Object
        // then store it in the map
        for(RecordType r : [SELECT Id, Name FROM RecordType WHERE SobjectType = 'Payment__c']){
            recordTypeMap.put(r.Id,r.Name);
        }
        
        //instantiate the payment
        thisPayment = new Payment__c();
        if(scon.getRecord() instanceOf Statement__c){
            thisPayment.Statement__c = scon.getId();
            thisPayment.Amount__c = thisStatement.Balance__c;
        }
        
        //if it is a guest user then preset to credit card
        //
        
        if(getIsGuest()){
            for(Id i : recordTypeMap.keySet()){
                if(recordTypeMap.get(i)=='Credit Card'){
                    thisPayment.RecordTypeId=i;
                }
            }
        }
        else if(scon.getRecord() instanceOf Statement__c){
            Contact renter = [SELECT Id, firstName, lastName, mailingStreet, mailingCity, mailingState, mailingpostalcode FROM Contact WHERE ID =: thisStatement.Rental_Agreement__r.Renter__c];
            thisPayment.Billing_Name__c = renter.FirstName+' '+renter.LastName;
            thisPayment.Billing_Street__c = renter.MailingStreet;
            thisPayment.Billing_City__c = renter.MailingCity;
            thisPayment.Billing_State__c = renter.MailingState;
            thisPayment.Billing_Postal_Code__c = renter.MailingPostalCode;
        }
        
    }
    
     public static Map<String,String> monthmap = new Map<String,String>();
    
    //this method will process and save our payments
    //reports any errors in the attempt
    //
    
    public PageReference savePayment(){
        monthmap.put('January','01');
        monthmap.put('February','02');
        monthmap.put('March','03');
        monthmap.put('April','04');
        monthmap.put('May','05');
        monthmap.put('June','06');
        monthmap.put('July','07');
        monthmap.put('August','08');
        monthmap.put('September','09');
        monthmap.put('October','10');
        monthmap.put('November','11');
        monthmap.put('December','12');
        
      success = false;
      String paymentType = recordTypeMap.get(thisPayment.RecordTypeId);
        //validation- if all the fields were filled or not
        if(validateFields(paymentType)){
            //process credit card payments
            if(paymentType=='Credit Card'){
                //create a request wrapper for authorize.net
                API_authorizeDotNet.authnetReq_Wrapper req = new API_authorizeDotNet.authnetReq_Wrapper();
                //set the wrapper values
                req.amt=String.valueOf(thisPayment.Amount__c);
                req.firstname=(thisPayment.Billing_Name__c.contains(' '))?thisPayment.Billing_Name__c.subStringbefore(' '):thisPayment.Billing_Name__c;
                req.lastname=(thisPayment.Billing_Name__c.contains(' '))?thisPayment.Billing_Name__c.subStringafter(' '):thisPayment.Billing_Name__c;
                req.billstreet=thisPayment.Billing_Street__c;
                req.billcity=thisPayment.Billing_City__c;
                req.billstate=thisPayment.Billing_State__c;
                req.billzip=thisPayment.Billing_Postal_Code__c;
                
                //set credit card information on the request wrapper
                req.ccnum=thisPayment.Credit_Card_Number__c;
                req.ccexp=monthmap.get(thisPayment.Credit_Card_Expiration_month__c)+thisPayment.Expiration_Year__c;
                req.ccsec=thisPayment.Credit_Card_Security_Card__c;
                
                //give this req a name
                req.ordername='Payment of '+[SELECT Id, Name FROM Statement__c WHERE Id =:thisPayment.Statement__c].Name;
                //process our authorize.net request
                API_authorizeDotNet.authNetResp_Wrapper res = API_authorizeDotNet.authdotnetCharge(req);
                thisPayment.Authorize_net_Transaction_Id__c = res.transactionID;
                thisPayment.Authorize_net_Authorization_code__c = res.authorizationCode;
                thisPayment.Authorize_net_Response__c=res.responseCode + '|' +res.responseReasonText;
                //if the transaction failed
                if(res.responseCode!='1' || res.responseReasonText !='This transaction has been approved.'){
                    thisPayment.Status__c ='Failed';
                    ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'Payment Failed'));
                    ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, +res.responseReasonText));
                    
                    return null;
                }
                
            }
            //successful transaction
            thisPayment.Status__c='Paid';
            thisPayment.Payment_Date__c=System.now();
            upsert thisPayment;
            success=true;
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.confirm,'Payment Successful'));
            
            try{
                //if there is an email provided by the renter
                if(thisStatement != null && thisStatement.Rental_Agreement__r.renter__r.Email!=null){
                    //construct message
                    Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
                    msg.settoaddresses(new List<String> {thisStatement.Rental_Agreement__r.renter__r.Email});
                    msg.setSubject('Payment Confirmation');
                    msg.setHtmlBody('Your payment of '+thisPayment.Amount__c+' has been successfully processed. <br/><br/> Thank you!!');
                    msg.setPlainTextBody('Your payment of '+thisPayment.Amount__c+'has been successfully processed \n \n  Thank you!!');
                    
                    //send the email
                    Messaging.sendEmail(new List<Messaging.SingleEmailMessage> {msg});
                }
            }
            catch(Exception e){
                /*
                System.debug('Email nai jara bhai... getCause.'+e.getCause());
                System.debug('Email nai jara bhai...getInaccessibleFields.'+e.getInaccessibleFields());
                System.debug('Email nai jara bhai...getLineNumber.'+e.getLineNumber());
                System.debug('Email nai jara bhai..getMessage..'+e.getMessage());
                System.debug('Email nai jara bhai...getStackTraceString.'+e.getStackTraceString());
                System.debug('Email nai jara bhai...getTypeName.'+e.getTypeName());
*/
              
            }
            
            
        }
        
        else{
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'Please fill out all the details!!!!!!! duh'));
        }
        return null;
        
    }
    
    public boolean validateFields(String paymentType){
        boolean valid = true;
        //check common fields
        if(thisPayment.Statement__c==null )
            valid=false;
        if(thisPayment.Amount__c==null )
            valid=false;
        if(String.isBlank(thisPayment.Billing_Name__c))
            valid=false;
        if(String.isBlank(thisPayment.Billing_Street__c))
            valid=false;
        if(String.isBlank(thisPayment.Billing_City__c))
            valid=false;
        if(String.isBlank(thisPayment.Billing_State__c))
            valid=false;
        if(String.isBlank(thisPayment.Billing_Postal_Code__c ))
            valid=false;
        //check specific fields related to the payment type
        //check fields when payment type is check
        
        if(paymentType=='Check'){
            if(String.isBlank(thisPayment.Check_Account_Number__c))
                valid=false;
            if(String.isBlank(thisPayment.Check_Routing_Number__c))
                valid=false;
        }
        //check specific fields related to the payment type
        //check fields when payment type is credit card
        else if(paymentType=='Credit Card'){
            if(String.isBlank(thisPayment.Credit_Card_Number__c))
                valid=false;
            if(String.isBlank(thisPayment.Credit_Card_Expiration_month__c))
                valid=false;
            if(String.isBlank(thisPayment.Expiration_Year__c))
                valid=false;
            if(String.isBlank(thisPayment.Credit_Card_Security_Card__c))
                valid=false;
            
        }
        return valid;
        
    }
    
    public boolean getIsGuest(){
        
        return [SELECT Id, userType FROM Profile WHERE Id =:userInfo.getProfileId()].userType=='Guest';

    }
    
    public List<selectoption> getPaymentRecordTypes(){
        List<selectoption> temp = new List<selectoption>();
        temp.add(new SelectOption('','Select Payment Method'));
        for(id i : recordTypeMap.keySet()){
            temp.add(new SelectOption(i,recordTypeMap.get(i)));
        }
        return temp;
        
    }
    
    public List<selectoption> getExpirationYears(){
        List<selectoption> temp = new List<selectoption>();
        for(integer i=0; i<5; i++){
            String y = ''+System.today().addYears(i).year();
            temp.add(new SelectOption(y,y));
        }
        return temp;
    }
    
}