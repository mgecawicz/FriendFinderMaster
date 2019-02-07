import java.util.Iterator;

void loadDatabase() {

  JSONObject categories;
  JSONObject subcategories;
  JSONObject topics;
  JSONObject items;

  ArrayList<Subcategory> subcategoryList = new ArrayList<Subcategory>();
  ArrayList<Topic> topicList = new ArrayList<Topic>();                  // These lists do not exist outside of loadDatabase()
  ArrayList<Item> itemList = new ArrayList<Item>();                     // To reference them, use a Category object

  int start = millis();  // Time before loading the database

  categories = loadJSONObject("database.json");                         // Load the database file
  Iterator c = categories.keys().iterator();                            // Make an iterator from the keys (keys at this stage = category names)
  while (c.hasNext()) {                                                 // While there are more category keys
    Object c_temp = c.next();                                           // Get the next one
    subcategories = categories.getJSONObject((String) c_temp);          // Use that key to get the next JSON Object, which is the category itself (not just the names)
    Iterator s = subcategories.keys().iterator();                       // Make an iterator from the keys (keys = subcategory names)
    while (s.hasNext()) {                                               // Repeat for each subcategory
      Object s_temp = s.next();
      topics = subcategories.getJSONObject((String) s_temp);            // next object -> subcategory
      Iterator t = topics.keys().iterator();                            // Make an iterator from the keys (keys = topic names)
      while (t.hasNext()) { 
        Object t_temp = t.next();
        items = topics.getJSONObject((String) t_temp);                  // next object -> topic
        Iterator i = items.keys().iterator();                           // Make an iterator from the keys (keys = item names)
        while (i.hasNext()) { 
          Object i_temp = i.next();
          itemList.add(new Item((String) i_temp));                      // Add individual items to itemList ArrayList
        }
        topicList.add(new Topic((String) t_temp, itemList));            // Add a topic with a list of all items it contains, then clear itemList for the next pass of the loop
        itemList = new ArrayList<Item>();
      }
      subcategoryList.add(new Subcategory((String) s_temp, topicList)); // Add a subcategory with a list of all topics it contains, clear topicList
      topicList = new ArrayList<Topic>();
    }
    catList.add(new Category((String) c_temp, subcategoryList));        // Add a category with a list of a subcategories it contains, clear subcategoryList
    subcategoryList = new ArrayList<Subcategory>();                     // End result: A list of category objects (catList), each one containing subcategory objects, etc.
  }

  println("Database loaded in "+(millis()-start)+" ms.");  // Report how long it took, important as the database grows
}

void offloadDatabase() {
  catList.clear();                  // Remove information that is no longer useful, free up storage
  println("Database offloaded.");   // Report to console, could also log this if wanted
}


public class Category {
  private String name;
  private ArrayList<Subcategory> subcategories;

  public Category(String name, ArrayList<Subcategory> subcategories) {
    this.name = name;
    this.subcategories = subcategories;
  }

  public String getName() {
    return name;
  }

  public ArrayList<Subcategory> getSubcategories() {
    return subcategories;
  }
}

public class Subcategory {
  private String name;
  private ArrayList<Topic> topics;

  public Subcategory(String name, ArrayList<Topic> topics) {
    this.name = name;
    this.topics = topics;
  }

  public String getName() {
    return name;
  }

  public ArrayList<Topic> getTopics() {
    return topics;
  }
}

public class Topic {
  private String name;
  private ArrayList<Item> items;

  public Topic(String name, ArrayList<Item> items) {
    this.name = name;
    this.items = items;
  }

  public String getName() {
    return name;
  }

  public ArrayList<Item> getItems() {
    return items;
  }
}

public class Item {
  private String name;

  public Item(String name) {
    this.name = name;
  }

  public String getName() {
    return name;
  }

  public String toString() {
    return name;
  }
}