/*
 
 Friend Finder - ASAP 2019 - Version 0.0.8
 
 */

//*****************************//
//   IMPORTS, VARIABLES, ETC   //
//*****************************//

//-- IMPORTS --//
import processing.net.*;
import java.io.FileWriter;
import java.util.LinkedHashMap;

//-- NETWORK-RELATED (Replace later) --//
Client myClient;
DisposeHandler dh;
int port = 10001;   // Port must be same as server port!
String id = "PC0";  // Replace with mac address eventually?

//-- SCENE MANAGEMENT --//
int scene = 0;      // Current scene
int backScene = 0;  // Scene to go back to when back button is pressed
int wait = 0;       // Scene transition animation & pause mouse input momentarily

//-- USER INFO --//
int selectedCategory;
int selectedSub;
int selectedTopic;
int selectedItem;

//-- UI --//
color bg = color(31);

//-- LISTS --//
LinkedHashMap<String, UI_Component> ui = new LinkedHashMap<String, UI_Component>();  // Iterable list of elements with named keys
ArrayList<User> users = new ArrayList<User>();                                       // Other devices currently in range
ArrayList<User> blocked_users = new ArrayList<User>();                               // Prohibit matches between people who have already failed to match
ArrayList<Category> catList = new ArrayList<Category>();                             // Categories (and all levels of subcategories) loaded from JSON file

//*****************************//
//       SETUP  FUNCTION       //
//*****************************//

void setup() {
  size(300, 530);
  
  //fullScreen();
  background(bg);

  //surface.setResizable(true);

  initClient();                   // Connect to Server
  dh = new DisposeHandler(this);  // Object for detecting the various ways to exit a program
  loadScene_0();                  // Load initial scene
}

void initClient() {
  // CONNECT TO SERVER
  //myClient = new Client(this, "54.208.53.64", port); // Global Server
  myClient = new Client(this, "localhost", port);      // Local Server
}



//*****************************//
//        DRAW FUNCTION        //
//*****************************//

void draw() {
  fill(bg, 20);
  noStroke();
  rect(0, 0, width, height);  // Fade-in background

  //-- Scene Transition & Scrolling --//
  if (abs(wait) > 0.0001) {   // Wait eases toward 0
    wait += -wait*0.5;
  }

  if (abs(inertia) > 0) {     // Inertia for smooth & natural scrolling
    inertia /= 1.08;
  }

  translate(-wait, 0);     // Horizontal-scene transition animation, Vertical-scrolling

  //-- USER INTERFACE --//
  for (String key : ui.keySet()) {

    if (abs(inertia) > 0) {                            // If there is intertia
      float old = ui.get(key).getY();

      if (old+inertia <= ui.get(key).getOriginalY()) { // If the component is not fixed and not higher than its initial position (>= as scrolling direction is inversed)
        ui.get(key).setY(old+inertia);                 // Move the component vertically
      }
    }

    ui.get(key).run();  // Display the component
  }

  //-- RECEIVE PACKETS --//
  try {
    if (myClient.available() > 0) {                 // Are there messages being sent to the client?
      String msg = myClient.readString();           // Store them
      //msg = msg.substring(0, msg.indexOf("\n"));  // Only up to the newline
      String[] data = msg.split(" ");

      if (!data[0].equals(id)) {                    // Only parse messages not sent by this client
        parseMessage(data);
      }

      saveToLog(msg);                               // Log the message (Remove eventually)
      myClient.clear();                             // Prepare to recieve other messages
    }
  } 
  catch (Exception e) {                             // Individual packets with errors should not cause the program to crash
    println(e);
  }
}



//*****************************//
//           LOGGING           //
//*****************************//

void saveToLog(String input) {
  FileWriter output = null;

  File f = new File(dataPath("log.txt"));  // log.txt file in project's data folder

  if (!f.exists()) {                       // Create the file if it doesn't already exist
    try {                                  // Logging is not vital - don't crash upon general errors
      f.createNewFile();
    }
    catch(Exception e) {
      e.printStackTrace();
    }
  }

  try {
    output = new FileWriter(f, true);      // Open file for appending data
    output.write(month() + "/" + day() + "/" + year() + " - "+hour() + ":" + minute() + ":" + second() + " - " + input + "\n");  // Log the message with a timestamp
  }
  catch (IOException e) {                  // Just some more error handling
    println("Unable to append to file.");  
    e.printStackTrace();
  }
  finally {
    if (output != null) {
      try {
        output.close();
      } 
      catch (IOException e) {
        println("Error while closing the writer");
      }
    }
  }
}



// Disconnect Event
public class DisposeHandler {
  DisposeHandler(PApplet pa) {
    pa.registerMethod("dispose", this);
  }

  public void dispose() {      
    println("Exited."); // To be used to detect loss of signal?
  }
}