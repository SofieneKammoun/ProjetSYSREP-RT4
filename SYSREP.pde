import controlP5.*;
Client[] Clients = new Client[12]  ;
int ServerX, ServerY;
IndexServer S = new IndexServer(new PVector ( 600, 100)) ;
int grabbedClient = -1    ;
Integer index;
File[] allFiles = new File[7];
Integer CID;
String FINPUT;
ControlP5 cp5;


void setup() {
  size(800, 600);
  textSize(12);
  
  cp5=new ControlP5(this);
  cp5.addButton("Download").setPosition(width - 250, 380);
  cp5.addTextfield("clientInput").setPosition(width - 250, 340).setAutoClear(false);
  cp5.addTextfield("fileInput").setPosition(width - 250, 300).setAutoClear(false);
  // exapmle files  C-Math-Chap1, TD-Network-Chap1, TP-Program-Chap1, Examen-Fr-2021, DS-Ang-2020
  allFiles[0]=new File ( "C-Math-Chap1", 200);
  allFiles[1]=new File ( "TD-Network-Chap1", 400);
  allFiles[2]=new File ( "TP-Program-Chap1", 100);
  allFiles[3]=new File ( "Ex-Fr-2021", 150);
  allFiles[4]=new File ( "DS-Ang-2020", 100);
  allFiles[5]=new File ( "Ex-Ang-2020", 100);
  allFiles[6]=new File ( "DS-Math-2019", 100);

  for (Integer i=0; i < Clients.length; i++) {
    PVector pos= new PVector ((float)(200* Math.cos(i*TWO_PI / Clients.length) -50 + width / 3 ), (float) (200 * Math.sin(i*TWO_PI / Clients.length) + height / 2));
    Clients[i]= new Client  (i*10, pos) ;
    Clients[i].addFile(allFiles[(int)(Math.random() * (7))]);
    Clients[i].addFile(allFiles[(int)(Math.random() * (7))]);
    Clients[i].addFile(allFiles[(int)(Math.random() * (7))]);
    Clients[i].updateServer(S);
  }
}

void draw() {
  background(20);

  for (int i=0; i < Clients.length; i++) {
    stroke( 0);
    fill(60,60,220);
    circle (Clients[i].Pos.x, Clients[i].Pos.y, 20);
    line (Clients[i].Pos.x, Clients[i].Pos.y, S.Pos.x, S.Pos.y);
    fill (255);
  }
  rect(S.Pos.x-25, S.Pos.y-25, 50, 50, 10 );
  stroke( 150, 10, 10);
  if (index!= null ) {
    if (index >=0) {
      line (Clients[CID/10].Pos.x, Clients[CID/10].Pos.y, Clients[index/10].Pos.x, Clients[index/10].Pos.y);
    } else if (index ==-2) {
      text ( "file name does not exist", 600, 500 );
    } else if (index ==-1) {
      text ( "client already has file ",600, 500, 280, 320);
    }
  }



  String msg="";
  if (mousePressed) {
    for (int i=0; i < Clients.length; i++) {
      msg="Client : "+(Clients[i].id);
      for (int j = 0; j < Clients[i].storage.size(); j++) {
        msg= msg +"\n" + String.join(", ", (String)Clients[i].storage.get(j).Name);  
        text ( msg, Clients[i].Pos.x + 10 , Clients[i].Pos.y+10, 120, 320);
      }
    }
    msg = " \n Index Map";
    for (HashMap.Entry<File, Integer> entry : S.indexMap.entrySet()) {
      File f = entry.getKey();
      Integer ID = entry.getValue();
      msg = msg +"\n"  +  f.Name + "   ||   " +ID;
    }
    text ( msg, S.Pos.x+10, S.Pos.y+5, 500, 320);
  }
}

void controlEvent(ControlEvent theEvent) {

  if (theEvent.isAssignableFrom(Textfield.class)) {
    if (theEvent.getName()== "clientInput") {
      CID =  Integer.parseInt(theEvent.getStringValue());
    }
    if (theEvent.getName()== "fileInput") {
      FINPUT=  theEvent.getStringValue();
      println(FINPUT);
    }
  }
}



void mouseDragged() { // Move black circle
  if ( grabbedClient > -1) {
    Clients[grabbedClient].Pos.x = mouseX;
    Clients[grabbedClient].Pos.y = mouseY;
  }
}
void mousePressed() // mousePressed is called on an event! it isnt polled!
{
  if (mouseButton == LEFT &&  grabbedClient == -1) // not moving client, look for closest to mouse
  {
    float mindist = 10*10; // distance^2. look for node within radius.
    for (int i=0; i< Clients.length; i++) {
      float dx = abs(mouseX - Clients[i].Pos.x);
      float dy = abs(mouseY - Clients[i].Pos.y);
      float distance = dx*dx + dy*dy;
      if (distance < mindist) {
        mindist = distance;
        grabbedClient = i;
      }
    }
  }
}
void mouseReleased()
{
  if (grabbedClient > -1)
  {
    Clients[grabbedClient].Pos.x = mouseX;
    Clients[grabbedClient].Pos.y = mouseY;
    grabbedClient = -1;
  }
}
public void Download() {
  index = Clients[CID/10].searchfileName(FINPUT, S);
  if (index != -1 ) {
    Clients[CID/10].downloadfile(Clients[index/10], FINPUT);
    Clients[CID/10].updateServer(S);
  }
}
