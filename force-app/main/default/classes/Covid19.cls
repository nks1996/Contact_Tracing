public class Covid19 {
    private integer recoveredInArea = 0;
    public static integer recoveredInCountry = 0;
    
    public Covid19(Integer recoveredInArea){
        if(recoveredInArea<0){
           this.recoveredInArea = 0; 
        }else{
             this.recoveredInArea = recoveredInArea;
             recoveredInCountry += recoveredInArea;
        }
    }
    
     public Integer getTreatedArea(){
        return recoveredInArea;
    }
    public static Integer getTreatedCountry(){
        return recoveredInCountry;
    }
    
    
     public void treatPatient(){
         recoveredInArea++;
         recoveredInCountry++;
    }
        
 }