public class Company {
    //variables or properties or attributes of the outer class
    public String companyName;
    public String ceo;
    public Integer employeeCount;
    public Long revenue;
    
    //private list to hold customer information
    private List<Client> customersList = new List<Client>();
    
    //outer class method to add customer data
    public void addNewCustomer(String clientName, String website,String email,Long phone){
        Client customer = new Client(clientName, website, email, phone);
        customersList.add(customer);
    }
    
    public void getAllCustomers(){
        for(Client customer: customersList){
            System.debug('The customers name is: '+customer.clientName+' \n The customers website is: '+customer.website+' \n The customers email is: '+customer.email+' \n Finally, the customers phone is :'+customer.phone);
        }
    }
    
    // private Inner class to store all the customer information
    private class Client{
        public String clientName;
        public String website;
        public String email;
        public Long phone;
        
         //parameterized constructor to assign values to the class variables
            Client(String clientName,String website, String email,Long phone){
            
            this.clientName = clientName;
            this.website = website;
            this.email = email;
            this.phone = phone;
            
            
        }
       
    }

}