unit game;

uses graphABC, glass;

type
    TGame = class
      private
        glass: TGlass;
        score: integer;
        lifes: byte;
        level: byte;
      public
        constructor Create (start_level: byte);
        procedure Start;        
        procedure WaitForStart;
    end;

constructor TGame.Create (start_level: byte);
begin
  score := 0;  
  level := start_level;
end;
  
procedure TGame.Start;
begin
  SetWindowWidth (WIDTH_GLASS);
  SetWindowHeight (HEIGHT_GLASS);

  WaitForStart;
  glass := new TGlass (0, 50);
  glass.Show;  
  glass.Move;
  
end;
   

procedure TGame.WaitForStart;
var bg: picture;
begin
  bg := new Picture ('background_title.jpg');  
  bg.Draw (0, 0, WindowWidth, WindowHeight);
  SetFontSize (40);
  setFontColor (clBlue);
  SetFontStyle (fsBoldItalic);
  SetBrushStyle (bsClear);
  brush.Color := clWhite;
  TextOut (100, 200, 'Орел-охотник');  
  SetWindowTitle ('Орел-охотник');
  setFontSize (15);  
  TextOut (80, 300, 'Для начала игры нажмите клавишу Enter');
  readln;
  ClearWindow;
  bg.Draw (0, 0, WindowWidth, WindowHeight);
  TextOut (100, 100, 'Нажимайте клавиши "Left" и "Right"'); 
  TextOut (100, 125, 'для перемещения орла влево и вправо,');
  TextOut (100, 150, 'клавишу "Space", чтобы ловить цыплят,');
  TextOut (100, 175, 'клавишу "Down", чтобы оглушить собак');
  TextOut (100, 220, 'Нажмите Enter для продолжения');
  readln;
end;
end.