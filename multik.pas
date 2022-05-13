unit multik;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  Animation, BackgroundObjects, Vcl.MPlayer, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    MediaPlayer1: TMediaPlayer;
    Label1: TLabel;
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
  sHuman1,sHuman2,sHuman3,OnHillHuman,sHumanDef, cldHuman: Thuman;

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
  State, PosX, PosY:Real;
  frame:integer;
  scene: TScene;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  sHuman := THuman.DefaultTPose;
  sHuman.Update;
  sHumanDef:=THuman.DefaultTPose;
  sHUmanDef.Update;

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

  OnHillHuman := THuman.DefaultTPose;
  with OnHillHuman do
  begin
  Torso.SetAngle(Deg2Rad(-60));
  Neck.SetAngle(Deg2Rad(-50));

  LUpperarm.SetAngle(Deg2Rad(80));
  LForearm.SetAngle(Deg2Rad(-45));

  RUpperarm.SetAngle(Deg2Rad(90));
  RForearm.SetAngle(Deg2Rad(-35));

  RThigh.SetAngle(Deg2Rad(20));
  RShin.SetAngle(Deg2Rad(120));

  LThigh.SetAngle(Deg2Rad(30));
  LShin.SetAngle(Deg2Rad(135));
  end;

  cldHuman := THuman.DefaultTPose;
  with cldHuman do
  begin
  Torso.SetAngle(Deg2Rad(-90));
  Neck.SetAngle(Deg2Rad(-90));

  LUpperarm.SetAngle(Deg2Rad(120));
  LForearm.SetAngle(Deg2Rad(120));

  RUpperarm.SetAngle(Deg2Rad(70));
  RForearm.SetAngle(Deg2Rad(80));

  RThigh.SetAngle(Deg2Rad(70));
  RShin.SetAngle(Deg2Rad(90));

  LThigh.SetAngle(Deg2Rad(110));
  LShin.SetAngle(Deg2Rad(90));
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



  dSpeed:=deg2rad(1.5);
  dClose:=false;

  state:=0;
  posX:=sHuman.Transform.pos.x;
  posY:=sHuman.Transform.pos.y;


    MediaPlayer1.Close;
    MediaPlayer1.FileName := 'D:\University (~T_T)~\OAIP\otkryili-dvernoy-zamok-i-vyishli.wav';
    MediaPlayer1.Open;
    MediaPlayer1.Play;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
const
  MAX_ANGLE = -135;
begin
  // Update
  {



  if door.angle <= 0 then
  begin
    dClose:=true;
    MediaPLayer1.Pause;
  end;
  if not(dClose) then
  begin
    door.angle := door.angle - dSpeed;

  end
  else
    begin



      if posX > 450 then
      begin
         if door.angle<= deg2rad(44) then
         begin
            door.angle := door.angle + dSpeed;
            MediaPLayer1.Play;
         end;
      end;
    end;




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

    if (hill.smoothlen <= 0) then
    begin
      with drevo.Transform.pos do
      begin
      x:=x-12;
      y:=y-4.5;

      end;

    end;  }
    if (frame<30) and (door.angle>0) then
         door.angle := door.angle - dSpeed;
    if (frame = 30) then
    begin
        MediaPlayer1.Pause;
    end;

    if (frame>=60) and (frame<80)  then
    begin
         sHuman.Interpolate(sHuman,cldHuman,0.2);
    end;

    if (frame>=80) and (door.angle<=deg2rad(44)) then
    begin
         door.angle := door.angle + dSpeed;
         MediaPlayer1.Play;
        //sHuman.Interpolate(sHuman,sHumanDef,1);
    end;
    if frame=120 then
    begin
    MediaPlayer1.Close;
    MediaPlayer1.FileName := 'D:\University (~T_T)~\OAIP\snow.wav';
    MediaPlayer1.Open;
    MediaPlayer1.Play;
    end;

  if (frame>=160) and (frame<180) then
    begin
      sHuman.Interpolate(sHuman,sHumanDef,0.2);
    end;

  if (frame <60) or ((frame>120) and (posX<hill.smoothlen))  then

  begin
    state:=state+0.1;
    posx:=posx+4;
    if state > 3 then
    state := 0;

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


  end;


  if (frame = 184) then
  begin
    MediaPlayer1.Close;
  end;


  if (frame>184) and (hill.smoothlen>0) then
  begin

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
    if hill.smoothlen >= 100 then
      posx:=posx-4
    else
    begin
      sHuman.Interpolate(sHuman, OnHillHuman, 0.2 );
      if hill.smoothlen >  1  then
        posY:=posy+4;
    end;
  end;
   if frame=280 then
   begin
    MediaPlayer1.Close;
    MediaPlayer1.FileName := 'D:\University (~T_T)~\OAIP\ski_on_hill.wav';
    MediaPlayer1.Open;

   end;
   if frame=310 then
    MediaPlayer1.Play;
   if frame>320  then
   begin
      with drevo.Transform.pos do
      begin
      x:=x-12;
      y:=y-4.5;
      end;
   end;

  sHuman.Transform.pos.x:=PosX;
  sHuman.Transform.pos.y:=PosY;
  sHuman.Update;
    inc(frame);
    label1.Caption:=IntToStr(frame);

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
