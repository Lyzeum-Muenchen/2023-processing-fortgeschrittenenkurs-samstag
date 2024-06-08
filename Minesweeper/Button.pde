public class Button{
  private String text;
  private int x, y, w, h;//Dimension des Buttons
  private color colorFill, colorSelected, colorUnselected, colorPressed;
  private boolean pressed = false;
  
  public Button(String t){
    text = t;
    // Color orange
    /*
    colorFill = color(255, 100, 0); //orange
    colorSelected = color(240, 240, 240);
    colorPressed = color(180, 80, 0);  // dark orange
    colorUnselected = color(0,0 ,0);
    */
    colorFill = color(90, 137, 224); 
    colorSelected = color(240, 240, 240);
    colorPressed = color(23, 88, 209); 
    colorUnselected = color(0,0 ,0);
  }
  
  public void setBounds(int x, int y, int w, int h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  public void draw(){
    if(pressed && isInBounds()){
      fill(colorPressed);//dunkel orange
    }else{
      fill(colorFill);//orange
    }
    strokeWeight(3);
    stroke(colorUnselected);//schwarz
    
    
    rect(x, y, w, h);
    if(isInBounds()){
      fill(colorSelected);//weiss
    }else{
      fill(colorUnselected);//schwarz
    }
    textSize(20);
    textAlign(CENTER, CENTER);//zentriert Text
    text(text, x + w/2, y + h/2);
  }
  
  
  public void mousePressed(){
    if(isInBounds()){
      pressed = true;
    }
  }
  public void mouseReleased(){
    if(isInBounds() && pressed){
      System.out.println(text);
    }
    pressed = false;
  }
  private boolean isInBounds(){
    //linker Rand; rechter Rand; oberer Rand; unterer Rand
    return (x <= mouseX && x+w >= mouseX && y <= mouseY && y+h >= mouseY);
  }
}
