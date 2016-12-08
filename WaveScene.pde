class WaveScene extends AbsScene {
  int sceneWidth = int(screenWidth * 0.8);
  int sceneHeight = int(screenHeight);
  float interval = relPixel * 8; 
  
  float[][] heightMap;
  float[][] velMap;
  int[][] sel = {null, null, null, null, null, null, null};
  float posX = -360 * relPixel;
  float posY = 0;
  float posZ = 995;

  int pointNum, rowNum;
  
  WaveScene(int pointNum, int rowNum) {
    this.pointNum = pointNum;
    this.rowNum = rowNum;    
    heightMap = new float[pointNum][rowNum];
    velMap = new float[pointNum][rowNum];
    noStroke(); 
  }
  
  void draw(){
    //
    // Set up screen for drawing.
    //
    lightSpecular(204, 204, 204);
    directionalLight(102, 102, 102, 0, 0, -1);
    translate(width*0.56, screenHeight/2 + 50 * relPixel, 0);
    rotateY((posX*0.5+width*0.25)/float(width));
    rotateX((posZ*0.5+width*0.25)/float(width));
    translate(width/10,screenHeight/10,height/3);
    //shininess(5.0);
    //println(posZ);
    
    //
    // Determining the change in velocity for each ball.
    //    
    int y, x;
    for (y=0; y<rowNum; y++) {
      for (x=0; x<pointNum; x++) {
        if (sel[1] != null && sel[1][0] == x && sel[1][1] == y) continue;       
        if (sel[2] != null && sel[2][0] == x && sel[2][1] == y) continue;
        if (sel[3] != null && sel[3][0] == x && sel[3][1] == y) continue;
        if (sel[4] != null && sel[4][0] == x && sel[4][1] == y) continue;
        if (sel[5] != null && sel[5][0] == x && sel[5][1] == y) continue;
        if (sel[6] != null && sel[6][0] == x && sel[6][1] == y) continue;
        float h = heightMap[x][y];
        int x1 = 0;
        int y1 = 0;
   
        float f=0;
        for (y1=-1 ;y1<2; y1++) {
          for (x1=-1; x1<2; x1++) {
            if (x+x1 > 0 && x+x1 < pointNum-1 && y+y1 > 0 && y+y1 < rowNum-1 && (x1 != 0 || y1 != 0)) {
              f += heightMap[x+x1][y+y1];
            }
          }
        }
        f /= 7;
        f = (f-h)/15;
   
        velMap[x][y] -= f;
        velMap[x][y] *= 0.95;
   
        heightMap[x][y] -= velMap[x][y];
      }
    } 
    
    //
    // Draws all of the balls to the screen with
    // the appropriate position.
    //
    for (y=0; y<rowNum; y++){
      translate(interval*pointNum*(-1), interval,0);
      for (x=0; x<pointNum; x++) {
        //y=8;
        translate(interval, heightMap[x][y], interval*y);
        specular(0, 50, 255);
        sphere(relPixel * 0.8);
        translate(0, -heightMap[x][y], interval*y*(-1));
      }
   }    
    
    
  }
  
  void _pullPoint(int pointX, int pointY, float _height){
      if (_height >= 0){           
        if (heightMap[pointX][pointY] < _height){
          heightMap[pointX][pointY] += relPixel;
          velMap[pointX][pointY] = 0;
        }
        else {
          heightMap[pointX][pointY] = _height;
        }     
      }
      else {
        if (heightMap[pointX][pointY] > _height){
          heightMap[pointX][pointY] -= relPixel;
          velMap[pointX][pointY] = 0;
        }
        else {
          heightMap[pointX][pointY] = _height;
        }
      } 
  }
  
  void pullPoint(int pointNo, float _height){
    int x = pointNum/7 * pointNo;
    int y = rowNum/2;      
    if(sel[pointNo] == null){
        int[] point = {x, y};
        sel[pointNo] = point;
    }      
    else{
        _pullPoint(x, y, _height);
    }     
  }
  
  void releasePoint(int pointNo){
      sel[pointNo] = null;
  }
  
  
  void turnFront(){
    if(posZ < 980 * relPixel){
      posZ += relPixel;
      //println("posz " + posZ);
    }
  }
  
  void turnBack(){
    if (posZ > 100 * relPixel){
      posZ -= relPixel;
      //println("posz " + posZ);
    }
  }  

  void turnRight(){
    if (posX < 780){
      posX += relPixel;
      //println("posx " + posX);
    }
  }
  
  void turnLeft(){
    if (posX > -1500 * relPixel){
      posX -= relPixel;
      //println("posx " + posX);
    }
  }
  
}