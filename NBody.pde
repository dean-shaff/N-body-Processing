 
NBodySim sim ; 
int num_bodies = 4 ;

Ball[] balls = new Ball[num_bodies];
Slider[] sliders = new Slider[num_bodies*2];
Slider[] sliders_m = new Slider[num_bodies];
double[] y_init = new double[4*num_bodies];
float rando = 100;
double h = 0.00005;
int rate = 5000;
double G = 10000.;
double[] masses = {20.,20.,1.,1.};//,1.,1.,1.}; 
boolean start = false ;
void setup(){
    size(1200,700);  
    double[] y_from1 = {width/2+200, 0.0, height/2, 0.0,
                   width/2 - 50, 0.0, height/2, -rando,
                   width/2 -250, 0.0, height/2, 0.6*rando,
                   width/2 -200, 0.0, height/2, rando*1.1};
                   //width-100, 0.0, height/2, rando*1.1,
                   //width-250, 0.0, height/2, rando*1.1,
                   //width-300, 0.0, height/2, rando*1.1};
    for (int i=0; i<y_from1.length; i++){
        y_init[i] = y_from1[i];
    }
    sim = new NBodySim(G,masses,y_from1);
    double[] y_cur = sim.grab_y();
    int counter = 1 ;
    for (int j=0; j < num_bodies; j++){
        float[] xy = sim.get_xy(j);
        balls[j] = new Ball(xy[0], xy[1], (float) masses[j],(float) masses[j]);
        balls[j].render();

    }
    fill(255);
    rect(0,0,200,height);
    for (int j=0; j < num_bodies; j++){
         String velx = "velx" + j; 
        String vely = "vely" + j;
        String mass_i = "mass" + j;
        sliders_m[j] = new Slider(width - 250, counter * 50, 0., 200., 150, mass_i); 
        sliders_m[j].setVal( (float) masses[j]);
        sliders_m[j].render();
        sliders[2*j] = new Slider(50, counter*50,-rando, rando, 150, velx ) ;
        sliders[2*j].setVal((float) y_cur[4*j + 1]);
        sliders[2*j].render();
        counter += 1;
        sliders[2*j + 1] = new Slider(50, counter*50,-rando, rando, 150, vely) ;
        sliders[2*j+1].setVal((float) y_cur[4*j + 3]);
        sliders[2*j +1].render();
        counter += 1;
        
    }
}

void draw(){
    fill(255,150);
    rect(0,0,width,height);
    //background(255);  
    for (int i = 0; i < num_bodies; i++){
        y_init[4*i + 1] = sliders[2*i].getVal();
        y_init[4*i + 3] = sliders[2*i+1].getVal();
        float mass_i = sliders_m[i].getVal();
        masses[i] = mass_i; //sliders_m[i].getVal();
        balls[i].change_size(mass_i, mass_i);
    }
    sim.update_masses(masses);
    int counter = 0 ;
    
    if (start == true){
        while (counter < rate) {
            sim.RungeKuttaStep(h);
            counter += 1;
        }
    }
    //println(sim.y);
    for (int j=0; j < num_bodies; j++){
        float[] xy = sim.get_xy(j);
        balls[j].change_xy(xy[0],xy[1]);
        balls[j].render();
    }
    fill(255);
    rect(0,0,200,height);
    for (int j=0; j < num_bodies; j++){
        sliders[2*j].render();
        sliders[2*j +1].render();
        sliders_m[j].render();
    }    
}

void keyPressed(){
    if (key == 'r'){
        sim.reset_y(y_init); // reset the simulation
        println(y_init);
        println(sim.grab_y());
        println("Reset");
        start = false;
    } 
    else if (key == 's'){
        start = true; 
    }   
}

void mousePressed(){
    if (start == false){
        for (Ball b: balls){
            if (b.checkMouse()){
                //println("Got here");
                b.set_locked(true);        
            }else{
                b.set_locked(false);
            }
        }
    }
    
}

void mouseDragged(){
    for (int i=0; i < num_bodies; i++){
        Ball b = balls[i];
        Slider sx = sliders[2*i];
        Slider sy = sliders[2*i +1];
        Slider mi = sliders_m[i];
        if (b.get_locked()){
            b.change_xy(mouseX, mouseY);
            double[] y_cur = sim.grab_y();
            y_cur[4*i] = mouseX;
            y_cur[4*i+2] = mouseY;
            sim.reset_y(y_cur);
        }
        else if (sx.checkMouse()){
            sx.setX(mouseX);
            sx.render();
        }
        else if (sy.checkMouse()){
            sy.setX(mouseX);
            sy.render();
        }
        else if (mi.checkMouse()){
            mi.setX(mouseX);
            //masses[i] = (double) mi.getVal();
            //println(masses[i]);
            mi.render();
        }
    }
}