void setup()
{
  size(1000, 500);
  background(0);
  
  loadData();
  
  fill(200, 200, 200); 
  textAlign(CENTER,CENTER);
  text("Ireland: Electricity consumption per capita (kWh)", width * 0.5f, 50);
  text("Press 1 for line graph\nPress 2 for pie chart", 900, 50);
  
}

ArrayList<Integer> dataEC = new ArrayList<Integer>();
ArrayList<Integer> datayear = new ArrayList<Integer>();

void draw()
{
  if (key == '1' ) 
    {
      linegraph(dataEC, datayear);
    }
     else if(key == '2')
    {
      piechart(dataEC, datayear);
    }
}

void keyPressed() 
{}


void loadData()
{
  //loads the Ireland Electric consumption 1960-2010 contains year and data
  String[] strings = loadStrings("IEEC.csv");
  
  for(String s:strings)
  {
    //split the strings["yeardata"] to line["year","data"] 
    String[] line = s.split(",");
    
    // Placing the year into Arraylist datayear, Float.parseFloat change string to float
    //this gets the line[0] which are the years
    for (int i = 0 ; i < line.length -1 ; i ++)
    {
      datayear.add(Integer.parseInt(line[i]));              
    }
    
    // Placing the electric consumption data into Arraylist dataEC
    //this gets the line[1] which are the data
    for (int i = 1 ; i < line.length ; i ++)
    {
      dataEC.add(Integer.parseInt(line[i]));              
    }
  }
}


void linegraph(ArrayList<Integer> dataEC, ArrayList<Integer> datayear)
{
   float border = width * 0.1f; //border=100
   float verticalIntervals = 7;
   float horizontalIntervals = 10;
   float ticks = border * 0.1f;
   float vertMaxRange = 7000000;
   float dataLabel;
     
   stroke(200, 200, 200);
   fill(200, 200, 200); 
   
   background(0);
   text("Ireland: Electricity consumption per capita (kWh)", width * 0.5f, 50);
   text("Press 1 for line graph\nPress 2 for pie chart", 900, 50);
      
   //Draw the vertical line axis
   line(border, border, border, height - border );
   
   for (int i = 0 ; i <= verticalIntervals ; i ++)
   {
    float y = map(i, 0, verticalIntervals, height - border,  border);
    line(border - ticks, y, border, y);
    dataLabel = map(i, 0, verticalIntervals, 0, vertMaxRange);    
    textAlign(RIGHT, CENTER);  
    text((int)dataLabel, border - ticks, y);
   }    
   
   
   //Draw the horizontal line axis
    line(border, height - border, width -(border * 2.0f), height - border );
   
    for (int i = 0 ; i <= horizontalIntervals ; i ++)
    {
      float x = map(i, 0, horizontalIntervals, border, width -(border * 2.0f));
      line(x, height - (border - ticks), x, height - border );
      dataLabel = map(i, 0, horizontalIntervals, datayear.get(0), datayear.get(50));    
      textAlign(CENTER, CENTER);  
      text((int)dataLabel, x, height - (border - (ticks * 2.0f)));
    }
    
    
    //draw the line graph data
    stroke(0, 255, 255);
    for (int i = 0 ; i < dataEC.size()-1 ; i ++)
    {
      float x1 = map(i, 0, dataEC.size()-1, border, width -(border * 2.0f));
      float x2 = map((i+1), 0, dataEC.size()-1, border, width -(border * 2.0f)); 
      float y1 = map(dataEC.get(i), 0, vertMaxRange, height - border, border);
      float y2 = map(dataEC.get(i+1), 0, vertMaxRange, height - border, border);
      line(x1, y1, x2, y2);
    }


//mouseX hover..gives year and data 
    if(mouseX < border)
    {
      mouseX = (int)border;
    }
    else if(mouseX > (width -(border * 2.0f)))
    {
      mouseX = (int)(width -(border * 2.0f));
    }
    
    //hover, maps mouseX to get the data.get[number]
    int hover = (int)map(mouseX,100,800,0,dataEC.size()-1); 
    
    // get the location of the data from the graph
    float y2location = map(dataEC.get(hover), 0, vertMaxRange, height - border, border); 
    
    //draws the hovering line
    line( mouseX, height-border, mouseX, y2location);
    
    //Writes down the values
    text("Electric Consumption: " + dataEC.get(hover),400,100);
    text("Year: " + datayear.get(hover),400,120);
    
    println("" +hover);
    println("" + mouseX);   
}

void piechart(ArrayList<Integer> dataEC, ArrayList<Integer> datayear)
{  
   stroke(200, 200, 200);
   fill(200, 200, 200); 
   
   background(0);
   text("Ireland: Electricity consumption per capita (kWh)", width * 0.5f, 50);
   text("Press 1 for line graph\nPress 2 for pie chart", 900, 50);
}

   