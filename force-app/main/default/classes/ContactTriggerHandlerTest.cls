@isTest
public with sharing class ContactTriggerHandlerTest {

@TestSetup
public static void makeData(){
List<Account> accList = new List<Account>();
accList.add(new Account(Name='Test1'));
accList.add(new Account(Name='Test2'));
insert accList;

List<Contact> contList = new List<Contact>();
contList.add(new Contact(LastName='Con1',AccountId=accList[0].Id, Active__c = TRUE));
contList.add(new Contact(LastName='Con2',AccountId=accList[0].Id, Active__c = TRUE));
contList.add(new Contact(LastName='Con3',AccountId=accList[0].Id));
contList.add(new Contact(LastName='Con4',AccountId=accList[0].Id));
contList.add(new Contact(LastName='Con5',AccountId=accList[1].Id));

insert contList;

}


@isTest
public static void afterInsertHandlerTest2(){

List<Account> accQueryReturnList = [SELECT Id, Name, Active_Contacts__c FROM Account];

System.assertEquals(2, accQueryReturnList.size());
for(Account acc: accQueryReturnList ){
if(acc.Name=='Test1'){
System.assertEquals(2, acc.Active_Contacts__c);
}
if(acc.Name=='Test2'){
System.assertEquals(0, acc.Active_Contacts__c);
}
}

List<Contact> conQueryReturnList = [SELECT Id, Name FROM Contact];
System.assertEquals(5, conQueryReturnList.size());
}

@isTest

public static void afterInserHandlerBulk(){
Account accQueryRec = [ SELECT Id, Name FROM Account WHERE Name ='Test1'];

List<Contact> contList = new List<Contact>();
for(Integer i = 1; i<=1000; i++){
contList.add(new Contact(LastName='Test Contact: '+i, AccountId=accQueryRec.Id, Active__c = TRUE));
}
insert contList;

List<Account> accListQuery = [Select Id, Name, Active_Contacts__c from Account];
System.assertEquals(2,accListQuery.size());

for(Account acc: accListQuery ){
if(acc.Name=='Test1'){
System.assertEquals(1002, acc.Active_Contacts__c);
}
if(acc.Name=='Test2'){
System.assertEquals(0, acc.Active_Contacts__c);
}
}

List<Contact> conQueryReturnList = [SELECT Id, Name FROM Contact];
System.assertEquals(1005, conQueryReturnList.size());


}

@isTest
public static void afterUpdateHandlerTest1(){

List<Contact> conList = [SELECT Id, LastName FROM Contact];
for(Contact con : conList){
if(con.LastName=='Con3' || con.LastName =='Con4'){
con.Active__c = TRUE;
}
}

Test.startTest();
update conList;
Test.stopTest();

List<Account> accListQuery = [Select Id, Name, Active_Contacts__c from Account];
System.assertEquals(2,accListQuery.size());

for(Account acc: accListQuery ){
if(acc.Name=='Test1'){
System.assertEquals(4, acc.Active_Contacts__c);
}
if(acc.Name=='Test2'){
System.assertEquals(0, acc.Active_Contacts__c);
}
}

System.assertEquals(5, conList.size());
}

@isTest
public static void afterUpdateHandlerTest2(){

List<Contact> conList = [SELECT Id, LastName FROM Contact];
Account accQueryRec = [SELECT Id, Name FROM Account WHERE Name = 'Test2'];
for(Contact con : conList){
if(con.LastName=='Con3'){
con.Active__c = TRUE;
con.AccountId = accQueryRec.Id;
}
}

Test.startTest();
update conList;
Test.stopTest();

List<Account> accListQuery = [Select Id, Name, Active_Contacts__c from Account];
System.assertEquals(2,accListQuery.size());

for(Account acc: accListQuery ){
if(acc.Name=='Test1'){
System.assertEquals(2, acc.Active_Contacts__c);
}
if(acc.Name=='Test2'){
System.assertEquals(1, acc.Active_Contacts__c);
}
}

System.assertEquals(5, conList.size());

}

@isTest
public static void afterDeleteHandlerTest(){

List<Contact> conList = [SELECT Id, LastName FROM Contact WHERE Name IN ('Con1','Con5')];

Test.startTest();
delete conList;
Test.stopTest();

List<Account> accListQuery = [Select Id, Name, Active_Contacts__c from Account];
System.assertEquals(2,accListQuery.size());

for(Account acc: accListQuery ){
if(acc.Name=='Test1'){
System.assertEquals(1, acc.Active_Contacts__c);
}
if(acc.Name=='Test2'){
System.assertEquals(0, acc.Active_Contacts__c);
}
}
List<Contact> conList3 = [Select Id, LastName from Contact];
System.assertEquals(3, conList3.size());

}

@isTest
public static void afterUndeleteHandlerTest(){

List<Contact> conList = [SELECT Id, LastName FROM Contact WHERE Name IN ('Con1','Con5')];
delete conList;

Test.startTest();
undelete conList;
Test.stopTest();

List<Account> accListQuery = [Select Id, Name, Active_Contacts__c from Account];
System.assertEquals(2,accListQuery.size());

for(Account acc: accListQuery ){
if(acc.Name=='Test1'){
System.assertEquals(2, acc.Active_Contacts__c);
}
if(acc.Name=='Test2'){
System.assertEquals(0, acc.Active_Contacts__c);
}
}

List<Contact> conList2 = [Select Id, LastName from Contact];
System.assertEquals(5, conList2.size());

}



}