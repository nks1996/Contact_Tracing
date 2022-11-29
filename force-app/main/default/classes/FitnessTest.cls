@isTest
public class FitnessTest {
    
    @isTest
    public static void calculateBMI_TEST(){
        
        System.assertEquals(4,Fitness.calculateBMI(100,5),'Error Message1');
        System.assertEquals(8,Fitness.calculateBMI(200,5),'Error Message1');
        System.assertEquals(2,Fitness.calculatePace(4,120),'Error Message2');
        System.assertEquals(2,Fitness.calculatePace(4,120),'Error Message2');
    }
    
    @isTest
    public static void calculateBMI_NEGATIVETEST(){
        System.assertEquals(-1,Fitness.calculateBMI(100,0),'Error Message1');
        System.assertEquals(-1,Fitness.calculateBMI(-100,5),'Error Message1');
        System.assertEquals(-1,Fitness.calculateBMI(100,-5),'Error Message1');
        System.assertEquals(-1,Fitness.calculatePace(4,0),'Error Message2');
        System.assertEquals(-1,Fitness.calculatePace(4,-120),'Error Message2');
        System.assertEquals(-1,Fitness.calculatePace(-4,120),'Error Message2');
    }

}