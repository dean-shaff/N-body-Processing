public class Slider {
    float x_pos ;
    float x_pos_init ; 
    float y_pos ; 
    float val_low ; 
    float val_high ; 
    float curVal ; //current value of the slider
    float size_x ;
    float slide_x;
    float slide_y;
    float el_size = 30 ;
    float padding_x = 20;
    String name ; 
    
    public Slider (float x_pos, float y_pos, float val_low, float val_high, float size_x, String name){
       this.x_pos = x_pos;
       this.y_pos = y_pos; 
       this.val_low = val_low ; 
       this.val_high = val_high;
       this.size_x = size_x ;
       this.name = name ;
       slide_x = x_pos ;
       slide_y = y_pos ;
       x_pos_init = x_pos;
       render();
       //line(x_pos_init, y_pos, x_pos_init+size_x, y_pos);
       //ellipse(x_pos, y_pos,el_size,el_size);
    }
    
    boolean checkMouse(){
       if (mouseX > x_pos - el_size && mouseX < x_pos + el_size 
           && mouseY > y_pos - el_size && mouseY < y_pos + el_size){
               return true;
           }else{
               return false ; 
           }
    }
    void render() {
       fill(0);
       text(name, x_pos_init-(size_x/3), y_pos);
       text(getVal(),x_pos_init+size_x+padding_x, y_pos); 
       strokeWeight(2);
       stroke(0);
       line(x_pos_init, y_pos, x_pos_init+size_x, y_pos);
       fill(255);
       ellipse(x_pos, y_pos,el_size,el_size);  
       
    }
    void setX(float x){
        if (x > x_pos_init + size_x){
            x_pos = x_pos_init + size_x;
        }
        else if (x < x_pos_init){
            x_pos = x_pos_init;
        }
        else{
            x_pos = x;
        }
        //render();
    }
    float getVal(){
        curVal = map(x_pos, x_pos_init, x_pos_init+size_x, val_low, val_high);
        return curVal ;
    } 
    
    void setVal(float val){
       if (val > val_high){
           curVal = val_high; 
       }
       else if (val < val_low){
           curVal = val_low;
       }
       else{
           curVal = val;
       }
       x_pos = map(curVal,val_low, val_high, x_pos_init, x_pos_init+size_x);   
       render();
    }
}