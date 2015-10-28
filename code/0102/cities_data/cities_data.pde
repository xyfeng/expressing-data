Table city_table;
Table population_table;

void setup() {

  city_table = loadTable("cities.csv", "header");
  city_table.addColumn("Population");
  population_table = loadTable("population.csv", "header");

  for (TableRow row_1 : city_table.rows()) {
    String name_1 = row_1.getString("Chinese");
    int population = 1000000;
    for (TableRow row_2 : population_table.rows()) {
      String name_2 = row_2.getString("city");
      if(name_1.equals(name_2)){
        population = int(row_2.getString("population").replace(",",""));
        break;
      }
    }
    println(population);
    row_1.setInt("Population", population);
  }

  saveTable(city_table, "data/cities_population.csv");
}
