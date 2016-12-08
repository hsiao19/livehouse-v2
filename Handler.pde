class Handler {
  // TIME SETTING (unit sec)
  float SCENE1_TIME = 5 * 60 * frameRate;
  float SCENE2_TIME = 5 * 60 * frameRate;
  
  // SCENE SETTING
  float relPixel = height / screenHeight;
  boolean SCENE1 = true;
  boolean SCENE2 = false;
  
  // controller
  float CTRL_BASE = 0;
  Controller ctrl1 = new Controller();
  Controller ctrl2 = new Controller();
  Controller ctrl3 = new Controller();
  Controller ctrl4 = new Controller();
  Controller ctrl5 = new Controller();
  Controller ctrl6 = new Controller();
  EnvController envLeftCtrl = new EnvController();
  EnvController envRightCtrl = new EnvController();
  EnvController envFrontCtrl = new EnvController();
  EnvController envBackCtrl = new EnvController();
  
  String[] signals;
    
  // wave scene setting
  int wPointNum = 30;
  int wRowNum = 6;
  float wMaxHeight = relPixel * 100;
  WaveScene waveScene = new WaveScene(wPointNum, wRowNum);
  
  // ball scene setting
  int bNum = 30;
  float bMaxHeight = relPixel * 80;
  BallScene ballScene = new BallScene(bNum);
  
  Handler() {
      if (MODE == "TEST"){
        println("---------------------- TEST MODE ------------------------");
      }      
      else if(MODE == "PERFORMANCE"){
        println("------------------- PERFORMANCE MODE --------------------");
      }
  }
  


  // USE THIS TO UPDATE SIGNAL ----------------------------------------------------------------------------------
  void update(String serialSignals){
    println("signal " + serialSignals);
    _updateSignals(serialSignals);
    if (signals != null){
      _updateController();
    }
  }

  void _updateSignals(String serialSignals) {
    if (serialSignals != null) {
      signals = split(serialSignals, ',');
    }
    else {
      signals = null;
    }
  }
  
  void _updateController(){
    ctrl3.update(int(signals[0]), int(signals[10]), int(signals[11]), int(signals[12]) );
    //println("CTRL1 val " + int(signals[0]) + 
    //        " //front " + int(signals[9]) + 
    //        " //med " + int(signals[10]) + 
    //        " //back " + int(signals[11]) );
    
    ctrl2.update(int(signals[1]), int(signals[13]), int(signals[14]), int(signals[15]) );
    //println("CTRL2 val " + int(signals[1]) + 
    //        " //front " + int(signals[12]) + 
    //        " //med " + int(signals[13]) + 
    //        " //back " + int(signals[14]) );
    
    ctrl1.update(int(signals[2]), int(signals[16]), int(signals[17]), int(signals[18]) );
    //println("CTRL3 val " + int(signals[2]) + 
    //        " //front " + int(signals[15]) + 
    //        " //med " + int(signals[16]) + 
    //        " //back " + int(signals[17]) );
    
    ctrl4.update(int(signals[3]), int(signals[19]), int(signals[20]), int(signals[21]) );
    //println("CTRL4 val " + int(signals[2]) + 
    //       " //front " + int(signals[15]) + 
    //       " //med " + int(signals[16]) + 
    //       " //back " + int(signals[17]) );
            
    ctrl5.update(int(signals[4]), int(signals[22]), int(signals[23]), int(signals[24]) );
    //println("CTRL5 val " + int(signals[2]) + 
    //       " //front " + int(signals[15]) + 
    //       " //med " + int(signals[16]) + 
    //       " //back " + int(signals[17]) );
    
    ctrl6.update(int(signals[5]), int(signals[25]), int(signals[26]), int(signals[27]) );
    //println("CTRL6 val " + int(signals[2]) + 
    //       " //front " + int(signals[15]) + 
    //       " //med " + int(signals[16]) + 
    //       " //back " + int(signals[17]) );    
    
    envLeftCtrl.update(int(signals[18]));
    println("LEFT CTRL " + int(signals[18]));
    
    envRightCtrl.update(int(signals[19]));
    println("RIGHT CTRL " + int(signals[19]));
    
    envFrontCtrl.update(int(signals[20]));
    println("FRONT CTRL " + int(signals[20]));
    
    envBackCtrl.update(int(signals[21]));
    println("BACK CTRL " + int(signals[21]));
  
  }
  
  
  // DISPLAY TIME CONTROL ------------------------------------------------------------------------------------
  int time = 0;
  void display(){
      if (SCENE1){
          pushMatrix();
          playWaveScene();
          time += 1;
          if (time > SCENE1_TIME){
            SCENE1 = false;
            SCENE2 = true;
            time = 0;
          }
          popMatrix();
      }
      else if (SCENE2){
          pushMatrix();
          time += 1;
          playBallScene();
          if (time > SCENE2_TIME){
            SCENE2 = false;
            SCENE1 = true;
            time = 0;
          }  
          popMatrix();
      }
  }
  
  // WAVE SCENE RELATED
  void _triggerWave(Controller ctrl, int pointNo){
    if (ctrl.val > CTRL_BASE){
        float val = map(ctrl.val-CTRL_BASE, ctrl.MIN_VAL, ctrl.MAX_VAL, 0, wMaxHeight);    
        if (ctrl.val == ctrl.MIN_VAL){
            waveScene.releasePoint(pointNo);
        }
        else{
            if (ctrl.stage == 0){
                float waveVal = val*0.5*(-1);
                waveScene.pullPoint(pointNo, waveVal);
            }
            else if (ctrl.stage == 1){
                waveScene.pullPoint(pointNo, val);
            }
            else if (ctrl.stage == 2){
                float waveVal = val*0.5;
                waveScene.pullPoint(pointNo, waveVal);
            }
        }     
    }
  }
  
  void playWaveScene(){
    waveScene.draw();    
    if(MODE == "TEST"){  
        if(keyPressed){
            // PULL UP
            if(key=='1'){    
              waveScene.pullPoint(1, wMaxHeight*(-1));
            }
            if(key=='2'){
              waveScene.pullPoint(2, wMaxHeight*(-1));
            }
            if(key=='3'){
              waveScene.pullPoint(3, wMaxHeight*(-1));
            }
            if(key=='4'){
              waveScene.pullPoint(4, wMaxHeight*(-1));
            }
            if(key=='5'){
              waveScene.pullPoint(5, wMaxHeight*(-1));
            }
            if(key=='6'){
              waveScene.pullPoint(6, wMaxHeight*(-1));
            }
                        
            // PULL DOWN
            if(key=='q'){
              waveScene.pullPoint(1, wMaxHeight);
            }
            if(key=='w'){
              waveScene.pullPoint(2, wMaxHeight);
            }
            if(key=='e'){
              waveScene.pullPoint(3, wMaxHeight);
            }
            if(key=='r'){
              waveScene.pullPoint(4, wMaxHeight);
            }
            if(key=='t'){
              waveScene.pullPoint(5, wMaxHeight);
            }
            if(key=='y'){
              waveScene.pullPoint(6, wMaxHeight);
            }
            
            // RELEASE
            if(key=='a'){
              waveScene.releasePoint(1);
            }
            if(key=='s'){
              waveScene.releasePoint(2);
            }
            if(key=='d'){
              waveScene.releasePoint(3);
            }
            if(key=='f'){
              waveScene.releasePoint(4);
            }
            if(key=='g'){
              waveScene.releasePoint(5);
            }
            if(key=='h'){
              waveScene.releasePoint(6);
            }
            
            if(keyCode==UP){
              waveScene.turnFront();
            }
            if(keyCode==DOWN){
              waveScene.turnBack();
            }
            if(keyCode==LEFT){
              waveScene.turnLeft();
            }
            if(keyCode==RIGHT){
              waveScene.turnRight();
            }
        }     
    }
    
    else if(MODE == "PERFORMANCE"){ 
      _triggerWave(ctrl1, 1);
      _triggerWave(ctrl2, 2);
      _triggerWave(ctrl3, 3);
      _triggerWave(ctrl4, 4);
      _triggerWave(ctrl5, 5);
      _triggerWave(ctrl6, 6);       
 
      if (envLeftCtrl.isChange()){
          waveScene.turnLeft();
      }
      if (envRightCtrl.isChange()){
          waveScene.turnRight();
      }
      if (envFrontCtrl.isChange()){
          waveScene.turnFront();
      }
      if (envBackCtrl.isChange()){
          waveScene.turnBack();
      }

    }
  }
  
  
  // BALL SCENE RELATED
  void playBallScene(){
      ballScene.draw();
      if (MODE == "TEST"){
          //println("frameRate " + frameRate);
          if (keyPressed){
              if(keyCode==UP){
                ballScene.turnFront();
              }
              if(keyCode==DOWN){
                ballScene.turnBack();
              }
              if(keyCode==LEFT){
                ballScene.turnLeft();
              }
              if(keyCode==RIGHT){
                ballScene.turnRight();
              }
              
              
              // PULL
              if(key=='1'){
                ballScene.pullPoint(1, bMaxHeight);
              }
              if(key=='2'){
                ballScene.pullPoint(2, bMaxHeight);
              }
              if(key=='3'){
                ballScene.pullPoint(3, bMaxHeight);
              }
              if(key=='4'){
                ballScene.pullPoint(4, bMaxHeight);
              }
              if(key=='5'){
                ballScene.pullPoint(5, bMaxHeight);
              }
              if(key=='6'){
                ballScene.pullPoint(6, bMaxHeight);
              }
                          
              // PULL DOWN
              if(key=='q'){
                ballScene.pullPoint(1, bMaxHeight*(-1));
              }
              if(key=='w'){
                ballScene.pullPoint(2, bMaxHeight*(-1));
              }
              if(key=='e'){
                ballScene.pullPoint(3, bMaxHeight*(-1));
              }
              if(key=='r'){
                ballScene.pullPoint(4, bMaxHeight*(-1));
              }
              if(key=='t'){
                ballScene.pullPoint(5, bMaxHeight*(-1));
              }
              if(key=='y'){
                ballScene.pullPoint(6, bMaxHeight*(-1));
              }
              
              // RELEASE
              if(key=='a'){
                ballScene.releasePoint(1);
              }
              if(key=='s'){
                ballScene.releasePoint(2);
              }
              if(key=='d'){
                ballScene.releasePoint(3);
              }
              if(key=='f'){
                ballScene.releasePoint(4);
              }
              if(key=='g'){
                ballScene.releasePoint(5);
              }
              if(key=='h'){
                ballScene.releasePoint(6);
              } 
              
              if(key=='z'){
                ballScene.addR();
              }
              if(key=='x'){
                ballScene.minusR();
              }   
              
          }
      }
      else if (MODE == "PERFORMANCE"){
          if (envLeftCtrl.isChange()){
              waveScene.turnLeft();
          }
          if (envRightCtrl.isChange()){
              waveScene.turnRight();
          }
          if (envFrontCtrl.isChange()){
              waveScene.turnFront();
          }
          if (envBackCtrl.isChange()){
              waveScene.turnBack();
          }      
      }
  }

  void _triggerBall(Controller ctrl, int pointNo){
    if (ctrl.val > CTRL_BASE){
        float val = map(ctrl.val-CTRL_BASE, ctrl.MIN_VAL, ctrl.MAX_VAL, 0, bMaxHeight);    
        if (ctrl.val == ctrl.MIN_VAL){
            ballScene.releasePoint(pointNo);
        }
        else{
            if (ctrl.stage == 0){
                float ballVal = val*0.8*(-1);
                ballScene.pullPoint(pointNo, ballVal);
            }
            else if (ctrl.stage == 1){
                ballScene.pullPoint(pointNo, val);
            }
            else if (ctrl.stage == 2){
                float ballVal = val*0.8;
                ballScene.pullPoint(pointNo, ballVal);
            }
        }     
    }  
  }
  
  
}