import java.awt.Color;
import java.util.Arrays;
import java.awt.image.BufferedImage;

public class Heatmap
{ 
  private int width, height;
  private double[][] heatdata;
  private double datamax, datamin;

  public Heatmap(double[][] input, int spreadradius)
  {
    // Initialise dimensions and heat array
    this.width = input[0].length;
    this.height = input.length;  
    this.heatdata = new double[height][width];

    // Initialise spread array
    double[][] spread = makeSpreadArray(spreadradius);

    // Everything is cold 0 in the beginning
    for (int y = 0; y < height; ++y)  Arrays.fill(heatdata[y], 0);

    int spreadsize = spreadradius*2+1;

    datamax = Integer.MIN_VALUE;
    datamin = Integer.MAX_VALUE;

    for (int y = 0; y < height; y++) 
    {
      for (int x = 0; x < width; x++) 
      {                
        if (input[y][x] == 0.0) continue;

        for (int sy = 0; sy < spreadsize; sy++)
        {      
          int dy = y - spreadradius + sy;
          if (dy < 0 || dy >= height) continue;

          for (int sx = 0; sx < spreadsize; sx++)
          {
            double iv = input[y][x] * spread[sy][sx];
            int dx = x - spreadradius + sx;

            if (dx < 0 || dx >= width) continue;

            double nv = heatdata[dy][dx] + iv;
            if (nv > datamax) 
              datamax = nv;
            if (nv < datamin) 
              datamin = nv;
            heatdata[dy][dx] = nv;
          }
        }
      }
    }
  }

  /* Generate a spread array
   * input: the radius for the pixel to affect
   * output: a 2 dimensional array of spread
   * example: (2)
   * 0.0572 0.2546 0.3333 0.2546 0.0572 
   * 0.2546 0.5286 0.6667 0.5286 0.2546 
   * 0.3333 0.6667 1.0000 0.6667 0.3333 
   * 0.2546 0.5286 0.6667 0.5286 0.2546 
   * 0.0572 0.2546 0.3333 0.2546 0.0572 
   * ( No real mathematical reason behind this ) 
   */
  private double[][] makeSpreadArray(int radius)
  {
    int dim = radius*2+1;
    double[][] spread = new double[dim][dim];

    double div = Math.hypot(radius+1, 0);

    for (int y = 0; y <= radius; y++)
    {
      for (int x = 0; x <= radius; x++)
      {
        double d = (div - Math.hypot(x, y)) / (radius+1);
        if (d < 0) d = 0;        
        spread[radius+y][radius+x] = d;    
        spread[radius-y][radius+x] = d;    
        spread[radius+y][radius-x] = d;    
        spread[radius-y][radius-x] = d;
      }
    }    
    return spread;
  }


  public BufferedImage makeImage()
  {    
    int[] hsvcolour = new int[256];
    float fromH = 160.0f/256;
    float toH = 0;
    float diff = (toH-fromH)/256.0f;
    float sat = 240.0f/256;
    float lum = 177.0f/256;
    for (int i=0; i<256; i++)
    {
      Color c = Color.getHSBColor(fromH + diff*i, sat, lum);
      hsvcolour[i] = c.getRGB();
    }
    return makeImage(hsvcolour);
  }

  public BufferedImage makeImage(int[] colourmap)
  {
    BufferedImage output = new BufferedImage(width, height, BufferedImage.TYPE_INT_ARGB);

    // First build colour set
    int cl = colourmap.length-1;    
    double range = datamax - datamin;

    if (range > 0)
    {
      for (int y=0; y<height; y++)
      {
        for (int x=0; x<width; x++)
        {
          double r = (heatdata[y][x] - datamin) / range;
          int c = (int)(r*cl);
          output.setRGB(x, y, colourmap[c]);
        }
      }
    }
    return output;
  }
}