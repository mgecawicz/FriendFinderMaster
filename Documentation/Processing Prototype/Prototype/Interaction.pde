void mousePressed() { //<>//
  if (scene == 0) {
    scene++;
    wait = 300;
    loadScene_1();
  } else if (scene == 1) {
    if (((Button)ui.get("Okay")).isPressed()) {
      scene++;
      wait = 300;
      loadScene_2();
    }
  } else if (scene == 2) {
    if (((Button)ui.get("NewConnections")).isPressed()) {
      scene++;
      wait = 300;
      loadScene_3();
    } else if (((Button)ui.get("PastConnections")).isPressed()) {
      scene++;
      wait = 300;
      loadScene_4();
    } else if (((Button)ui.get("Profile")).isPressed()) {
      scene++;
      wait = 300;
      loadScene_5();
    } else if (((Button)ui.get("ConnectFinder")).isPressed()) {
      scene++;
      wait = 300;
      loadScene_6();
    } else if (((Button)ui.get("Help")).isPressed()) {
      scene++;
      wait = 300;
      loadScene_7();
    } else if (((Button)ui.get("Feedback")).isPressed()) {
      scene++;
      wait = 300;
      loadScene_8();
    }
  } else if (scene <= 8 && ((Button)ui.get("Back")).isPressed()) {
    scene = 2;
    wait = -300;
    loadScene_2();
    if (catList.size() > 0) {
      offloadDatabase();
    }
  } else if (scene == 3) {
    for (int i=0; i<catList.size(); i++) {
      if (((Button)ui.get("Category"+i)).isPressed()) {
        backScene = 3;
        wait = 300;
        scene = 9;
        selectedCategory = i;
        loadScene_9(i);
        break;
      }
    }
  } else if (scene == 9 && !((Button)ui.get("Back")).isPressed()) {
    for (int i=0; i<catList.get(selectedCategory).getSubcategories().size(); i++) {
      if (((Button)ui.get("Subcategory"+i)).isPressed()) {
        backScene = 9;
        wait = 300;
        scene = 10;
        selectedSub = i;
        loadScene_10(selectedCategory, i);
        break;
      }
    }
  } else if (scene == 10 && !((Button)ui.get("Back")).isPressed()) {
    for (int i=0; i<catList.get(selectedCategory).getSubcategories().get(selectedSub).getTopics().size(); i++) {
      if (((Button)ui.get("Topic"+i)).isPressed()) {
        backScene = 10;
        wait = 300;
        scene = 11;
        selectedTopic = i;
        loadScene_11(selectedCategory, selectedSub, i);
        break;
      }
    }
  } else if (scene == 11 && !((Button)ui.get("Back")).isPressed()) {
    for (int i=0; i<catList.get(selectedCategory).getSubcategories().get(selectedSub).getTopics().get(selectedTopic).getItems().size(); i++) {
      if (((Button)ui.get("Item"+i)).isPressed()) {
        //backScene = 10;
        //wait = 300;
        //scene = 11;
        selectedItem = i;

        println(selectedCategory + " " + selectedSub + " " + selectedTopic + " " + selectedItem);
        //loadScene_11(selectedCategory, selectedSub, i);
        break;
      }
    }
  } else if (wait == 0) {
    if (((Button)ui.get("Back")).isPressed()) {
      scene = backScene;
      wait = -300;
      loadScene(backScene);
    }

    for (String key : ui.keySet()) {
      if (ui.get(key) instanceof Button && ((Button)ui.get(key)).isPressed()) {
        myClient.write( id + " " + ((Button)ui.get(key)).getID() );
      }
    }
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  for (String key : ui.keySet()) {
    float old = ui.get(key).getY();
    if (old-int(e) <= ui.get(key).getOriginalY()) {
      ui.get(key).setY(old-int(e));
    }
  }
}

int prev = -1;
float inertia;
//void mouseDragged() {  // Android - only
//  if (prev == -1) {
//    prev = mouseY;
//  }

//  float diff = map((mouseY-prev)*abs(mouseY-pmouseY)/25, -height, height, -height/120, height/120);
//  inertia += diff/2;
//}

//void mouseReleased() {
//  prev = -1;
//}



// TEMPORARY JUST TO GET LIST OF SELECTIONS WORKING - CHANGE ASAP
void loadScene(int s) {
  println("test");
  switch(s) {
  case 3:
    backScene = 2;
    loadScene_3();
    break;
  case 9:
    backScene = 3;
    loadScene_9(selectedCategory);
    break;
  case 10:
    backScene = 9;
    loadScene_10(selectedCategory, selectedSub);
    break;
  }
}