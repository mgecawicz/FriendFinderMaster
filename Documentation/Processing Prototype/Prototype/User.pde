//*****************************//
//       USER DEFINITION       //
//*****************************//

public class User {
  private String name;      // Username, i.e. "Dylan"
  private String id;        // Used to zero-in on a particular ID once a conversation has started
  private float dist;       // Distance from this device to the user
  private float similarity; // Measure of how much of a "match" exists between
  private ArrayList<User> myList;  // The ArrayList to which this user belongs
  
  public User(String name, String id, float dist) {
    // Create a user with a set name, id, and distance
    this.name = name;
    this.id = id;
    this.dist = dist;
  }
  
  
  // Modifiers
  public void setName(String name) {
    this.name = name;
  }
  
  public void setID(String id) {
    this.id = id;
  }
  
  public void setDist(float dist) {
    this.dist = dist;
  }
  
  public void setSimilarity(float similarity) {
    this.similarity = similarity;
  }
  
  
  // Accessors
  public String getName() {
    return name;
  }
  
  public String getID() {
    return id;
  }
  
  public float getDist() {
    return dist;
  }
  
  public float getSimilarity() {
    return similarity;
  }
  
  
  // Utility Methods
  public void moveTo(ArrayList<User> newList) {
    newList.add(this);
    myList.remove(this);
    myList = newList;
  }
  
  public void destroy() {
    myList.remove(this);
  }
}