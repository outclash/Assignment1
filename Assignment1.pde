void setup()
{
  size(1000, 500);
  background(0);

  loadData();

  fill(200, 200, 200); 
  textAlign(CENTER, CENTER);
  text("Ireland: Electricity consumption per capita (kWh)", width * 0.5f, 50);
  text("Press 1 for line graph\nPress 2 for bar graph", 900, 50);
}

ArrayList<IEEC> data = new ArrayList<IEEC>();

void draw()
{
  if (key == '1' ) 
  {
    linegraph(data);
  } else if (key == '2')
  {
    bargraph(data);
  }
}

void keyPressed() 
{
}



void loadData()
{
  String[] lines = loadStrings("IEEC.csv");
  for (int i = 0; i < lines.length; i ++)
  {
    IEEC ieec = new IEEC(lines[i]);
    data.add(ieec);
  }
}



void linegraph(ArrayList<IEEC> data)
{
  float border = width * 0.1f; //border=100
  float verticalIntervals = 7; 
  float horizontalIntervals = 10;
  float ticks = border * 0.1f;
  float vertMaxRange = 7000000;
  float botBorderRange = height - border;
  float rightBorderRange = width -(border * 2.0f);
  float dataLabel;

  stroke(200, 200, 200);
  fill(200, 200, 200); 

  background(0);
  text("Ireland: Electricity consumption per capita (kWh)", width * 0.5f, 50);
  text("Press 1 for line graph\nPress 2 for bar graph", 900, 50);

  //Draw the vertical line axis
  line(border, border, border, botBorderRange );

  //Draw the vertical ticks and datalabel intervals
  for (int i = 0; i <= verticalIntervals; i ++)
  {
    float y = map(i, 0, verticalIntervals, botBorderRange, border);
    line(border - ticks, y, border, y);
    dataLabel = map(i, 0, verticalIntervals, 0, vertMaxRange);    
    textAlign(RIGHT, CENTER);  
    text((int)dataLabel, border - ticks, y);
  }    


  //Draw the horizontal line axis
  line(border, botBorderRange, rightBorderRange, botBorderRange );

  //Draw the horizontal ticks and datalabel intervals
  for (int i = 0; i <= horizontalIntervals; i ++)
  {
    float x = map(i, 0, horizontalIntervals, border, rightBorderRange);
    line(x, height - (border - ticks), x, botBorderRange );
    dataLabel = map(i, 0, horizontalIntervals, data.get(0).Year, data.get(50).Year);    
    textAlign(CENTER, CENTER);  
    text((int)dataLabel, x, height - (border - (ticks * 2.0f)));
  }


  //draw the line graph data
  stroke(0, 255, 255);
  for (int i = 0; i < data.size()-1; i ++)
  {
    float x1 = map(i, 0, data.size()-1, border, rightBorderRange);
    float x2 = map((i+1), 0, data.size()-1, border, rightBorderRange); 
    float y1 = map(data.get(i).Amount, 0, vertMaxRange, botBorderRange, border);
    float y2 = map(data.get(i+1).Amount, 0, vertMaxRange, botBorderRange, border);
    line(x1, y1, x2, y2);
  }


  //mouseX hover..gives year and data 
  stroke(255, 0, 255);
  if (mouseX < border)
  {
    mouseX = (int)border;
  } else if (mouseX > (rightBorderRange))
  {
    mouseX = (int)(rightBorderRange);
  }

  //hover, maps mouseX to get the data.get[number]
  int hover = (int)map(mouseX, 100, 800, 0, data.size()-1); 

  // get the location of the data from the graph
  float y2location = map(data.get(hover).Amount, 0, vertMaxRange, botBorderRange, border); 

  //draws the hovering line
  line( mouseX, botBorderRange, mouseX, y2location);
  line(border, y2location, mouseX, y2location);

  //Writes down the values
  text("Electric Consumption: " + data.get(hover).Amount, 400, 100);
  text("Year: " + data.get(hover).Year, 400, 120);

  println("" +hover);
  println("" + mouseX);
}





void bargraph(ArrayList<IEEC> data)
{  
  stroke(200, 200, 200);
  fill(200, 200, 200); 

  background(0);
  text("Ireland: Electricity consumption per capita (kWh)", width * 0.3f, 50);
  text("Press 1 for line graph\nPress 2 for bar graph", 850, 50);

  int[] sum = new int[6];

  for (int i = 0; i < data.size(); i++)
  {
    sum[0] += data.get(i).Amount; //total sum 

    if (i < 10)
    {
      sum[1] += data.get(i).Amount; //sum of first 10 data
    } else if (i >= 10 && i < 20 )
    {
      sum[2] += data.get(i).Amount; //sum of next 10 data
    } else if (i >= 20 && i < 30)
    {
      sum[3] += data.get(i).Amount; //sum of next 10 data
    } else if (i >= 30 && i < 40)
    {
      sum[4] += data.get(i).Amount; //sum of next 10 data
    } else if (i >= 40 && i < 50)
    {
      sum[5] += data.get(i).Amount; //sum of next to last data
    }
  }


  float border = width * 0.1f; //border=100
  float verticalIntervals = 5; 
  float horizontalIntervals = 5;
  float ticks = border * 0.1f;
  float vertMaxRange = 65000000; //Max range for the sums of bars
  float botBorderRange = height - border;
  float rightBorderRange = width -(border * 2.0f);
  float dataLabel;    
  float sumbarwidth = (width - (border * 3.0f ) +data.size()) / (sum.length - 1); //+data.size to fit all invidividual bars to the bigger bars


  //Draw the left vertical line axis
  line(border, border, border, botBorderRange );

  //Draw the vertical ticks and datalabel intervals
  for (int i = 0; i <= verticalIntervals; i ++)
  {
    float y = map(i, 0, verticalIntervals, botBorderRange, border);
    line(border - ticks, y, border, y);
    dataLabel = map(i, 0, verticalIntervals, 0, vertMaxRange);    
    textAlign(RIGHT, CENTER);  
    text((int)dataLabel, border - ticks, y);
  }    

  //Draw the horizontal line axis
  line(border, botBorderRange, rightBorderRange, botBorderRange );

  //Draw the horizontal ticks and datalabel intervals
  for (int i = 0; i <= horizontalIntervals; i ++)
  {
    float x = map(i, 0, horizontalIntervals, border, rightBorderRange);
    line(x, height - (border - ticks), x, botBorderRange );
    dataLabel = map(i, 0, horizontalIntervals, data.get(0).Year, data.get(50).Year);    
    textAlign(CENTER, CENTER);  
    text((int)dataLabel, x, height - (border - (ticks * 2.0f)));
  }

  //draw the sums bar graph data
  stroke(100, 100, 255);
  for (int i = 1; i < sum.length; i ++)
  {
    float x1 = map(i, 1, sum.length-1, border, rightBorderRange - sumbarwidth); 
    float y1 = map(sum[i], 0, vertMaxRange, 0, 300);
    fill(data.get(i+10).colours);
    rect(x1, botBorderRange, sumbarwidth, -y1 );
    text(sum[i], x1 + (border * 0.5f), (botBorderRange - border * 0.1f) - y1  );
  }


  float individualbarwidth = (width - (border * 3.0f )) / data.size(); //use for individual barwidth
  float MaxindvBarheight = 200; // this is the max vertical Range for the individual bars
  float indvbarintervals = 5;
  float indvVertMaxRange = 7000000;


  //Draw the  right vertical  line axis for the individual bars 
  stroke(200, 200, 200);
  fill(200, 200, 200); 
  line(rightBorderRange, MaxindvBarheight, rightBorderRange, botBorderRange );

  //Draw the right vertical line ticks and datalabel intervals
  for (int i = 0; i <= indvbarintervals; i ++)
  {
    float y = map(i, 0, indvbarintervals, botBorderRange, MaxindvBarheight );
    line(rightBorderRange + ticks, y, rightBorderRange, y);
    dataLabel = map(i, 0, indvbarintervals, 0, indvVertMaxRange);    
    textAlign(LEFT, CENTER);  
    text((int)dataLabel, rightBorderRange + ticks, y);
  }    

  //draw the individual bar graph data
  stroke(100, 100, 255);
  for (int i = 0; i < data.size(); i ++)
  {
    float x1 = map(i, 0, data.size()-1, border, rightBorderRange-individualbarwidth); 
    float y1 = map(data.get(i).Amount, 0, indvVertMaxRange, 0, MaxindvBarheight);
    fill(data.get(i).colours);
    if (mouseX > x1 && mouseX < x1 + individualbarwidth )
    {
      fill(255);
      ellipse(x1+7, botBorderRange + 10 , 10, 10);
    }
    rect(x1, botBorderRange, individualbarwidth, -y1 );
     
  }
  
  //mouseX hover..gives year and data 
  if (mouseX < border)
  {
    mouseX = (int)border;
  } else if (mouseX > (rightBorderRange))
  {
    mouseX = (int)(rightBorderRange);
  }

  //hover, maps mouseX to get the data.get[number]
  int hover = (int)map(mouseX, 100, 800, 0, data.size()-1); 

  //Writes down the values
  stroke(200, 200, 200);
  fill(200, 200, 200); 
  text("Electric Consumption: " + data.get(hover).Amount, 400, 100);
  text("Year: " + data.get(hover).Year, 400, 120);
  
  text("Total sum: " + sum[0], 850, 120);
}