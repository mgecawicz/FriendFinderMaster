// Scene 0 - Splash
void loadScene_0() {
  bg = color(40, 130, 180);

  ui.put("Welcome", new RoundedTextBox("Welcome", "Welcome", width/2-100, height/2-50, 200, 100, color(40, 130, 180), color(255)));
  ui.put("WelcomeBottomBorder", new UIRect("WelcomeBottomBorder", width/2-98, height/2+50, 196, 2, color(35, 98, 140)));
  ((TextBox) ui.get("Welcome")).align("CENTER");
  ((TextBox) ui.get("Welcome")).setTextSize(20);
}



// Scene 1 - About
void loadScene_1() {
  bg = color(200);

  ui.clear();

  ui.put("0Wrapper", new UIRect("Wrapper", 0, 0, width, height, color(255)));

  ui.put("Header", new RoundedTextBox("Header", "Friend Finder Prototype", width/2-125, 20, 250, 50, color(60, 170, 200), color(255)));
  ui.put("HeaderBottomBorder", new UIRect("HeaderBottomBorder", width/2-120, 70, 240, 2, color(75, 148, 170)));
  ((TextBox) ui.get("Header")).align("CENTER"); 

  ui.put("Content", new TextBox("Content", "This is a prototype software.\n\nGlitches are highly likely.\n\nPlease take note when you encounter them.\n\n© ASAP Media Services 2019", width/2-125, 100, 250, height-225, color(255), color(31)));
  ((TextBox) ui.get("Content")).align("CENTER");

  ui.put("Okay", new Button("Okay", width/2-100, height-100, 200, 50, color(20, 230, 180), color(255), 100, 200));
  ((Button) ui.get("Okay")).setBorderColor(color(230));
}



// Scene 2 - Home Screen
void loadScene_2() {
  ui.clear();

  ui.put("Header", new TextBox("Header", "Friend Finder Prototype", 0, 0, width, 55, color(60, 170, 200), color(255)));
  ui.put("HeaderBottomBorder", new UIRect("HeaderBottomBorder", 0, 55, width, 2, color(45, 128, 150)));
  ((TextBox) ui.get("Header")).align("CENTER");

  ui.put("Wrapper", new UIRect("Wrapper", 5, 57, width-10, height-60, color(255)));
  ui.put("WrapperBottomBorder", new UIRect("WrapperBottomBorder", 4, height-5, width-8, 2, color(150)));

  ui.put("Message", new RoundedTextBox("Message", "What are you looking for?", 15, 65, width-30, 32, color(234), color(10)));
  ((RoundedTextBox) ui.get("Message")).align("CENTER");

  ui.put("NewConnections", new Button("New Connections", 15, 110, width-30, height/9, color(180, 20, 230), color(255), color(100), color(200)));
  ui.put("PastConnections", new Button("Past Connections", 15, (1*height)/9+120, width-30, height/9, color(230, 20, 180), color(255), color(100), color(200)));
  ui.put("Profile", new Button("My Profile", 15, (2*height)/9+130, width-30, height/9, color(230, 180, 20), color(255), color(100), color(200)));
  ui.put("ConnectFinder", new Button("Connect Finder", 15, (3*height)/9+140, width-30, height/9, color(220, 220, 20), color(255), color(100), color(200)));
  ui.put("Help", new Button("Get Help", 15, (4*height)/9+150, width-30, height/9, color(20, 230, 180), color(255), color(100), color(200)));
  ui.put("Feedback", new Button("Give Feedback", 15, (5*height)/9+160, width-30, height/9, color(20, 180, 230), color(255), color(100), color(200)));

  for (String key : ui.keySet()) {
    if (ui.get(key) instanceof Button) {
      ((Button) ui.get(key)).setBorderColor(color(230));
    }
  }
}



// Scene 3 - New Connections
void loadScene_3() {
  ui.clear();

  ui.put("Wrapper", new UIRect("Wrapper", 5, 0, width-10, height-3, color(255)));
  ui.put("WrapperBottomBorder", new UIRect("WrapperBottomBorder", 4, height-5, width-8, 2, color(150)));
  ui.get("Wrapper").setFixedPosition(true);
  ui.get("WrapperBottomBorder").setFixedPosition(true);

  ui.put("Header", new TextBox("Header", "New Connections", 0, 0, width, 55, color(180, 20, 230), color(255)));
  ui.put("HeaderBottomBorder", new UIRect("HeaderBottomBorder", 0, 55, width, 2, color(110, 30, 135)));
  ((TextBox) ui.get("Header")).align("CENTER");

  ui.put("Message", new RoundedTextBox("Message", "Select a category", 15, 65, width-30, 32, color(234), color(10)));
  ((RoundedTextBox) ui.get("Message")).align("CENTER");

  ui.put("Back", new Button("«", 0, 2, 55, 51, color(180, 20, 230), color(255), color(100), color(200)));
  ((Button) ui.get("Back")).setBorderColor(color(180, 20, 230));

  if (catList.size() == 0) {
    loadDatabase();
  }

  for (int i=0; i<catList.size(); i++) {
    String name = "Category"+i;
    ui.put(name, new Button(catList.get(i).getName(), 15, 110+60*i, width-30, 50, color(180-i*20, 20, 230), color(255), color(100), color(200)));
  }
}



// Scene 4 - Past Connections
void loadScene_4() {
  ui.clear();

  ui.put("Header", new TextBox("Header", "Past Connections", 0, 0, width, 55, color(230, 20, 180), color(255)));
  ui.put("HeaderBottomBorder", new UIRect("HeaderBottomBorder", 0, 55, width, 2, color(155, 50, 130)));
  ((TextBox) ui.get("Header")).align("CENTER");

  ui.put("Wrapper", new UIRect("Wrapper", 5, 57, width-10, height-60, color(255)));
  ui.put("WrapperBottomBorder", new UIRect("WrapperBottomBorder", 4, height-5, width-8, 2, color(150)));

  ui.put("Message", new RoundedTextBox("Message", "A few questions first...", 15, 65, width-30, 32, color(234), color(10)));
  ((RoundedTextBox) ui.get("Message")).align("CENTER");

  ui.put("Back", new Button("«", 0, 2, 55, 51, color(230, 20, 180), color(255), color(100), color(200)));
  ((Button) ui.get("Back")).setBorderColor(color(230, 20, 180));
}



// Scene 5 - My Profile
void loadScene_5() {
  ui.clear();

  ui.put("Header", new TextBox("Header", "My Profile", 0, 0, width, 55, color(230, 180, 20), color(255)));
  ui.put("HeaderBottomBorder", new UIRect("HeaderBottomBorder", 0, 55, width, 2, color(175, 150, 70)));
  ((TextBox) ui.get("Header")).align("CENTER");

  ui.put("Wrapper", new UIRect("Wrapper", 5, 57, width-10, height-60, color(255)));
  ui.put("WrapperBottomBorder", new UIRect("WrapperBottomBorder", 4, height-5, width-8, 2, color(150)));

  ui.put("Message", new RoundedTextBox("Message", "A few questions first...", 15, 65, width-30, 32, color(234), color(10)));
  ((RoundedTextBox) ui.get("Message")).align("CENTER");

  ui.put("Back", new Button("«", 0, 2, 55, 51, color(230, 180, 20), color(255), color(100), color(200)));
  ((Button) ui.get("Back")).setBorderColor(color(230, 180, 20));
}



// Scene 6 - Connect Finder
void loadScene_6() {
  ui.clear();

  ui.put("Header", new TextBox("Header", "Connect Finder", 0, 0, width, 55, color(220, 220, 20), color(255)));
  ui.put("HeaderBottomBorder", new UIRect("HeaderBottomBorder", 0, 55, width, 2, color(175, 175, 70)));
  ((TextBox) ui.get("Header")).align("CENTER");

  ui.put("Wrapper", new UIRect("Wrapper", 5, 57, width-10, height-60, color(255)));
  ui.put("WrapperBottomBorder", new UIRect("WrapperBottomBorder", 4, height-5, width-8, 2, color(150)));

  ui.put("Message", new RoundedTextBox("Message", "A few questions first...", 15, 65, width-30, 32, color(234), color(10)));
  ((RoundedTextBox) ui.get("Message")).align("CENTER");

  ui.put("Back", new Button("«", 0, 2, 55, 51, color(220, 220, 20), color(255), color(100), color(200)));
  ((Button) ui.get("Back")).setBorderColor(color(220, 220, 20));
}



// Scene 7 - Help
void loadScene_7() {
  ui.clear();

  ui.put("Header", new TextBox("Header", "Help", 0, 0, width, 55, color(20, 230, 180), color(255)));
  ui.put("HeaderBottomBorder", new UIRect("HeaderBottomBorder", 0, 55, width, 2, color(70, 175, 150)));
  ((TextBox) ui.get("Header")).align("CENTER");

  ui.put("Wrapper", new UIRect("Wrapper", 5, 57, width-10, height-60, color(255)));
  ui.put("WrapperBottomBorder", new UIRect("WrapperBottomBorder", 4, height-5, width-8, 2, color(150)));

  ui.put("Message", new RoundedTextBox("Message", "A few questions first...", 15, 65, width-30, 32, color(234), color(10)));
  ((RoundedTextBox) ui.get("Message")).align("CENTER");

  ui.put("Back", new Button("«", 0, 2, 55, 51, color(20, 230, 180), color(255), color(100), color(200)));
  ((Button) ui.get("Back")).setBorderColor(color(20, 230, 180));
}



// Scene 8 - Feedback
void loadScene_8() {
  ui.clear();

  ui.put("Header", new TextBox("Header", "Feedback", 0, 0, width, 55, color(20, 180, 230), color(255)));
  ui.put("HeaderBottomBorder", new UIRect("HeaderBottomBorder", 0, 55, width, 2, color(70, 150, 175)));
  ((TextBox) ui.get("Header")).align("CENTER");

  ui.put("Wrapper", new UIRect("Wrapper", 5, 57, width-10, height-60, color(255)));
  ui.put("WrapperBottomBorder", new UIRect("WrapperBottomBorder", 4, height-5, width-8, 2, color(150)));

  ui.put("Message", new RoundedTextBox("Message", "A few questions first...", 15, 65, width-30, 32, color(234), color(10)));
  ((RoundedTextBox) ui.get("Message")).align("CENTER");

  ui.put("Back", new Button("«", 0, 2, 55, 51, color(20, 180, 230), color(255), color(100), color(200)));
  ((Button) ui.get("Back")).setBorderColor(color(20, 180, 230));
}



// Scene 9 - New Connections > Subcategory Selection
void loadScene_9(int cat) {
  ui.clear();

  ui.put("Wrapper", new UIRect("Wrapper", 5, 0, width-10, height-3, color(255)));
  ui.put("WrapperBottomBorder", new UIRect("WrapperBottomBorder", 4, height-5, width-8, 2, color(150)));
  ui.get("Wrapper").setFixedPosition(true);
  ui.get("WrapperBottomBorder").setFixedPosition(true);

  ui.put("Header", new TextBox("Header", "New Connections", 0, 0, width, 55, color(180, 20, 230), color(255)));
  ui.put("HeaderBottomBorder", new UIRect("HeaderBottomBorder", 0, 55, width, 2, color(110, 30, 135)));
  ((TextBox) ui.get("Header")).align("CENTER");

  ui.put("Message", new RoundedTextBox("Message", "Select a subcategory", 15, 65, width-30, 32, color(234), color(10)));
  ((RoundedTextBox) ui.get("Message")).align("CENTER");

  ui.put("Back", new Button("«", 0, 2, 55, 51, color(180, 20, 230), color(255), color(100), color(200)));
  ((Button) ui.get("Back")).setBorderColor(color(180, 20, 230));

  for (int i=0; i<catList.get(cat).getSubcategories().size(); i++) {
    String name = "Subcategory"+i;
    ui.put(name, new Button(catList.get(cat).getSubcategories().get(i).getName(), 15, 110+60*i, width-30, 50, color(180-i*20, 20, 230), color(255), color(100), color(200)));
  }
}



// Scene 10 - New Connections > Topic Selection
void loadScene_10(int cat, int sub) {
  ui.clear();

  ui.put("Wrapper", new UIRect("Wrapper", 5, 0, width-10, height-3, color(255)));
  ui.put("WrapperBottomBorder", new UIRect("WrapperBottomBorder", 4, height-5, width-8, 2, color(150)));
  ui.get("Wrapper").setFixedPosition(true);
  ui.get("WrapperBottomBorder").setFixedPosition(true);

  ui.put("Header", new TextBox("Header", "New Connections", 0, 0, width, 55, color(180, 20, 230), color(255)));
  ui.put("HeaderBottomBorder", new UIRect("HeaderBottomBorder", 0, 55, width, 2, color(110, 30, 135)));
  ((TextBox) ui.get("Header")).align("CENTER");

  ui.put("Message", new RoundedTextBox("Message", "Select a topic", 15, 65, width-30, 32, color(234), color(10)));
  ((RoundedTextBox) ui.get("Message")).align("CENTER");

  ui.put("Back", new Button("«", 0, 2, 55, 51, color(180, 20, 230), color(255), color(100), color(200)));
  ((Button) ui.get("Back")).setBorderColor(color(180, 20, 230));

  for (int i=0; i<catList.get(cat).getSubcategories().get(sub).getTopics().size(); i++) {
    String name = "Topic"+i;
    ui.put(name, new Button(catList.get(cat).getSubcategories().get(sub).getTopics().get(i).getName(), 15, 110+60*i, width-30, 50, color(180-i*20, 20, 230), color(255), color(100), color(200)));
  }
}



// Scene 11 - New Connections > Item Selection
void loadScene_11(int cat, int sub, int topic) {
  ui.clear();

  ui.put("Wrapper", new UIRect("Wrapper", 5, 0, width-10, height-3, color(255)));
  ui.put("WrapperBottomBorder", new UIRect("WrapperBottomBorder", 4, height-5, width-8, 2, color(150)));
  ui.get("Wrapper").setFixedPosition(true);
  ui.get("WrapperBottomBorder").setFixedPosition(true);

  ui.put("Header", new TextBox("Header", "New Connections", 0, 0, width, 55, color(180, 20, 230), color(255)));
  ui.put("HeaderBottomBorder", new UIRect("HeaderBottomBorder", 0, 55, width, 2, color(110, 30, 135)));
  ((TextBox) ui.get("Header")).align("CENTER");

  ui.put("Message", new RoundedTextBox("Message", "Select an item", 15, 65, width-30, 32, color(234), color(10)));
  ((RoundedTextBox) ui.get("Message")).align("CENTER");

  ui.put("Back", new Button("«", 0, 2, 55, 51, color(180, 20, 230), color(255), color(100), color(200)));
  ((Button) ui.get("Back")).setBorderColor(color(180, 20, 230));

  for (int i=0; i<catList.get(cat).getSubcategories().get(sub).getTopics().get(topic).getItems().size(); i++) {
    String name = "Item"+i;
    ui.put(name, new Button(catList.get(cat).getSubcategories().get(sub).getTopics().get(topic).getItems().get(i).getName(), 15, 110+60*i, width-30, 50, color(180-i*20, 20, 230), color(255), color(100), color(200)));
  }
}



void loadScene_20() {
  ui.clear();

  ui.put("Header", new TextBox("Header", "Friend Finder Prototype", 0, 0, width, 55, color(60, 170, 200), color(255)));
  ui.put("HeaderBottomBorder", new UIRect("HeaderBottomBorder", 0, 55, width, 2, color(45, 128, 150)));
  ((TextBox) ui.get("Header")).align("CENTER");

  ui.put("Wrapper", new UIRect("Wrapper", 5, 55, width-10, height-60, color(255)));
  ui.put("WrapperBottomBorder", new UIRect("WrapperBottomBorder", 4, height-5, width-8, 2, color(150)));

  ui.put("Output", new RoundedTextBox("Output", "Your message", 15, 65, 300-30, 32, color(234), color(10)));
  ui.put("Input", new RoundedTextBox("Input", "Incoming message", 15, 105, 300-30, 32, color(234), color(10)));

  for (int y=0; y<3; y++) {
    for (int x=0; x<3; x++) {
      String id = x+y*3+"";
      String name = "Button"+id;
      ui.put(name, new Button(name, 20+90*x, 156+90*y, 80, 80, color(120, 140+x*15+y*15, 180), color(255), color(100), color(200)));
      ((Button) ui.get(name)).setBorderColor(color(230));
    }
  }

  ui.put("Button9", new Button("9", 150-40, 425, 80, 80, color(20, 230, 180), color(255), 100, 200));
  ((Button) ui.get("Button9")).setBorderColor(color(230));
}