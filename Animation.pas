unit multik;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  Animation, BackgroundObjects;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  TScene = array of TAnimObject;

var
  Form1: TForm1;
  pos1, pos2: THuman;
  sHuman: Thuman;
  sHuman1,sHuman2,sHuman3,sHuman4: Thuman;

  Circle: TCircle;

  drevo: TDrevo;
  House: THouse;
  door: TDoor;
  hill: THill;
  Stars:TStars;
  Moon : TMoon;

  time, dSpeed: Real;
  dClose:boolean;
  force: Real;
  State, Pos:Real;
  scene: TScene;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  sHuman := THuman.DefaultTPose;
  sHuman.Update;

  sHuman1 := THuman.DefaultTPose;
  with sHuman1 do
  begin
  Torso.SetAngle(deg2rad(-80));

  LUpperarm.SetAngle(Deg2Rad(150));
  LForearm.SetAngle(Deg2Rad(70));

  RUpperarm.SetAngle(Deg2Rad(80));
  RForearm.SetAngle(Deg2Rad(-10));

  RThigh.SetAngle(Deg2Rad(40));
  RShin.SetAngle(Deg2Rad(100));

  LThigh.SetAngle(Deg2Rad(120));
  LShin.SetAngle(Deg2Rad(130));
  end;

  sHuman2 := THuman.DefaultTPose;
  with sHuman2 do
  begin
  LUpperarm.SetAngle(Deg2Rad(80));
  LForearm.SetAngle(Deg2Rad(30));

  RUpperarm.SetAngle(Deg2Rad(100));
  RForearm.SetAngle(Deg2Rad(70));

  RThigh.SetAngle(Deg2Rad(80));
  RShin.SetAngle(Deg2Rad(95));

  LThigh.SetAngle(Deg2Rad(50));
  LShin.SetAngle(Deg2Rad(150));
  end;

  sHuman3 := THuman.DefaultTPose;
  with sHuman3 do
  begin
  Torso.SetAngle(Deg2Rad(-80));
  RUpperarm.SetAngle(Deg2Rad(150));
  RForearm.SetAngle(Deg2Rad(70));

  LUpperarm.SetAngle(Deg2Rad(80));
  LForearm.SetAngle(Deg2Rad(-10));

  LThigh.SetAngle(Deg2Rad(40));
  LShin.SetAngle(Deg2Rad(100));

  RThigh.SetAngle(Deg2Rad(120));
  RShin.SetAngle(Deg2Rad(130));
  end;
  {
    Torso := TLimb.Create(Deg2Rad(-90), cTORSO_LEN);
  Neck := TLimb.Create(Deg2Rad(-90), cNECK_LEN);

  LUpperarm := TLimb.Create(Deg2Rad(120), cARMS_LEN);
  RUpperarm := TLimb.Create(Deg2Rad(60), cARMS_LEN);
  LForearm := TLimb.Create(Deg2Rad(90), cARMS_LEN);
  RForearm := TLimb.Create(Deg2Rad(90), cARMS_LEN);

  LThigh := TLimb.Create(Deg2Rad(70), cLEGS_LEN);
  LShin := TLimb.Create(Deg2Rad(90), cLEGS_LEN);
  RThigh := TLimb.Create(Deg2Rad(110), cLEGS_LEN);
  RShin := TLimb.Create(Deg2Rad(90), cLEGS_LEN);

   h3.Torso.SetAngle(Deg2Rad(-80));
  h3.RUpperarm.SetAngle(Deg2Rad(150));
  h3.RForearm.SetAngle(Deg2Rad(70));

  h3.LUpperarm.SetAngle(Deg2Rad(80));
  h3.LForearm.SetAngle(Deg2Rad(-10));

  h3.LThigh.SetAngle(Deg2Rad(40));
  h3.LShin.SetAngle(Deg2Rad(100));

  h3.RThigh.SetAngle(Deg2Rad(120));
  h3.RShin.SetAngle(Deg2Rad(130));
  }
  drevo := TDrevo.Create;
  House := THouse.Create;
  door := TDoor.Create;
  hill := THill.Create;
  Stars := TStars.Create;
  Moon  := TMoon.Create;

  SetLength(Scene, 7);
  scene[0] := Stars;
  scene[1] := Moon;
  scene[2] := Drevo;
  scene[3] := Hill;
  scene[4] := SHuman;
  scene[5] := House;
  scene[6] := Door;


  time := 0;
  dSpeed:=deg2rad(1.5);
  dClose:=false;
  force := -2;

  state:=0;
  pos:=sHuman.Transform.pos.x;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
const
  MAX_ANGLE = -135;
begin
  // Update
  state:=state+0.1;
  pos:=pos+4;
  if state > 3 then
    state := 0;
  if door.angle <= 0 then
    dClose:=true;
  if not(dClose) then
    door.angle := door.angle - dSpeed
  else
    begin


      if pos > 450 then
      begin
         if door.angle<= deg2rad(44) then
            door.angle := door.angle + dSpeed;
      end;
    end;

    if state<1 then
          sHuman.Interpolate(sHuman, sHuman1, state)
      else
      begin
        if state < 2 then
          sHuman.Interpolate(sHuman, sHuman2, state-1)
        else
          if state < 3 then
            sHuman.Interpolate(sHuman, sHuman3, state-2);
      end;

    sHuman.Transform.pos.x:=Pos;
    sHuman.Update;

    if door.angle>=deg2rad(45) then
    begin
    if (hill.smoothlen > 0) then
      hill.smoothlen := hill.smoothlen - 4;
    with house.Transform.pos do
    begin
        x:=x-4;
    end;
    with Door do
    begin
        Transform.pos.x:=Transform.pos.x-4;
        ShadowX:=ShadowX-4;
    end;
    end;

    if (hill.smoothlen < 0) then
    begin
      with drevo.Transform.pos do
      begin
      x:=x-12;
      y:=y-4.5;

      end;

    end;

  Self.Repaint; // Call Render
end;

procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
begin
Form1.Close;
end;

procedure TForm1.FormPaint(Sender: TObject);
var
  I: Integer;
begin
  {Stars.Draw(Canvas);
  Moon.Draw(Canvas);
  drevo.Draw(PaintBox1.Canvas);
  hill.Draw(Canvas);
  House.Draw(PaintBox1.Canvas);

  door.Draw(PaintBox1.Canvas);}

  //ShowMessage('FUCK YOU');
  // Render
  for I := Low(Scene) to High(Scene) do
  begin
    Scene[I].Draw(Canvas);
  end;


end;

end.
