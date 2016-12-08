class Controller {
  boolean frontSwitch = false;
  boolean medSwitch = false;
  boolean backSwitch = false;
  int stage = 1;  // front:0 ; medium:1 ; back:2
  int val = 0;
  
  int MIN_VAL = 0;
  int MAX_VAL = 900;

  Controller() {
  }

  void update(int signalVal, int medSwitchSignal, int frontSwitchSignal, int backSwitchSignal) {
    //println("signalVal " + signalVal);
    _changeStage(frontSwitchSignal, medSwitchSignal, backSwitchSignal);
    _setValues(signalVal);
  }

  void _changeStage(int frontSwitchSignal, int medSwitchSignal, int backSwitchSignal) {
    // switch
    if (frontSwitchSignal == 0) {
      frontSwitch = false;
    } else {
      frontSwitch = true;
    }

    if (medSwitchSignal == 0) {
      medSwitch = false;
    } else {
      medSwitch = true;
    }

    if (backSwitchSignal == 0) {
      backSwitch = false;
    } else {
      backSwitch = true;
    }

    // stage
    if (frontSwitch == true && medSwitch == false && backSwitch == false) {
      stage = 0; //front
    } else if (frontSwitch == false && medSwitch == true && backSwitch == false) {
      stage = 1; //medium
    } else if (frontSwitch == false && medSwitch == false && backSwitch == true) {
      stage = 2; //back
    }
  }

  void _setValues(int signalVal) {
    val = signalVal;
  }
}

class EnvController{
  int val = 0;
  int base = 500;
  
  EnvController(){  
  }
  
  void update(int signalVal){
    val = signalVal;
  }
  
  Boolean isChange(){
    if (val > base){
      println("trigger");
      return true;
    }
    return false;
  }
  
  
}