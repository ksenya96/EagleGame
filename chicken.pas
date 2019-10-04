unit chicken;
uses graphABC;
type TChicken = class
     private
       x, y: integer;
       p: picture;
       dir: integer;   
     public
       constructor Create (x0, y0: integer);
       function Direction: char;
       procedure Show;       
       procedure Move;   
       procedure Up;
       function getX: integer;
       function getY: integer;
     end;
const
     WIDTH_CHICKEN = 50;
     HEIGHT_CHICKEN = 50;
     
constructor TChicken.Create (x0, y0: integer); 
begin
  x := x0;
  y := y0;
  dir := random (2);
  p := new Picture ('chicken.gif');  
  
end;

//направление движения цыпленка 
function TChicken.Direction: char;
var d: char;    
    a: integer;
begin  
  a := random (1, WindowWidth - 1);
  if (x = 0) or (x = WindowWidth - WIDTH_CHICKEN) or (x = a) then
    begin
      dir := abs (dir - 1);
      
    end;
  case dir of
    0: d := 'L';
    1: d := 'R';
  end;
  Direction := d;
end;

//показать цыпленка
procedure TChicken.Show;
begin 
  
  p.Draw (x, y, WIDTH_CHICKEN, HEIGHT_CHICKEN); 

end;


//движение цыпленка
procedure TChicken.Move;
begin    
  case Direction of
    'L': x := x - 1;
    'R': x := x + 1;   
  end;
  Show; 
end;

procedure TChicken.Up;
begin
  y := y - 3;
  Show;  
end;

function TChicken.getX: integer;
begin
  getX := x;
end;

function TChicken.getY: integer;
begin
  getY := y;
end;

   
end.