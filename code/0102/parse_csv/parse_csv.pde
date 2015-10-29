// The following short CSV file called "food.csv" is parsed
// in the code below. It must be in the project's "data" folder.
//
// sample data in the file
// id,start,end,yummy,healthy,ingredients
// 0,10/14 08:48,10/14 08:55,8,10,fruits|nuts
// 1,10/14 13:22,10/14 13:31,5,3,bread
// 2,10/14 13:33,10/14 13:58,7,8,salad|fruits
//
// Reference
// https://processing.org/reference/loadTable_.html
// https://processing.org/reference/saveTable_.html
// http://docs.oracle.com/javase/7/docs/api/java/lang/String.html

Table food_table;

void setup() {
  
  // load file data into memory
  food_table = loadTable("food.csv", "header");
  
  // check how many rows in the table
  println(food_table.getRowCount() + " total rows in table");

  // read and update the data
  for (TableRow row : food_table.rows()) {
    // access data based on the header name
    int id = row.getInt("id");
    String start_date = row.getString("start");
    String end_date = row.getString("end");
    int yummy = row.getInt("yummy");
    int healthy = row.getInt("healthy");
    String ingredients = row.getString("ingredients");
    // for debugging
    println("I had "+ingredients+" from " + start_date + " to " + end_date + ", " + "and it's " + yummy + " out of 10 yummy, " + healthy + " out of 10 healthy");

    // adding missing information 
    row.setString("start", "2015-" + start_date.replace("/","-") + ":00");
    row.setString("end", "2015-" + end_date.replace("/","-") + ":00");
  }
  // save from memory to file
  saveTable(food_table, "data/food_formatted.csv");
  
  // for debugging 
  println("------------------------------------------");
  println("formatted table is saved!");
  println("------------------------------------------");

  // print new updated table
  for (TableRow row : food_table.rows()) {
    String start_date = row.getString("start");
    String end_date = row.getString("end");
    int yummy = row.getInt("yummy");
    int healthy = row.getInt("healthy");
    String ingredients = row.getString("ingredients");
    println("I had "+ingredients+" from " + start_date + " to " + end_date + ", " + "and it's " + yummy + " out of 10 yummy, " + healthy + " out of 10 healthy");
  }
}