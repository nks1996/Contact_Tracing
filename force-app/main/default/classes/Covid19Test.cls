@isTest
public class Covid19Test {
    @isTest
    public static void treatPatientTest(){
        
        Covid19 jaipur = new Covid19(10);
        //System.assertEquals(10, jaipur.recoveredInArea, 'Treated Count doesnt match');
        System.assertEquals(10, jaipur.getTreatedArea(), 'Count doesnt match');
        jaipur.treatPatient();
        System.assertEquals(11, jaipur.getTreatedArea(), 'Count doesnt match');
        System.assertEquals(11, Covid19.getTreatedCountry(), 'Count doesnt match');
        
        Covid19 hyd = new Covid19(35);
        hyd.treatPatient();
        System.assertEquals(47, Covid19.getTreatedCountry(), 'Count doesnt match');
        System.assertEquals(36, hyd.getTreatedArea(), 'Count doesnt match');
                
    }
    
    @isTest
    public static void treatPatientTestNegative(){
        
        Covid19 jaipur = new Covid19(-10);
        //System.assertEquals(10, jaipur.recoveredInArea, 'Treated Count doesnt match');
        System.assert(0==jaipur.getTreatedArea(), 'Count doesnt match');
        jaipur.treatPatient();
        System.assertEquals(1,Covid19.getTreatedCountry(), 'Count doesnt match');
        
        Covid19 hyd = new Covid19(-35);
        System.assert(0==hyd.getTreatedArea(), 'Count doesnt match');
        hyd.treatPatient();
        System.assertEquals(2,Covid19.getTreatedCountry(), 'Count doesnt match');

        
    }

}