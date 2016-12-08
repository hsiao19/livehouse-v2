class BallScene extends AbsScene {
  float R = relPixel * 100;
  float heightMap[][];
  float velMap[][];
  int num;
  int[][] sel = {null, null, null, null, null, null, null};
  
  float posX = -1100;
  float posY = 0;
  float posZ = 2482;
  
  BallScene(int num) {
    noStroke();
    this.num = num;
    heightMap = new float[num][num];
    velMap = new float[num][num];
  }
  
  void draw(){
    //
    // Set up screen for drawing.
    //
    lightSpecular(204, 204, 204);
    directionalLight(102, 102, 102, 0, 0, -1);
    translate(width*0.5, screenHeight/2, 0);
    //shininess(5.0);
    rotateY((posX*0.5+width*0.25)/float(width));
    rotateX((posZ*0.5+width*0.25)/float(width));
    //println("posX " + posX);
    
    
    int z, p;
    //
    // Determining the change in velocity for each ball.
    //     
    for (z=0; z<num/2; z++){
       for (p=0; p<num; p++){
          if (sel[1] != null && sel[1][0] == p && sel[1][1] == z) continue;       
          if (sel[2] != null && sel[2][0] == p && sel[2][1] == z) continue;
          if (sel[3] != null && sel[3][0] == p && sel[3][1] == z) continue;
          if (sel[4] != null && sel[4][0] == p && sel[4][1] == z) continue;
          if (sel[5] != null && sel[5][0] == p && sel[5][1] == z) continue;
          if (sel[6] != null && sel[6][0] == p && sel[6][1] == z) continue;
          float h = heightMap[p][z];
          int p1 = 0;
          int z1 = 0;
           
          float f=0;
          for (p1=-1 ;p1<2; p1++) {
            for (z1=-1; z1<2; z1++) {
              if (p+p1 > 0 && p+p1 < num-1 && z+z1 > 0 && z+z1 < num/2-1 && (p1 != 0 || z1 != 0)) {
                f += heightMap[p+p1][z+z1];
              }
              else if (p+p1 < 0 && z+z1 > 0 && z+z1 < num/2-1 &&  (p1 != 0 || z1 != 0)){
                f += heightMap[num-1][z+z1];
              }
              else if (p+p1 > num-1 && z+z1 > 0 && z+z1 < num/2-1 &&  (p1 != 0 || z1 != 0)){
                f += heightMap[0][z+z1];
              }
              else if (p+p1 > 0 && p+p1 < num-1 && z+z1 < 0 &&  (p1 != 0 || z1 != 0)){
                f += heightMap[p+p1][num/2-1];
              }
              else if (p+p1 > 0 && p+p1 < num-1 && z+z1 > num-1 &&  (p1 != 0 || z1 != 0)){
                f += heightMap[p+p1][0];
              }             
            }
          }
          f /= 8;
          f = (f-h)/13;
           
          velMap[p][z] -= f;
          velMap[p][z] *= 0.9;
           
          heightMap[p][z] -= velMap[p][z];
       }
    }    
    
    //
    // Draws all of the balls to the screen with
    // the appropriate position.
    //
    int count = 0;
    for (z=0; z<num/2; z++){
            
        //int level = abs(z - (num/2));
        int pNum = num;
        float angle = TWO_PI / pNum;
        
        for (p=0; p<pNum/2; p++){
          
            float pointR = R + heightMap[p][z];
            float r = abs(pointR * sin(angle * z));
            
            float Px = r * cos(angle * p);
            float Py = r * sin(angle * p);
            float Pz = pointR * cos(angle * z);
        

            translate(Px, Py, Pz);
            //if (p == num/4){
            //  specular(150,0,0);
            //}
            //else if (p == num/4*3){
            //  specular(0,0,150);
            //}
            //else{
            specular(150);
            //}
            
            
            
            sphere(relPixel*1.5);
            translate(-Px, -Py, -Pz);            
             
            //println("p " + p + " " + z);
            //println("angle " + angle*p);
          
        }
    }
    //sphere(R);
    //println("-------------------------------------------------");
     
     
  }
  
  void turnFront(){
    if (posZ < 3754){    
      posZ += relPixel * 10;
      println("posZ " + posZ);
    }
  }
  
  void turnBack(){
    if (posZ > 1400){
      posZ -= relPixel * 10;
      println("posZ " + posZ);
    }
  }  

  void turnRight(){
    if (posX < 582){
      posX += relPixel * 10;
      //println("posX " + posX);
    }
  }
  
  void turnLeft(){
    if(posX > -2094){   
        posX -= relPixel * 10;
        //println("posX " + posX);
    }
  }
  
  void _pullPoint(int pointP, int pointZ, float _height){
      if (_height >= 0){           
        if (heightMap[pointP][pointZ] < _height){
          heightMap[pointP][pointZ] += relPixel * 10;
          velMap[pointP][pointZ] = 0;
        }
        else {
          heightMap[pointP][pointZ] = _height;
        }     
      }
      else {
        if (heightMap[pointP][pointZ] > _height){
          heightMap[pointP][pointZ] -= relPixel * 10;
          velMap[pointP][pointZ] = 0;
        }
        else {
          heightMap[pointP][pointZ] = _height;
        }
      } 
  }
  
  void pullPoint(int pointNo, float _height){
    int p=0;
    int z=0;
    if (pointNo == 1 || pointNo == 2){
       p = num/2 / 6 * 5 + 1;
       z = num/2 / 7 * (pointNo*2 + 1) -1;
       //println("z "+z);
    }
    else if(pointNo == 3 || pointNo == 4){
       p = num/2 / 6 * 3 + 1;
       z = num/2 / 7 * ((pointNo-2)*2 + 1) -1;
    }
    else if(pointNo == 5 || pointNo == 6){
       p = num/2 / 6 * 1 + 1;
       z = num/2 / 7 * ((pointNo-4)*2 + 1) -1;
    }
          
    if(sel[pointNo] == null){
        int[] point = {p, z};
        //println("point " + p + " " + z);
        sel[pointNo] = point;
    }      
    else{
        _pullPoint(p, z, _height);
    }     
  }
  
  void releasePoint(int pointNo){
      sel[pointNo] = null;
  }
  
  void addR(){
    R += relPixel * 5; 
  }
  
  void minusR(){
    R -= relPixel * 5; 
  }
  
}