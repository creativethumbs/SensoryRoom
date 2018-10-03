class Button {
  
  int xButton=0;
  int yButton=0;
  int xRectangle=0;
  int yRectangle=0;
  int wRectangle=0;
  int hRectangle=0;
  boolean bGrowing = false;
  color c1 = color(0, 255, 255);
  
  void init (int x_Button, int y_Button, int x_Rectangle, int y_Rectangle, color _c1) {
    xButton = x_Button;
    yButton = y_Button;
    xRectangle = x_Rectangle;
    yRectangle = y_Rectangle;
    wRectangle = 0;
    hRectangle = 721;
    c1 = _c1;
  }
  
  void display (){
    rectMode(CENTER);
    fill(c1);
    rect(xButton, yButton, 8, 8);
    rect(xRectangle, yRectangle, wRectangle, hRectangle);
    if(bGrowing == true) {
      wRectangle=wRectangle+1;
      if(wRectangle>=1200){
        bGrowing=false;
        wRectangle=0;
      }
    }
    rectMode(CORNER);
  }
  
}
