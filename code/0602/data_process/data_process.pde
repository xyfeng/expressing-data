import java.io.*;

String curlDownload = "";
void setup()
{
  try {
    Process p = Runtime.getRuntime().exec(curlDownload);
  }
  catch (Exception err) {
    err.printStackTrace();
    println("ERROR");
  }
}