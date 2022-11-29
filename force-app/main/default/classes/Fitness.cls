public class Fitness {
    
    public decimal bodyWeightInKgs = 0;
    public decimal bodyHeightInMts = 0;
    public decimal distanceTravelledInKms = 0;
    public decimal timetakenInMinutes = 0;
    
    public Decimal printClassVariablesValues(){
        
        return bodyWeightInKgs;
         
    }
    
    public static decimal calculateBMI(decimal bodyWeightInKgs, decimal bodyHeightInMts){
        
        if(bodyHeightInMts == 0 || bodyHeightInMts <0 || bodyWeightInKgs<0){
            return -1;
            
        }else{
        decimal bmiValue = bodyWeightInKgs / (bodyHeightInMts*bodyHeightInMts);
        return bmiValue;
        }
    }
    
     public static decimal calculatePace(decimal distanceTravelledInKms, decimal timetakenInMinutes){
         
         if(timetakenInMinutes == 0 || timetakenInMinutes <0 || distanceTravelledInKms<0){
            return -1;
            
         }else{
        decimal timeInHours = timetakenInMinutes/60;
        decimal pace = distanceTravelledInKms/timeInHours;
        return pace;
         }
    }
    

}