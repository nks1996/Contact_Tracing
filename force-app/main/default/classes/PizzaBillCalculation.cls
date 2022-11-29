public class PizzaBillCalculation {
    
    public static Integer totalCost = 0; //global variable
    
    public void individualCost(Integer sliceCount){
        Integer middleCost = 0;
        if(sliceCount>3){
            middleCost = sliceCount*6;
        } else if (sliceCount==2 || sliceCount==3){
            middleCost = sliceCount*7;
        }else if (sliceCount == 1){
            middleCost = sliceCount*8;
        }
        totalCost += middleCost;
        //return middleCost;
    }
    
    public static void printTotalCost(){
        System.debug('The total bill is: '+totalCost);
    }

}