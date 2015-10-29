// The following short CSV file called "food_formatted.csv" is parsed
// in the code below. It must be in the project's "data" folder.
//
// sample data from file
// id,start,end,yummy,healthy,ingredients
// 0,2015-10-14 08:48:00,2015-10-14 08:55:00,8,10,fruits|nuts
// 1,2015-10-14 13:22:00,2015-10-14 13:31:00,5,3,bread
// 2,2015-10-14 13:33:00,2015-10-14 13:58:00,7,8,salad|fruits
//
// targetted json format
// [
//     {
//         "start": "2015-10-14 08:48:00",
//         "end": "2015-10-14 08:55:00",
//         "yummy": 8,
//         "healthy": "10",
//         "ingredients": [
//             "fruits",
//             "nuts"
//         ]
//     }
// ]
//
// References
// https://processing.org/reference/JSONArray.html
// https://processing.org/reference/JSONArray_append_.html
// https://processing.org/reference/split_.html
// https://processing.org/reference/printArray_.html
// https://processing.org/reference/saveJSONArray_.html
// Tools
// https://www.transformy.io/#
// http://codebeautify.org/
// http://app.raw.densitydesign.org/

Table food_table;
JSONArray food_json_array; // data to save

void setup() {

  // load file data in to memory
  food_table = loadTable("food_formatted.csv", "header");

  // initialized the array
  food_json_array = new JSONArray();
  // println(food_table.getRowCount() + " total rows in table");

  // loop through data line by line
  for (TableRow row : food_table.rows()) {
    // int id = row.getInt("id");
    String start_date = row.getString("start");
    String end_date = row.getString("end");
    int yummy = row.getInt("yummy");
    int healthy = row.getInt("healthy");
    String ingredients = row.getString("ingredients");
    //println("I had "+ingredients+" from " + start_date + " to " + end_date + ", " + "and it's " + yummy + " out of 10 yummy, " + healthy + " out of 10 healthy");

    // create json object to store values
    JSONObject each_meal = new JSONObject();
    each_meal.setString("start", start_date);
    each_meal.setString("end", end_date);
    each_meal.setInt("yummy", yummy);
    each_meal.setInt("healthy", healthy);

    // split ingreadients string into array of strings
    String[] ingredients_array = split(ingredients, "|");
    //printArray(ingredients_array);
    // add each ingredient into json array
    JSONArray ingredients_json_array = new JSONArray();
    for(String ingredient : ingredients_array) {
        ingredients_json_array.append(ingredient);
    }
    // add json array to json object
    each_meal.setJSONArray("ingredients", ingredients_json_array);
    // add meal to the food json array
    food_json_array.append(each_meal);
  }

  // save json array from memory to file
  saveJSONArray(food_json_array, "data/food.json");

  println("food json data are saved!");
}