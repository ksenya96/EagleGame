unit eagle;
uses graphABC;
type 
   TDirection = (LEFT, RIGHT, UP, DOWN);
   TEagle = class
     private
       x, y: integer;
       p: picture;
       direction: TDirection;
     public
       constructor Create (x0, y0: integer);
       procedure setDirection (dir: TDirection);
       procedure Show;       
       procedure Move;
       function getX: integer;
       function getY: integer;
     end;
const
     WIDTH_EAGLE = 200;
     HEIGHT_EAGLE = 125;
     
constructor TEagle.Create (x0, y0: integer); 
begin
  x := x0;
  y := y0;
end;

//направление движения орла 
procedure TEagle.setDirection (dir: TDirection);
begin
  direction := dir;
end;

//показать орла
procedure TEagle.Show;
begin   
  p := new Picture ('eagle.gif');
  p.Draw (x, y, WIDTH_EAGLE, HEIGHT_EAGLE); 
end;

//движение орла
procedure TEagle.Move;
begin   
  case direction of
    LEFT: if x > 0 then
            x := x - 3;
    RIGHT: if x + WIDTH_EAGLE < WindowWidth then
             x := x + 3;
    UP: y := y - 3;
    DOWN: y := y + 3;
  end;   
end;

  
function TEagle.getX: integer;
begin
  getX := x;
end;

function TEagle.getY: integer;
begin
   getY := y;
end;

end.