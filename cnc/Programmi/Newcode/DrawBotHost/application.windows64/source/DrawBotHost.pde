import java.awt.event.KeyEvent;
import javax.swing.JOptionPane;
import processing.serial.*;

Serial port = null;
String portname = null;

boolean streaming = false;
float speed = 10;
String[] gcode;
int i = 0;
float px=0,py=0;

void openSerialPort()
{
  if (portname == null) return;
  if (port != null) port.stop();
  
  port = new Serial(this, portname, 9600);
  
  port.bufferUntil('\n');
}

void selectSerialPort()
{
  String result = (String) JOptionPane.showInputDialog(this,
    "Seleziona la porta seriale corrispondente all' arduino.",
    "Seleziona la porta seriale",
    JOptionPane.PLAIN_MESSAGE,
    null,
    Serial.list(),
    0);
    
  if (result != null) {
    portname = result;
    openSerialPort();
  }
}

void setup()
{
  size(500, 250);
  openSerialPort();
  selectSerialPort();
}

void draw()
{
  background(0);  
  fill(255);
  int y = 24, dy = 12;
  textSize(26); 
  text("DRAWBOT", 12, y); y += dy*2;
  textSize(12); 
  text("p: Seleziona la porta seriale", 12, y); y += dy;
  text("1: Imposta lo spostamento a 0.1mm", 12, y); y += dy;
  text("2: Imposta lo spostamento a 1mm", 12, y); y += dy;
  text("3: Imposta lo spostamento a 10mm", 12, y); y += dy;
  text("Freccie destra-sinistra: muove asse y", 12, y); y += dy;
  text("Freccie su-giù muove: asse x", 12, y); y += dy;
  text("page up & page down: alza e abbassa la penna", 12, y); y += dy;
  text("h: Torna alla home", 12, y); y += dy;
  text("0: Reset coordinate (imposta la home nel punto attuale)", 12, y); y += dy;
  text("g: Stampa un file G-CODE", 12, y); y += dy;
  text("x: Ferma la stampa", 12, y); y += dy;
  y = height - dy;
  text("Realizzato da Peirone Matteo e Russo Alessandro",12,y); y -= dy;
  text(" ",12,y); y -= dy;
  text("Lo spostamento attuale è di: " + speed + " mm", 12, y); y -= dy;
  text("Porta seriale connessa: " + portname, 12, y); y -= dy;
}

void keyPressed()
{
  if (key == '1') speed = 0.1;
  if (key == '2') speed = 1;
  if (key == '3') speed = 10;
  
  if (!streaming) {
    if (keyCode == LEFT) Muovi(0,-speed);
    if (keyCode == RIGHT) Muovi(0,speed);
    if (keyCode == UP) Muovi(-speed,0);
    if (keyCode == DOWN) Muovi(speed,0);
    if (keyCode == KeyEvent.VK_PAGE_UP) port.write("U\n");
    if (keyCode == KeyEvent.VK_PAGE_DOWN) port.write("D\n");
    if (key == 'h') {
    px=0;
    py=0;
     Muovi(0,0);
    }
    if (key == 'v') port.write("$0=75\n$1=74\n$2=75\n");
    //if (key == 'v') port.write("$0=100\n$1=74\n$2=75\n");
    if (key == 's') port.write("$3=10\n");
    if (key == 'e') port.write("$16=1\n");
    if (key == 'd') port.write("$16=0\n");
    if (key == '0') openSerialPort();
    if (key == 'p') selectSerialPort();
  }
  
  if (!streaming && key == 'g') {
    gcode = null; i = 0;
    File file = null; 
    println("Loading file...");
    selectInput("Select a file to process:", "fileSelected", file);
  }
  
  if (key == 'x') streaming = false;
}
void Muovi(float x,float y)
{
px+=x;
py+=y;
if(px<0)
  px=0;
if(py<0)
  py=0; 
if(px>40)
  px=40;
if(py>40)
  py=40; 
port.write("G90\nG20\nG00 X"+px+" Y" + py +"\n");
println("G90\nG20\nG00 X"+px+" Y" + py +"\n");
}
void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    gcode = loadStrings(selection.getAbsolutePath());
    if (gcode == null) return;
    streaming = true;
    stream();
  }
}

void stream()
{
  if (!streaming) return;
  
  while (true) {
    if (i == gcode.length) {
      streaming = false;
      return;
    }
    
    if (gcode[i].trim().length() == 0) i++;
    else break;
  }
  
  println(gcode[i]);
  port.write(gcode[i] + '\n');
  i++;
}

void serialEvent(Serial p)
{
  String s = p.readStringUntil('\n');
  //println(s.trim());
  
  if (s.trim().startsWith("ok")) stream();
  if (s.trim().startsWith("error")) stream(); // XXX: really?
}

