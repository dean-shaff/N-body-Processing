import java.lang.*; // for Math.sqrt

public class Ball {
    float x; 
    float y; 
    float size_x ;
    float size_y ; 
    float size_x_min = 20;
    float size_y_min = 20;
    float factor = 4.0;
    //boolean overBall = false; 
    boolean locked = false;
    public Ball(float x, float y, float size_x, float size_y){
        this.x = x ;
        this.y = y ;

        this.size_x = size_x/factor + size_x_min; 
        this.size_y = size_y/factor + size_y_min;
 
    }
    
    public Ball(float x, float y){
        this.x = x; 
        this.y = y;
        size_x = size_x_min;
        size_y = size_y_min; 
    }
    
   boolean checkMouse(){
        if (mouseX > x - size_x && mouseX < x + size_x
            && mouseY > y - size_y && mouseY < y + size_y){
                return true;      
            }else{
                return false;
            }
    }

    void set_locked(boolean val){
        locked = val;   
    }
    
    boolean get_locked(){
         return locked;   
    }
    
    void render(){
        noStroke();
        fill(0,100);
        ellipse(x, y, size_x, size_y);
    }
    
    void change_xy(float x_new, float y_new){
        x = x_new ;
        y = y_new ; 
    }
    
    void change_size(float size_new_x, float size_new_y){
        //if (size_new_x < size_x_min){
        //    size_x = size_x_min;   
        //}
        //else if (size_new_y < size_y_min){
        //    size_y = size_y_min;   
        //}
        //size_x = (float) Math.sqrt(size_new_x);
        //size_y = (float) Math.sqrt(size_new_y);
        size_x = size_new_x/factor + size_x_min;
        size_y = size_new_y/factor + size_y_min;
    }
}