// this sketch file merge two data files into one
Table city_table;
Table population_table;

void setup() {
  // load cities data from file to memory
  city_table = loadTable("cities.csv", "header");
  // add a new column
  city_table.addColumn("Population");
  // load population data from file to memory
  population_table = loadTable("population.csv", "header");

  // loop through city table
  for (TableRow row_1 : city_table.rows()) {
    // retrieve city name
    String name_1 = row_1.getString("Chinese");
    // create default population value
    int population = 1000000;
    // loop thruogh population table, (note: this is a nested loop)
    for (TableRow row_2 : population_table.rows()) {
      // retrieve city name
      String name_2 = row_2.getString("city");
      // compare city names to find a match
      if(name_1.equals(name_2)){
        // retrieve population number
        population = int(row_2.getString("population").replace(",",""));
        break;
      }
    }
    // for debug
    println(population);
    // assign value to population
    row_1.setInt("Population", population);
  }
  
  // save population data from memory to file
  saveTable(city_table, "data/cities_population.csv");
}