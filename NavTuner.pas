unit NavTuner;

//  Copyright (c) 2024 Pat Foley

// License MIT

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.ComCtrls, Vcl.Forms, Vcl.ExtCtrls,
     Vcl.Dialogs, Vcl.StdCtrls, TwoHeadTypes;
const
  // give the scalers bigger scale factors
  // round 10/11  or round
  // was 1_000 952
  Biggly = 96 * 11 - 96 div 2;   //1.05 ISH
  Smaller = 96 * 10;

type
  TSideBar = class(TForm)
    GroupBox1: TGroupBox;
    Grow: TButton;
    Hnd_sizeof: TButton;
    ListBox1: TListBox;
    Sel_Show: TButton;
    Shrink: TButton;
    memoShowMessages: TMemo;
    Splitter1: TSplitter;
    Button1: TButton;
    Label1: TLabel;
    btnRunStop: TButton;
    Button2: TButton;
    TaskTimer: TTimer;
    procedure btnRunStopClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure GrowClick(Sender: TObject);
    procedure Hnd_sizeofClick(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure Sel_ShowClick(Sender: TObject);
    procedure ShrinkClick(Sender: TObject);
  private
//    FForm: TForm;
    FOnUpdateRemoteTask: TNotifyEvent;
    procedure TaskTimerTimer(Sender: TObject);
  protected
    procedure UpdateRemoteTask;
  public
    procedure SwitchApp(const Cmd: TDualCommand);
    procedure MemoAdd(const inString: string);
    procedure UpdateListUI(Sender: TObject);
  published
    property OnUpdateRemoteTask: TNotifyEvent read FOnUpdateRemoteTask write FOnUpdateRemoteTask;
  end;


implementation

{$R *.dfm}

procedure TSideBar.btnRunStopClick(Sender: TObject);
begin
  TaskTimer.Enabled := not TaskTimer.Enabled;
  TaskTimer.OnTimer := TaskTimerTimer;
  var s := 'Run';
  if TaskTimer.Enabled then s := 'Stop';
  btnRunStop.Caption := s;
end;

procedure TSideBar.Button1Click(Sender: TObject);
begin
  SwitchApp(dcShowDT1);
end;

procedure TSideBar.Button2Click(Sender: TObject);
begin
  SwitchApp(dcShowDT2);
end;

procedure TSideBar.GrowClick(Sender: TObject);
var
  F: TForm;
begin
  if Parent = nil then
    F := TForm(ListBox1.Items.Objects[ListBox1.ItemIndex])
  else
    begin
      F := Screen.Forms[0];
      Self.ScaleBy(Smaller,Biggly);
    end;

  F.ScaleBy(Biggly,Smaller);
  //F.ChangeScale(120,96,True); //No worky
end;

procedure TSideBar.Hnd_sizeofClick(Sender: TObject);
begin
  MemoAdd((Sizeof(HWND)*8).ToString + 'bit');
end;

procedure TSideBar.ListBox1DblClick(Sender: TObject);
var
  F: TForm;
begin
  var
  LB := ListBox1;
  memoAdd(format('Out of %d showing indexed %d', [LB.items.count, Lb.ItemIndex]));
  F := TForm(LB.Items.Objects[LB.ItemIndex]);
  if F = nil then
    Exit;

  If F.WindowState = TWindowState.wsMinimized then
    F.WindowState := wsNormal;
  F.BringToFront;
  F.Show;
end;

procedure TSideBar.SwitchApp(const Cmd: TDualCommand);
//var h2, h3, h4: HWND;
var
  FN: string;
begin
  //  https://stackoverflow.com/questions/1187487/how-to-access-delphi-function-at-dpr-scope
  //FN := Screen.Forms[ListBox1.ItemIndex].Caption;
///  FForm := TForm(ListBox1.Items.Objects[findex]);
//  if pos('.', FForm.Caption) < 1 then
//  FN:= '';
  FN := 'Dummy.Txt';//  ParamStr(1); change under run set params
  //LoaderVar(h2, h3, h4,{ Handle,} FN, Cmd);
  TYenYang.urLoader1(DT1winclassname, DT2winclassname, FN, Cmd);
end;

procedure TSideBar.MemoAdd(const inString: string);
begin
  memoShowMessages.Lines.Add( Format('h%2.3f %s',[Time * 24, inString]) );
end;

procedure TSideBar.Sel_ShowClick(Sender: TObject);
var
  F: TForm;
  LB: TListBox;
begin
  //get object instance unsure why a -1 can happen when items are listed
  //it happens when list is clicked over an area where the text of an item is not--
  //therefore no item gets selected!
  LB := ListBox1;
  if LB.ItemIndex = -1 then
  begin
    memoadd('Ouch better luck next time :)');
    memoadd('It does that--try again');
    memoadd('the item becomes selected when it''s background is blue');
    Exit;
  end;
  F := TForm(LB.Items.Objects[LB.ItemIndex]);
  if F = nil then
    Exit;

  If F.WindowState = TWindowState.wsMinimized then
    F.WindowState := wsNormal;
  F.Show;
end;

procedure TSideBar.ShrinkClick(Sender: TObject);
begin
  if ListBox1.ItemIndex = -1 then Exit;
  var F := TForm(ListBox1.Items.Objects[ListBox1.ItemIndex]);

  if self.Parent <> nil then
  Self.ScaleBy(Biggly,Smaller);

  if F <> Nil then
  F.ScaleBy(Smaller,Biggly);
end;

var
  TopWinControl: HWND;

procedure TSideBar.TaskTimerTimer(Sender: TObject);
const
  MAX_VALUE = 255;
var
  pcClassName: Array [0 .. MAX_VALUE] Of Char;
  aClassName: string;
  Hnd: HWND;
begin
  TaskTimer.Enabled := False;
//Task 0.5  was Task 3;
  Hnd := GetForegroundWindow;
  // ^^ was if GetTopWindow(Hx) <> Toper
  // shows apps being used.
  if Hnd <> TopWinControl then
  begin
    TopWinControl := Hnd;
    GetClassName(Hnd, pcClassName, MAX_VALUE);
    aClassName := Trim(pcClassName);
    label1.Caption := aClassName;
    memoShowMessages.Lines.add(format('%2.3f %s on top', [Time * 24, aClassName]));//Screen.Forms[0].Name]);
  end;

// task 1  Show App when other app is closed.
// moved to setDual in MAIN
  UpdateRemoteTask; //assigned Main/


// task 2 show time and handles in use

// moved to settwinH
//    StatusBar.SimpleText := format('Hnd %d Comp %d Hr:%2.3f',[Handle, FtwinH, Time * 24]);

//task 3 update Forms listed in LB
  UpdateListUI(Sender);

 //boo 100xs Jumper.Show;  // not needed and perhaps fighting the debugger

  TaskTimer.Enabled := True;
end;

/// surfaces  minimized Main if Dual (other mainform) was closed.
procedure TSideBar.UpdateRemoteTask;
begin
  if Assigned(FOnUpdateRemoteTask) then
        FOnUpdateRemoteTask(Self);
end;

var
  ScreenCount: Integer = 0;
  PreviousForm: string = '';
procedure TSideBar.UpdateListUI(Sender: TObject);
var
  pcClassName: Array [0 .. 255] Of Char;
  lFormName: string;
begin
  Try
    if (Screen.FormCount <> ScreenCount) or
      (Screen.Forms[0].Name <> PreviousForm) then
    begin
      ScreenCount := Screen.FormCount;
      PreviousForm := Screen.Forms[0].Name;

      ListBox1.Clear;
      for var I := 0 to Screen.FormCount - 1 do
      begin
        lFormName := Screen.Forms[I].Name;
        if lFormName = '' then
        begin
          GetClassName(GetForegroundWindow, pcClassName, 255);
          lFormName := Trim(pcClassName);
          // ie no inscope object here
          if lFormName = '' then
            lFormName := 'Don''t touch me!';
          MemoAdd(lFormName);
        end;
        ListBox1.Items.AddObject(lFormName, Screen.Forms[I]);
      end;
    end;
  Except
    on E: Exception do
      showmessage(E.Message + #13 + E.ClassName);
  End;
end;

end.
