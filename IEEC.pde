class IEEC
{
  int Year;
  int Amount;
  color colours;
  
  IEEC (String line)
  {
    String[] A = line.split(",");
    
    Year = Integer.parseInt(A[0]);
    Amount = Integer.parseInt(A[1]);
    colours = color(random(0,255),random(0,255),random(0,255)); 
  }
}