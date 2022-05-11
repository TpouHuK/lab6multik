unit BackgroundObjects;

interface

uses Animation, Vcl.Graphics, System.Types;

type
  Tdrevo = class(TAnimObject)
    procedure Draw(Canvas: TCanvas); override;
    constructor Create;
  end;

  THouse = class(TAnimObject)
    procedure Draw(Canvas: TCanvas); override;
    Constructor Create;
  end;

  TDoor = class(TAnimObject)
    angle: real;
    lenX, lenY: real;
    shadowX, shadowY: real;
    procedure Draw(Canvas: TCanvas); override;
    procedure SetDoorAngle(angle: real);
    Constructor Create;
  end;
  Thill = class(TAnimObject)
    smoothlen: real;
    procedure Draw (Canvas: TCanvas);  override;
    Constructor Create;
          end;
   TStars = class(TAnimObject)
    ArrayCoordinate: array [1 .. 150, 1 .. 2] of integer;
    procedure Draw(Canvas: Tcanvas);  override;
    Constructor Create;
           end;
   TMoon = class(TAnimObject)
    procedure Draw(Canvas:TCanvas); override;
    Constructor Create;
               end;

implementation

constructor Tdrevo.Create;
const
  DEFAULT_X = 900;
  DEFAULT_Y = 450;
begin
  Transform := TTransform.Create(TPos.Create(DEFAULT_X, DEFAULT_Y), deg2rad(0), 1);
end;


procedure Tdrevo.Draw(Canvas: TCanvas);
const
     TreeLenX=100;
     TreeLenY=175;
     Height=40;
procedure DrawSnow(Canvas: TCanvas);
const
    SegSize=50;
     // coordinates of line to cut segment
     DeltaX=2;
     DeltaY=6;
     clSnow=$FFFFE0;
var
  SegmentSize: real;
  LenX, LenY:real;
  LineX,LineY:real;
begin
     SegmentSize:=segSize*Transform.scale;
     LenX:=TreeLenX*Transform.scale/2;
     LenY:=TreeLenY*Transform.scale/2;
     //need to count segment
     LineX:=DeltaX*Transform.scale;
     LineY:=DeltaY*Transform.scale;
     with Canvas do
     begin
          with Transform.pos do
          begin
          Brush.Color := clSnow;
          Pen.Color := clWhite;
          Pen.Width:= Trunc(Transform.scale);

          Chord(trunc(x-LenX/2), trunc(y+LineY), trunc(x+LenX/2), trunc(y+LenY*0.5),
                trunc(x-lenx/2-LineX*2),trunc(y+leny*0.4), trunc(x+Lenx/2+LineX*2),trunc(y+leny*0.4));
          Polygon([point(trunc(x),trunc(y)), point(trunc(x+Lenx/2-LineX),trunc(y+leny*0.4-LineY*0.5)), point(trunc(x-lenx/2+LineX),trunc(y+leny*0.4-LineY*0.5))]);

          Pen.Color := clBlack;
          Pen.Width:=1;
          end;
     end;
end;


var
   LenX,LenY:real;  //size of huge triangle
   RectX,RectY:real;//stvol size rectx = len/2
   high:real;


begin
      with Transform.Pos do
      begin
     //RotateScale(x,y, scale, rotation);
     LenX:=TreeLenX*Transform.scale;
     LenY:=TreeLenY*Transform.scale;
     //Stvol
     RectX:=0.6*LenX/2;
     RectY:=1.25*LenY;
     //
     high:=Height*Transform.scale;
     with Canvas do
     begin
     Brush.Color:=$2D52A0;
     Rectangle(trunc(x-RectX),trunc(y+LenX), trunc(x+RectX), trunc(y+RectY));


     Brush.Color:=clGreen;
    Polygon([point(trunc(x),trunc(y+high)), point(trunc(x+Lenx),trunc(y+LenY)), point(trunc(x-LenX),trunc(y+LenY))]);  //90 175
    Polygon([point(trunc(x),trunc(y+high / 2)), point(trunc(x+3/4*LenX),trunc(y+LenY*0.7)), point(trunc(x-3/4*LenX),trunc(y+LenY*0.7))]);//75 125
    Polygon([point(trunc(x),trunc(y)), point(trunc(x+Lenx/2),trunc(y+leny*0.4)), point(trunc(x-lenx/2),trunc(y+leny*0.4))]);     // 50 75
    DrawSnow(Canvas);
      if y<0 then
      begin
          x:=800;
          y:=400;
      end;
    end;
    end;
end;

constructor THouse.Create;
const
  DEFAULT_X = 0;
  DEFAULT_Y = 200;
begin
  Transform := TTransform.Create(TPos.Create(DEFAULT_X, DEFAULT_Y),deg2rad(0),1);
end;

procedure THouse.Draw(Canvas: TCanvas);
var
  curPos: real;
  i: integer;
const
  BrownColor = $3F85CD;
  H = 600;
  W = 800;

  HouseLenX = 3 * W / 8;
  HouseLeny = H / 3;
  PlankSize = W / 20;
  ChimneyX = W / 80;
  ChimneyY = H / 20;
  RoofX = W / 4;
  RoofY = H / 6 + H / 12;
  WinX1 = W / 12;
  WinX2 = 3 * W / 10;
  WinY1 = H / 13;
  WinY2 = H / 4;


begin

  with Canvas do
    with Transform.pos do
    begin
      // FRONT WALL
      Brush.Color := BrownColor;
      Rectangle(trunc(Transform.pos.x), trunc(Transform.pos.y),
        trunc(Transform.pos.x + HouseLenX), trunc(Transform.pos.y + HouseLeny));

      curPos := (HouseLeny / 5);
      for i := 1 to 4 do // Front planks
      begin
        MoveTo(trunc(x), trunc(y + curPos));
        LineTo(trunc(x + HouseLenX), trunc(y + curPos));
        curPos := curPos + PlankSize;
      end;

      // RIGHT WALL
      Polygon([point(trunc(x + HouseLenX), trunc(y)),
        point(trunc(x + HouseLenX), trunc(y + HouseLeny)),
        point(trunc(x + HouseLenX + HouseLenX / 3), trunc(y + HouseLeny / 2)),
        point(trunc(x + HouseLenX + HouseLenX / 3), trunc(y - HouseLeny / 2))]);
      curPos := PlankSize;

      for i := 1 to 4 do
      begin
        MoveTo(trunc(x + HouseLenX), trunc(y + curPos));
        LineTo(trunc(x + HouseLenX + HouseLenX / 3),
          trunc(y - HouseLeny / 2 + curPos));
        curPos := curPos + PlankSize;
      end;


      Brush.Color := clMaroon;

      // CHIMNEY
      Rectangle(trunc(x + 8 * ChimneyX), trunc(y - 4 * ChimneyY),
        trunc(x + 13 * ChimneyX), trunc(y));
      Polygon([point(trunc(x + 13 * ChimneyX), trunc(y)),
        point(trunc(x + 13 * ChimneyX), trunc(y - 4 * ChimneyY)),
        point(trunc(x + 16 * ChimneyX), trunc(y - 4.7 * ChimneyY)),
        point(trunc(x + 16 * ChimneyX), trunc(y - ChimneyY))]);
      Polygon([point(trunc(x + 8 * ChimneyX), trunc(y - 4 * ChimneyY)),
        point(trunc(x + 13 * ChimneyX), trunc(y - 4 * ChimneyY)),
        point(trunc(x + 16 * ChimneyX), trunc(y - 4.7 * ChimneyY)),
        point(trunc(x + 11.2 * ChimneyX), trunc(y - 4.7 * ChimneyY))]);

      // FRONT ROOF
      Polygon([point(trunc(x), trunc(y)), point(trunc(x + HouseLenX), trunc(y)),
        point(trunc(x + RoofX), trunc(y - RoofY))]);
      // RIGHT ROOF
      Polygon([point(trunc(x + HouseLenX), trunc(y)),
        point(trunc(x + 2 * RoofX), trunc(y - 2 / 3 * RoofY)),
        point(trunc(x + RoofX), trunc(y - RoofY))]);

      // WINDOW
      Brush.Color := clAqua;
      Pen.Width := 5;

      Rectangle(trunc(x + WinX1), trunc(y + WinY1), trunc(x + WinX2),
        trunc(y + WinY2));
      MoveTo(trunc(x + (WinX1 + WinX2) / 2), trunc(y + WinY1) + 3);
      LineTo(trunc(x + (WinX1 + WinX2) / 2), trunc(y + WinY2) - 3);
      MoveTo(trunc(x + WinX1) + 3, trunc(y + (WinY1 + WinY2) / 2));
      LineTo(trunc(x + WinX2) - 3, trunc(y + (WinY1 + WinY2) / 2));
      Pen.Width := 1;
    end;
end;

constructor TDoor.Create;
const
  DEFAULT_X = 335;
  DEFAULT_Y = 215;
  DOOR_LENX = 75;
  DOOR_LENY = 150;
  DOOR_START_ANGLE = 45;


begin
  Transform.Create(TPos.Create(DEFAULT_X, DEFAULT_Y), deg2rad(0), 1);
  lenX := DOOR_LENX*Transform.scale;
  lenY := DOOR_LENY*Transform.scale;
  shadowX:=DEFAULT_X;
  ShadowY:=DEFAULT_Y;
  angle := deg2rad(DOOR_START_ANGLE);
end;

procedure TDoor.Draw(Canvas: TCanvas);
const
  num_of_lines = 5;
  clBrown = $13458B;

  DOOR_START_ANGLE = 45;
var
  i, curPos: integer;
  plunkSize: real;
  Mid: real;
  Door_LENX,Door_LENY:real;
  // num_of_lines:integer;
begin

  with Canvas do
    with Transform.pos do
    begin

    // Door shadow
      Door_LENX:=Lenx;
      DOOR_LENY:=LenY;
      Brush.Color := clGray;
      Polygon([point(trunc(ShadowX), trunc(ShadowY)), point(trunc(ShadowX), trunc(ShadowY + DOOR_LENY)),
        point(trunc((ShadowX + DOOR_LENX * cos(deg2rad(DOOR_START_ANGLE)))), trunc(ShadowY + DOOR_LENY - DOOR_LENX * sin(deg2rad(DOOR_START_ANGLE))
        )), point(trunc((ShadowX + DOOR_LENX * cos(deg2rad(DOOR_START_ANGLE)))),
        trunc(ShadowY - DOOR_LENX * sin(deg2rad(DOOR_START_ANGLE))))]);


      Brush.Color := clBrown;
      // Polygon ([ point(trunc(x),trunc(y)), point(trunc(x), trunc(y+LenY)), point(trunc((x+LEnX)*Rotation),trunc((y+LenY)*Rotation-Rotation*28)), point(trunc( (x+LEnX)*Rotation), trunc((y)*Rotation-Rotation*32))]);
      Polygon([point(trunc(x), trunc(y)), point(trunc(x), trunc(y + lenY)),
        point(trunc((x + lenX * cos(angle))), trunc(y + lenY - lenX * sin(angle)
        )), point(trunc((x + lenX * cos(angle))),
        trunc(y - lenX * sin(angle)))]);
      curPos := round(lenX / num_of_lines * cos(angle));
      plunkSize := round(lenX / num_of_lines * sin(angle));
      for i := 1 to num_of_lines - 1 do
      begin
        MoveTo(trunc(x + curPos), trunc(y - plunkSize));
        LineTo(trunc(x + curPos), trunc((y + lenY - plunkSize)));
        curPos := curPos + trunc(lenX / num_of_lines * cos(angle));
        plunkSize := curPos * sin(angle) / cos(angle);
      end;

      Mid := (trunc(y + lenY - lenX * sin(angle)) + trunc(y - lenX * sin(angle))
        ) / 2; // y0-y1/2
      Brush.Color := clYEllow;
      Ellipse(trunc(x + 5 * curPos / 6), trunc(Mid * 1.02), trunc(x + curPos),
        trunc(Mid * 1.06));
    end;
end;

procedure TDoor.SetDoorAngle(angle: real);
begin
  Self.angle := deg2rad(angle);
end;

constructor THill.Create;
Const
  FormSizeW = 800;
  FormSizeH = 600;
begin
    //x:=FormSizeW;
    //y:=FormSizeW;
    Transform := TTransform.Create(TPos.Create(FormSizeW, FormSizeH));
    smoothlen:=3*FormSizeW/4;
end;

procedure THill.Draw(Canvas: TCanvas);
const
     clSnow=$FFFFE0;
begin
     with Canvas do
     begin
     Brush.Color:=clSnow;
     with Transform.pos do
     begin
     Polygon([point(0,round(y/2)), point(trunc(smoothlen), trunc(y/2)), point(trunc(x+smoothlen), trunc(y)), point(0, trunc(y)), point(0, trunc(y/2))]);
     end;
     end;
end;

Constructor TStars.Create;
Const
     FormSizeW = 800;
     FormSizeH = 600;
Var
  i: integer;
begin
  Transform := TTransform.Create(TPos.Create(FormSizeW/2, FormSizeH/2));
  for i := Low(ArrayCoordinate) to High(ArrayCoordinate) do
  begin
    ArrayCoordinate[i, 1] := trunc(FormSizeW  div 2) + Random(FormSizeW) -
      Random(FormSizeW);
    ArrayCoordinate[i, 2] := trunc(FormSizeH div 2) + Random(FormSizeH) -
      Random(FormSizeH);
  end;

end;

procedure TStars.Draw(Canvas: TCanvas);
const
     color1=$FFFFFF;
     color2=$829DFF;
     color3=$FFFDE3;
     color4=$D3FAFF;
     SkyColor=$3D0A12;
Var
  i, h, p, j: integer;
begin
  with Canvas do
  begin
    Brush.Color:=SkyColor;
    rectangle(0,0, trunc(Transform.pos.x*2), trunc(Transform.Pos.y*2));
    for i := Low(ArrayCoordinate) to High(ArrayCoordinate) do
    begin
        h := Random(5);
      case h of
        0:
          Pixels[ArrayCoordinate[i, 1], ArrayCoordinate[i, 2]] := clWhite;
        1:
          Pixels[ArrayCoordinate[i, 1], ArrayCoordinate[i, 2]]  := color1;
        2:
          Pixels[ArrayCoordinate[i, 1], ArrayCoordinate[i, 2]]  := color2;
        3:
          Pixels[ArrayCoordinate[i, 1], ArrayCoordinate[i, 2]]  := color3;
        4:
          Pixels[ArrayCoordinate[i, 1], ArrayCoordinate[i, 2]]  := color4;
      end;
    end;
  end;

end;



Constructor TMoon.Create;
Const
     DEFAULT_X = 800-100;
     DEFAULT_Y = 600-525;
begin

  Transform := TTransform.Create(TPos.Create(DEFAULT_X, DEFAULT_Y), deg2rad(0), 1);

end;

procedure TMoon.Draw(Canvas: TCanvas);
Const
  MOONLIGHT = $3D0A12;
  clWhite= $F0FFFF;
  Radius=50;
Var
  i, h: integer;
  R:real;
begin
  R:=radius*Transform.scale;
  with Transform.pos do
  begin
  with Canvas do
  begin
    Pen.Color := clWhite;
    Brush.Color := clWhite;
    Ellipse(trunc(x - R), trunc(y - R), trunc(x + R), trunc(y + R));
    Pen.Color := MOONLIGHT;

    Brush.Color := MOONLIGHT;
    Ellipse(trunc(x - 3/2*R), trunc(y - R), trunc(x + R/2), trunc(y + R));


  end;
  end;
end;
end.
