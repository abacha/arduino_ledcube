int m[4][4][4] = { 
  { 
    { 0, 0, 0, 0 }, { 0, 0, 0, 0 }, { 0, 0, 0, 0 }, { 0, 0, 0, 0 }
  },
  { 
    { 0, 0, 0, 0 }, { 0, 0, 0, 0 }, { 0, 0, 0, 0 }, { 0, 0, 0, 0 }
  },
  { 
    { 0, 0, 0, 0 }, { 0, 0, 0, 0 }, { 0, 0, 0, 0 }, { 0, 0, 0, 0 }
  },
  { 
    { 0, 0, 0, 0 }, { 0, 0, 0, 0 }, { 0, 0, 0, 0 }, { 0, 0, 0, 0 }
  }
};

void setup()
{
  pinMode(3, OUTPUT);
  pinMode(4, OUTPUT);
  pinMode(5, OUTPUT);
  pinMode(6, OUTPUT);
  pinMode(7, OUTPUT);
  pinMode(8, OUTPUT);
  pinMode(9, OUTPUT);
  pinMode(10, OUTPUT);
  pinMode(11, OUTPUT);
  pinMode(12, OUTPUT);
  pinMode(13, OUTPUT);
  pinMode(A4, OUTPUT);
  pinMode(A3, OUTPUT);
}

void reset()
{
  digitalWrite(3, HIGH);
  digitalWrite(4, HIGH);
  digitalWrite(5, HIGH);
  digitalWrite(6, HIGH);
  digitalWrite(A3, HIGH);
  digitalWrite(A4, HIGH);
  digitalWrite(8, LOW);
  digitalWrite(9, LOW); 
  digitalWrite(10, LOW);
  digitalWrite(11, LOW);
  digitalWrite(12, LOW);
  digitalWrite(13, LOW);
}

int getY(int t)
{
  if (t == 0)
    return 5;
  if (t == 1)
    return 6;
  if (t == 2)
    return 3;    
  if (t == 3)
    return 4;    
}

void lightX(int x, int z)
{

  if (z == 0)
  {
    if (x == 0)
    {
      digitalWrite(13, HIGH); 
      digitalWrite(12, HIGH);
      digitalWrite(11, LOW);      
    }
    if (x == 1)
    {
      digitalWrite(13, HIGH);
      digitalWrite(12, LOW);      
      digitalWrite(11, LOW);            
    }
    if (x == 2)
    {
      digitalWrite(13, HIGH);
      digitalWrite(12, HIGH);        
      digitalWrite(11, HIGH);
    }
    if (x == 3)
    {
      digitalWrite(13, LOW);      
      digitalWrite(12, LOW);            
      digitalWrite(11, HIGH);
    }
  }  
  else if (z == 1)
  {
    if (x == 0)
    {
      digitalWrite(13, LOW);
      digitalWrite(12, LOW);      
      digitalWrite(11, LOW);            
    }
    if (x == 1)
    {
      digitalWrite(13, LOW);
      digitalWrite(12, HIGH);
      digitalWrite(11, LOW);      
    }
    if (x == 2)
    {
      digitalWrite(13, LOW);      
      digitalWrite(12, HIGH);
      digitalWrite(11, HIGH); 
    }
    if (x == 3)
    {
      digitalWrite(13, HIGH);
      digitalWrite(12, LOW);
      digitalWrite(11, HIGH);      
    }
  }
  if (z == 2)
  {
    if (x == 0)
    {
      digitalWrite(10, HIGH); 
      digitalWrite(9, HIGH);
      digitalWrite(8, LOW);      
    }
    if (x == 1)
    {
      digitalWrite(10, HIGH);
      digitalWrite(9, LOW);      
      digitalWrite(8, LOW);            
    }
    if (x == 2)
    {
      digitalWrite(10, LOW);
      digitalWrite(9, LOW);      
      digitalWrite(8, LOW);                  
    }
    if (x == 3)
    {
      digitalWrite(10, HIGH);
      digitalWrite(9, HIGH);        
      digitalWrite(8, HIGH);      
    }
  }  
  else if (z == 3)
  {
    if (x == 2)
    {
      digitalWrite(10, LOW);      
      digitalWrite(9, LOW);            
      digitalWrite(8, HIGH);
    }
    if (x == 0)
    {
      digitalWrite(10, LOW);
      digitalWrite(9, HIGH);
      digitalWrite(8, LOW);      
    }
    if (x == 3)
    {
      digitalWrite(10, LOW);      
      digitalWrite(9, HIGH);
      digitalWrite(8, HIGH); 
    }
    if (x == 1)
    {
      digitalWrite(10, HIGH);
      digitalWrite(9, LOW);
      digitalWrite(8, HIGH);      
    }
  }  
}

void light(int x, int y, int z)
{
  reset();
  if (z > 1)
    digitalWrite(A3, LOW);
  else    
    digitalWrite(A4, LOW);
  
  digitalWrite(getY(y), LOW);
   
  lightX(x, z);
  delayMicroseconds(1500);
}

int t = 0;
int a = 0, old_a = 0;
int b = 0, old_b = 0;
int c = 0, old_c = 0;

void setLayer(int y, int v)
{
  for (int x = 0; x < 4; x++)
    for (int z = 0; z < 4; z++)
      m[x][y][z] = v;

}

void setColumn(int x, int z, int v)
{
  for (int y = 0; y < 4; y++)
    m[x][y][z] = v;
}

void setRow(int y, int z, int v)
{
  for (int x = 0; x < 4; x++)
    m[x][y][z] = v;
}

void clear()
{
  for (int x = 0; x < 4; x++)
    for (int y = 0; y < 4; y++)
      for (int z = 0; z < 4; z++)
        m[x][y][z] = 0;
}

void layerEffect(int time)
{
   if (time % 5 == 0)
   {
     setLayer(b, 1);
     setLayer(old_b, 0);     
     old_b = b;
     if (b == 3)
     {
        b = 0;
     }
     else b++;
  }
}


void rowEffect(int time)
{
   if (time % 5 == 0)
   {
     setRow(a, b, 1);
     setRow(old_a, old_b, 0);     
     old_b = b;
     old_a = a;
     if (b == 3)
     {
        b = 0;
        if (a == 3)
        {
         a = 0;
        }
        else a++;
     }
     else b++;
  }
}

void columnEffect(int time)
{
  if (time % 5 == 0)
   {
     setColumn(a, c, 1);
     setColumn(old_a, old_c, 0);     
     old_a = a;
     old_c = c;
     if (a == 3)
     {
        a = 0;
        if (c == 3)
        {
         c = 0;
        }
        else c++;
     }
     else a++;
  }
}


void loop()
{
  t++;
  for (int x = 0; x < 4; x++)
    for (int y = 0; y < 4; y++)
      for (int z = 0; z < 4; z++)    
      {
        if (m[x][y][z] == 1)
        
          light(x,y,z);
        reset();
        
      }
      

   if (t < 1000)
     rowEffect(t);
   else if (t == 1000)
     clear();
   else if (t < 2000)
     columnEffect(t);
   else if (t == 2000)     
     clear();
   else if (t < 3000)
     layerEffect(t);          
   else if (t == 3000)
   {
     clear();
     t = 0;
   }
}
