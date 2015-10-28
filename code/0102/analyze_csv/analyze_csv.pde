// The following short CSV file called "food_formatted.csv" is parsed
// in the code below. It must be in the project's "data" folder.
//
// id,start,end,yummy,healthy,ingredients
// 0,2015-10-14 08:48:00,2015-10-14 08:55:00,8,10,fruits|nuts
// 1,2015-10-14 13:22:00,2015-10-14 13:31:00,5,3,bread
// 2,2015-10-14 13:33:00,2015-10-14 13:58:00,7,8,salad|fruits
//
// Reference
// https://processing.org/reference/loadTable_.html
// https://processing.org/reference/saveTable_.html
// http://docs.oracle.com/javase/7/docs/api/java/lang/String.html

Table food_table;

void setup() {

  food_table = loadTable("food.csv", "header");

  println(food_table.getRowCount() + " total rows in table");

  // read and format the data
  for (TableRow row : food_table.rows()) {
    int id = row.getInt("id");
    String start_date = row.getString("start");
    String end_date = row.getString("end");
    int yummy = row.getInt("yummy");
    int healthy = row.getInt("healthy");
    String ingredients = row.getString("ingredients");
    println("I had "+ingredients+" from " + start_date + " to " + end_date + ", " + "and it's " + yummy + " out of 10 yummy, " + healthy + " out of 10 healthy");

    // reformat dates
    row.setString("start", "2015-" + start_date.replace("/","-") + ":00");
    row.setString("end", "2015-" + end_date.replace("/","-") + ":00");
  }
  saveTable(food_table, "data/food_formatted.csv");
  println("------------------------------------------");
  println("formatted table is saved!");
  println("------------------------------------------");

  // print new formatted table
  for (TableRow row : food_table.rows()) {
    String start_date = row.getString("start");
    String end_date = row.getString("end");
    int yummy = row.getInt("yummy");
    int healthy = row.getInt("healthy");
    String ingredients = row.getString("ingredients");
    println("I had "+ingredients+" from " + start_date + " to " + end_date + ", " + "and it's " + yummy + " out of 10 yummy, " + healthy + " out of 10 healthy");
  }
}
