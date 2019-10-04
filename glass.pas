unit glass;
uses graphABC, dog, eagle, chicken;
const 
     SQUARE_SIZE = 100;
     WIDTH_GLASS = 600;
     HEIGHT_GLASS = 500;
     
type
    TMap = array [0..5, 0..7] of byte;
    TGlass = class
      private
        x, y: integer;
        d: array [1..6] of TDog;
        e: TEagle;
        c: array [1..6] of TChicken;
        map: TMap;
        d_kol, c_kol: byte;
        found_chicken: array [1..6] of boolean;
        found_dog: array [1..6] of boolean;
        p: picture;
        catch: boolean;
        score, lifes: integer;
        image_chicken, image_eagle, image_dog1, image_dog2: picture;
        x_dog: integer;
        stone_fall: boolean;
        //DogIsFalse: boolean;
      public
        constructor Create (x0, y0: integer);
        procedure Show;
        procedure Move;
        procedure KeyDown (Key: integer);
        procedure PutBlockScore;
        procedure PutBlockLifes;
        procedure PutBlockDog;
        procedure GameOver;
    end;
    
constructor TGlass.Create (x0, y0: integer);
var i: byte;
begin
  x := x0;
  y := y0;
  d_kol := 3;
  c_kol := 5;
  e := new TEagle ((WIDTH_GLASS - WIDTH_EAGLE) div 2, y0);  
  for i := 1 to c_kol do
    found_chicken [i] := false;
  for i := 1 to d_kol do
    found_dog [i] := false;
  p := new Picture ('background.jpg');
  catch := false;
  score := 0;
  lifes := 5; 
  image_chicken := new Picture ('chicken.gif');
  image_eagle := new Picture ('eagle.gif');
  image_dog1 := new Picture ('dog1.gif');
  image_dog2 := new Picture ('dog2.gif');  
  stone_fall := false;
  
end;

//создание собак и цыпл€т
procedure TGlass.Show;
var i: byte;
begin
  for i := 1 to d_kol do    
      d[i] := new TDog (random (501), HEIGHT_GLASS - HEIGHT_DOG + 5);      
  for i := 1 to c_kol do    
      c[i] := new TChicken (random (551), HEIGHT_GLASS - HEIGHT_CHICKEN);          
end;


procedure TGlass.Move;
var  j, k, l: integer;
     a: array [1..6] of integer;
     star: picture;
begin
  k := 0;
  l := 0;
  for j := 1 to d_kol do
    a [j] := random (x, WIDTH_GLASS - 1);
  star := new Picture ('star.gif');
  LockDrawing;  
  while lifes > 0  do
    begin      
      ClearWindow;        
      p.Draw (0, 0, WIDTH_GLASS, HEIGHT_GLASS);
      PutBlockScore;
      PutBlockLifes;
      PutBlockDog;
      OnKeyDown := KeyDown; 
      //redraw;
      //если собака не оглушен, то показываем его, иначе останавливаем      
      for j := 1 to d_kol do
        if (not found_dog [j]) then  
          if d[j].getX <> a [j] then
            d[j].Move
          else
              if l <= 300 then
                begin
                  d[j].Show;                 
                  inc (l);                  
                end
              else
                begin
                  l := 0;
                  a [j] := random (1, 799);
                end
        else          
            if k <= 300 then
              begin
                d[j].Show;
                star.Draw (d[j].getX, d[j].getY - 10, 20, 20);
                star.Draw (d[j].getX + 20, d[j].getY - 30, 20, 20);
                star.Draw (d[j].getX, d[j].getY + 10, 20, 20);
                star.Draw (d[j].getX + 50, d[j].getY - 30, 20, 20);     
                star.Draw (d[j].getX + 60, d[j].getY - 10, 20, 20);                 
                inc (k);
                //DogIsFalse := true;
                  {if x_dog = 0 then
                    TextOut (57, 200, 'Auch!')
                  else
                    TextOut (540 - 160, 200, 'Auch!');}
              end
            else
              begin
                k := 0;
                found_dog [j] := false;
              end;
              
      //если цыпленок не пойман, то показываем его
      for j := 1 to c_kol do
        if (not found_chicken [j]) then
          c[j].Move;        
      e.Show;
      redraw;     
      //sleep (10);       
    end;
  PutBlockScore;
  PutBlockLifes;
  GameOver;
  //redraw;
end;

procedure TGlass.KeyDown (Key: integer);
var fix_y, y0, x0, y_stone, x_stone: integer;
    i, k, j: byte;
    stone: picture;
begin   
   case Key of
     VK_Left: e.SetDirection (LEFT);
                 
     VK_Right: e.SetDirection (RIGHT);
                                 
     VK_Space: begin   
                 //орел опускаетс€ вниз
                 fix_y := e.getY;        
                 y0 := HEIGHT_GLASS - HEIGHT_CHICKEN + 40;
                 while (e.getY + HEIGHT_EAGLE < y0) do
                   begin
                     e.SetDirection (DOWN);
                     e.Move;                      
                     sleep (20);
                   end;
                                 
                 //проверка столкновени€ орла и собак                                 
                 for i := 1 to d_kol do
                   if (e.getX + WIDTH_EAGLE div 2 in [d[i].getX..d[i].getX + WIDTH_DOG]) and 
                       (not found_dog [i])then
                     begin                       
                       catch := true;                                                                        
                       dec (lifes);
                     end;
                   //else
                       //catch := false;
                 
                 //проверка столкновени€ орла и цыпл€т                 
                 x0 := e.getX + WIDTH_EAGLE div 2 - 23;
                 for i := 1 to c_kol do
                   if (c[i].getX + WIDTH_CHICKEN div 2  in [x0..x0 + 46]) and (not catch) then
                     begin                       
                       found_chicken [i] := true;
                       stone_fall := true;
                       inc (score);
                     end;                   
                                  
                 //орел поднимаетс€ вверх, если пойман цыпленок, то он поднимаетс€ вверх
                 while e.getY > fix_y do
                   begin      
                     //SetFontSize (20);
                     if (catch) then
                        if (x_dog = 0) {and (not DogIsFalse)} then
                           TextOut (55, 200, 'Yes!')
                        else
                          {if (not DogIsFalse) then}
                            TextOut (540 - 115, 200, 'Yes!');
                     for i := 1 to c_kol do
                        if  (found_chicken [i]) then
                          begin
                            c[i].Up;
                            if (x_dog = 0) {and (not DogIsFalse)} then
                              TextOut (57, 200, 'No!')
                            else
                              {if (not DogIsFalse) then}
                                TextOut (540 - 90, 200, 'No!')
                          end;
                     e.setDirection (UP);
                     e.Move;                          
                     sleep (20);
                   end; 
                 
                 //удаление пойманных цыпл€т
                 k := 0;
                 for i := 1 to c_kol do
                    if found_chicken [i] then
                       begin
                         inc (k);
                         if k mod 2 <> 0 then
                            c[i] := new TChicken (1, HEIGHT_GLASS - HEIGHT_CHICKEN)
                         else
                           c[i] := new TChicken (WindowWidth - WIDTH_CHICKEN - 1, HEIGHT_GLASS - HEIGHT_CHICKEN);
                         found_chicken [i] := false;
                         sleep (20);
                       end;    
                 catch := false;
               end;
               
     VK_Down: begin
                if stone_fall then
                   begin
                      stone := new Picture ('stone.gif');
                      y_stone := e.getY + HEIGHT_EAGLE div 2;
                      x_stone := e.getX + WIDTH_EAGLE div 2 - 25;
                      stone.Draw (x_stone, y_stone, 50, 50);
                      y0 := HEIGHT_GLASS - HEIGHT_DOG;              
                      redraw;
                      //падение камн€
                       while (y_stone < y0) do
                         begin
                           y_stone := y_stone + 5;
                           stone.Draw (x_stone, y_stone, 50, 50);
                           sleep (20);
                         end;
                       //redraw;
                         
                       //проверка столкновени€ камн€ и собак
                       for i := 1 to d_kol do
                         if (x_stone  in [d[i].getX..d[i].getX + WIDTH_DOG]) then
                           begin    
                             //writeln ('ѕопал');
                             found_dog [i] := true;  
                             for j := 1 to 80 do
                               begin
                                 if x_dog = 0 then
                                   TextOut (57, 200, 'Auch!')
                                 else
                                  TextOut (540 - 160, 200, 'Auch!');
                                 sleep (20);
                               end;
                      
                           end;
                       
                      stone_fall := false;
                    end;
                       
             end;
   end;
  
   if key in [VK_Left, VK_Right] then     
       e.Move;  
 
end;

procedure TGlass.PutBlockScore;
begin  
  image_chicken.Draw (450, 0, 50, 50);
  SetFontSize (40);
  TextOut (500, 0, IntToStr (score));
end;

procedure TGlass.PutBlockLifes;
begin  
  image_eagle.Draw (0, 0, 120, 80);
  SetFontSize (40);
  if lifes < 0 then
    lifes := 0;
  TextOut (120, 0, IntToStr (lifes));
  line (0, 60, WindowWidth, 60);
end;

procedure TGlass.PutBlockDog;
begin  
  if e.getX <= (WIDTH_GLASS - WIDTH_EAGLE) div 2 then
    begin
      image_dog2.Draw (540, 200, 60, 60);
      x_dog := 540;
    end    
  else
    begin
      image_dog1.Draw (0, 200, 60, 60);
      x_dog := 0;
    end;
end;

procedure TGlass.GameOver;
begin
  SetFontSize (30);
  Window.Clear;
  p.Draw (0, 0, WIDTH_GLASS, HEIGHT_GLASS);
  if lifes <= 0 then
    TextOut (50, 50, ' онец игры');
    TextOut (50, 120, '¬аш счет: ');
    TextOut (350, 120, IntToStr (score));
  redraw;
end;

end.