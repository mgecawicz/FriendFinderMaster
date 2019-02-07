/*
 
 Friend Finder Server - ASAP 2019 - Version 0.0.1 - Temporary Processing Solution
 Simply relays messages to all connected clients.
 
 */

//*****************************//
//   IMPORTS, VARIABLES, ETC   //
//*****************************//

// IMPORTS
import processing.net.*;

// NETWORK
Server myServer;
int port = 10001;

String msg;

//*****************************//
//       SETUP  FUNCTION       //
//*****************************//

void setup() {
  size(500, 300);
  myServer = new Server(this, port);
  surface.setVisible(false);
}



//*****************************//
//        DRAW FUNCTION        //
//*****************************//

void draw() {
  fill(0, 20);
  noStroke();
  rect(0, 0, width, height);

  try {
    Client sender = myServer.available();
    if (sender != null && sender.available() > 0) {
      msg = sender.readString();
      myServer.write(msg);
    }
  }
  catch (Exception e) {
    println(e);
  }
}