public class HelperFunctions {
    
    public HelperFunctions () {
        
    }
    double[] add_arrays(double[] array1, double[] array2){
      double[] final_array = new double[array1.length] ;
       if (array1.length != array2.length){
         println("Error: arrays not of equal length");
         return final_array;
       }
       for (int j=0; j < array1.length ; j++){
          final_array[j] = array1[j] + array2[j]; 
       }
       return final_array;
    }
    
    double[] mult_array(double[] array, double factor){
      for (int i=0; i < array.length; i++){
         array[i] = factor*array[i]; 
      }
      return array;
    }
    
}