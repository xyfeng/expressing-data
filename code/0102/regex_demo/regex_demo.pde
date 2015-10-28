// Reference
// https://processing.org/tutorials/data/
// Tools
// https://regex101.com/
// http://regexr.com/
// Tutorials
// http://akowalz.github.io/
// Tutorial in Java
// http://shiffman.net/teaching/a2z_2008/regex/#java


import java.util.regex.*;

void setup() {
  // Load text file as a string
  String[] speech = loadStrings("speech.txt"); 
  String regex = "[ou]+";  //aeiou
  for (String line : speech) {
    // double ou sound
    String output = line.replaceAll(regex, "$0$0");
    println(output);
  }
}