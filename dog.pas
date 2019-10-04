unit dog;
uses graphABC;
type TDog = class
     private
       x, y: integer;
       p: picture;
       dir: integer;
     public
       constructor Create (x0, y0: integer);
       function Direction: char;
       procedure Show;       
       procedure Move;    
       function getX: integer; 
       function getY: integer;
     end;
const
     WIDTH_DOG = 100;
     HEIGHT_DOG = 100;
     
constructor TDog.Create (x0, y0: integer); 
begin
  x := x0;
  y := y0;
  dir := random (2);
  
end;

//направление движения собаки 
function TDog.Direction: char;
var d: char;
    a: integer;
begin
  a := random (1, 799);
  if (x = 0) or (x = WindowWidth - WIDTH_DOG) or (x = a) then
    dir := abs (dir - 1);
  case dir of
    0: d := 'L';
    1: d := 'R';
  end;
  Direction := d;
end;

//показать собаку
procedure TDog.Show;
begin
  case dir  of
    0: p := new Picture ('dogLeft.gif');
    1: p := new Picture ('dogRight.gif');
  end;    
  p.Draw (x, y, WIDTH_DOG, HEIGHT_DOG); 
  
end;

//движение собаки
procedure TDog.Move;
begin  
  case Direction of
    'L': x := x - 1;
    'R': x := x + 1;
  end;
  Show;  
end;

function TDog.getX: integer;
begin
  getX := x;
end;

function TDog.getY: integer;
begin
  getY := y;
end;
 
end.