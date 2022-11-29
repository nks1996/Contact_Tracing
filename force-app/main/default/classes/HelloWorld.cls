public class HelloWorld {
    public String publicGreeting = 'Hello Public World!';
    public String varFromVSCode = 'Hi Im a variable created in VS Code';
    private string privateGreeting = 'This is a private greeting';
    public void printPrivateGreeting(){
        System.debug(privateGreeting);
    }
    public void pGreeting(String message){
        System.debug(message);
    }
    
    public String getDayName(Integer dayNumber){
        String dayName =''; //this variable is not accesible by other methods.
        switch on dayNumber{
            when 1{
                dayName = 'Monday';
            }
            when 2{
                dayName = 'TUESDAY';
            }
            when 3{
                dayName = 'WEDNESDAY';
            }
            when 4{
                dayName = 'THURSDAY';
            }
            when 5{
                dayName = 'FRIDAY';
            }
            when 6{
                dayName = 'SATURDAY';
            }
            when 7{
                dayName = 'Sunday';
            }
            when else{
                dayName = 'This number has no day to it :( ';
            }
        }
        return dayName;
    }
    
    public String getDayName(String dayNumber){
        String dayName =''; //this variable is not accesible by other methods.
        switch on dayNumber{
            when 'MON'{
                dayName = 'Monday';
            }
            when 'TUES'{
                dayName = 'TUESDAY';
            }
            when 'WED'{
                dayName = 'WEDNESDAY';
            }
            when 'THURS'{
                dayName = 'THURSDAY';
            }
            when 'FRI'{
                dayName = 'FRIDAY';
            }
            when 'SAT'{
                dayName = 'SATURDAY';
            }
            when 'SUN'{
                dayName = 'Sunday';
            }
            when else{
                dayName = 'This STRING has no day ABBREVIATION to it :( ';
            }
        }
        return dayName;
    }
}