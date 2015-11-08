
public class NBodySim {
    int numBodies;
    double G ;
    double[] y;
    double[] masses ;
    HelperFunctions helper = new HelperFunctions();
    NBodySim(double G, double[] masses_, double[] y_init){
        numBodies = masses_.length ; 
        y = new double[4*numBodies];
        masses = new double[numBodies];
        for (int i=0; i < y.length; i++){
            y[i] = y_init[i];
        }
        for (int j=0; j < numBodies; j++){
            masses[j] = masses_[j];
        }
        this.G = G;
    }
    void RungeKuttaStep(double h){
        double k1[] = y_prime(y);
        double k2[] = y_prime(helper.add_arrays(y,helper.mult_array(k1,h/2)));
        double k3[] = y_prime(helper.add_arrays(y,helper.mult_array(k2,h/2)));
        double k4[] = y_prime(helper.add_arrays(y,helper.mult_array(k3,h)));
        for (int i=0; i < y.length; i++){
          y[i] = y[i] + h/6*(k1[i] + 2*k2[i] + 2*k3[i] + k4[i]) ; 
        }
    }
    
    double squared_part(int body1, int body2, double[] y_cur){
        /*
        body1 is the number of the first body
        body2 is the number of the second body 
        should be zero indexed. 
        */
        double x1 = y_cur[body1*4];  
        double x2 = y_cur[body2*4]; 
        double y1 = y_cur[body1*4 + 2];
        double y2 = y_cur[body2*4 + 2]; 
        double squared_part_ = Math.pow((Math.pow((x1-x2),2.) + Math.pow((y1-y2),2.)),1.5); 
        return squared_part_ ; 
    }
    
    
    double[] y_prime(double[] y_){
       double[] y_prime_ = new double[y_.length];
       for (int i= 0; i < num_bodies; i ++){
               double y_prime_val_x = 0.0 ;
               double y_prime_val_y = 0.0 ; 
               for (int j=0; j < num_bodies; j ++){
                   if (j != i) {
                       double squared_part = squared_part(i,j,y_);
                       y_prime_val_x = y_prime_val_x - G*masses[j]*(y_[4*i] - y_[4*j])/squared_part ; 
                       y_prime_val_y = y_prime_val_y - G*masses[j]*(y_[4*i+2] - y_[4*j+2])/squared_part ; 
                   }
               y_prime_[4*i] = y_[4*i+1]; // new x velocity value
               y_prime_[4*i+2] = y_[4*i+3]; // new y velocity value 
               y_prime_[4*i+1] = y_prime_val_x; // the new x value 
               y_prime_[4*i+3] = y_prime_val_y; // the new y value
               }            
            }
        return y_prime_;
    }
    
    float[] get_xy(int body){
        float[] xy = {0.0,0.0};
        xy[0] = (float) y[4*body];
        xy[1] = (float) y[4*body + 2];
        return xy;
    }
    
    void reset_y(double[] y_new){
        for (int i=0; i < y.length; i++){
            y[i] = y_new[i];
        }

    }
    
    void update_masses(double[] masses_new){
        for (int i=0; i<numBodies;i++){
            masses[i] = masses_new[i];    
        }
        
    }
    double[] grab_y(){
        return y;       
    }
}