#define SIZE 4
#define PLANE_XY 1
#define PLANE_XZ 2
#define PLANE_YZ 3

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
int a = 0, old_a = 0, dir_a = 1;
int b = 0, old_b = 0, dir_b = 1;
int c = 0, old_c = 0, dir_c = 1;

int _time = 0;
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
  Serial.begin(9600);
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

void layerEffect(int delay = 5)
{
   if (_time % delay == 0)
   {
     setLayer(b, 1);
     setLayer(old_b, 0);     
     old_b = b;
     if ((b == 3 && dir_b == 1) || (b == 0 && dir_b == -1))
       dir_b *= -1;
     b += dir_b;
  }
}

void rowEffect(int delay = 5)
{
   if (_time % delay == 0)
   {
     setRow(a, b, 1);
     setRow(old_a, old_b, 0);     
     old_b = b;   
     old_a = a;
     if ((b == 3 && dir_b == 1) || (b == 0 && dir_b == -1))
     {
       dir_b *= -1;
       if ((a == 3 && dir_a == 1) || (a == 0 && dir_a == -1))
         dir_a *= -1;
       else a += dir_a;
     }
     else b += dir_b;
  }
}

void columnEffect(int delay = 5)
{
   if (_time % delay == 0)
   {
     setColumn(a, c, 1);
     setColumn(old_a, old_c, 0);     
     old_c = c;   
     old_a = a;
     if ((c == 3 && dir_c == 1) || (c == 0 && dir_c == -1))
     {
       dir_c *= -1;
       if ((a == 3 && dir_a == 1) || (a == 0 && dir_a == -1))
         dir_a *= -1;
       else a += dir_a;
     }
     else c += dir_c;
  }
}

void rainEffect(int delay, int count = 3)
{
	if (_time % delay == 0)
	{
		for (int x = 0; x < SIZE; x++)
			for (int y = 0; y < SIZE; y++)
				for (int z = 0; z < SIZE; z++)
				{
					m[x][y][z] = (y == SIZE - 1) ? 0 : m[x][y + 1][z];
				}
		for (int c = 0; c < count; c++)
		{
			int size = 1 + rand() % 2;
			int pos[2];
			pos[0] = rand() % SIZE;
			pos[1] = rand() % SIZE;
			for (int t = 0; t <= size; t++)
			m[pos[0]][SIZE - 1 - t][pos[1]] = 1;
		}
	}
}

void planeEffect(int type, int delay)
{
  if (type == PLANE_XZ)
    layerEffect(delay);
    if (type == PLANE_XY)
      if (_time % delay == 0)
      {
        old_a = a;
	a += dir_a;
	if (a == SIZE - 1 || a == 0)
	dir_a *= -1;
	for (int t = 0; t < SIZE; t++)
	{
	  setColumn(a, t, 1);
	  setColumn(old_a, t, 0);
	}
    }
    if (type == PLANE_YZ)
      if (_time % delay == 0)
        {
	  old_a = a;
	  a += dir_a;
	  if (a == SIZE - 1 || a == 0)
	  dir_a *= -1;
	  for (int t = 0; t < SIZE; t++)
	  {
	    setColumn(t, a, 1);
	    setColumn(t, old_a, 0);
	  }
        }		
}


void loop()
{
  _time++;
  for (int x = 0; x < 4; x++)
    for (int y = 0; y < 4; y++)
      for (int z = 0; z < 4; z++)    
      {
        if (m[x][y][z] == 1)
        
          light(x,y,z);
        reset();
        
      }
      
	if (_time < 300)
		planeEffect(PLANE_XY, 2);
	else if (_time == 300)
		clear();
	else if (_time < 600)		
		planeEffect(PLANE_XZ, 2);
	else if (_time == 600)
		clear();		
	else if (_time < 900)				
		planeEffect(PLANE_YZ, 2);		
	else if (_time == 900)
		clear();		
}
