unit NavTuner;

//  copyright 2024 Pat Foley

// License requires

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.ComCtrls, Vcl.Forms, Vcl.ExtCtrls,   Vcl.Dialogs, Vcl.StdCtrls;
const
  // give the scalers bigger scale factors
  // round 10/11  or round
  // was 1_000 952
  Biggly = 96 * 11 - 96 DIV 2;   //1.05 ISH
  Smaller = 96 * 10;

type
  TSideBar = class(TForm)
    GroupBox1: TGroupBox;
    Grow: TButton;
    Hnd_sizeof: TButton;
    ListBox1: TListBox;
    Sel_Show: TButton;
    Shrink: TButton;
    TaskTimer: TTimer;
    btnRunStop: TButton;
    Label1: TLabel;
    memoShowMessages: TMemo;
    Splitter1: TSplitter;
    Button1: TButton;
    procedure btnRunStopClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure GrowClick(Sender: TObject);
    procedure Hnd_sizeofClick(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure Sel_ShowClick(Sender: TObject);
    procedure ShrinkClick(Sender: TObject);
  private
    FApp,
    FComplement: HWND;
    FOnUpdateMainEvent: TNotifyEvent;
    procedure TaskTimerTimer(Sender: TObject);
  protected
    procedure UpdateMainEvent;
  public
        procedure ListHwnd;

    procedure MemoAdd(const inString: string);
    { Public declarations }
    procedure UpdateListUI(Sender: TObject);
///3    procedure UpdateHandlesetal(const AappH, ACompH: HWND; AUpdateEvent: TNotifyEvent);
//    procedure UpdateMainTick(Sender: TObject);
  published
    property OnUpdateMainEvent: TNotifyEvent read FOnUpdateMainEvent write FOnUpdateMainEvent;
  end;

var
  Jumper: TsideBar;
  //  https://stackoverflow.com/questions/1187487/how-to-access-delphi-function-at-dpr-scope
  LoaderVar: Function(var h2, h3, h4, H5, h6: HWND):hwnd;


implementation

{$R *.dfm}
//var
//  mainunitUpdate: TNotifyEvent;

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
  ListHwnd;
end;

procedure TSideBar.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
//    TaskTimer.Enabled := False;
//  //if parent  then
//
//  if parent <> nil then
//  begin
//    CanClose := False;
//    parent := Nil;
//  end;
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

procedure TSideBar.ListHwnd;
var RC ,h2, h3, h4, H5, h6: HWND;
begin
    //  https://stackoverflow.com/questions/1187487/how-to-access-delphi-function-at-dpr-scope
  RC := LoaderVar(h2, h3, h4, H5, h6);
  MemoAdd(NativeUInt(H6).ToString);
  Button1.Caption := 'Command ' + NativeUInt(H6).ToString;
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
  //therefore no item gets selected?
  LB := ListBox1;
  if LB.ItemIndex = -1 then
  begin
    memoadd('Ouch better luck next time :)');
    memoadd('It does that--try again');
    memoadd('the item becomes selected when it background is blue');

    Exit;
  end;
  F := TForm(LB.Items.Objects[LB.ItemIndex]);
  if F = nil then
    Exit;

  If F.WindowState = TWindowState.wsMinimized then
    F.WindowState := wsNormal;
  F.BringToFront;
  F.Show;

end;

//procedure TSideBar.UpdateHandlesetal(const AappH, ACompH: HWND; AUpdateEvent: TNotifyEvent);//()(const AappH, ACompH: HWND; AUpdateEvent: TNotifyEvent);
//begin
//  FApp := AappH;
//  FComplement := AcompH;
//  AUpdateEvent := UpdateMainTick;
//end;

procedure TSideBar.ShrinkClick(Sender: TObject);
begin
 var F := {Screen.Forms[0]; //}TForm(ListBox1.Items.Objects[ListBox1.ItemIndex]);

  if self.Parent <> nil then
  Self.ScaleBy(Biggly,Smaller);
  //
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
  //if GetTopWindow(Hx) <> Toper
  if Hnd <> TopWinControl then
  begin
    TopWinControl := Hnd;
    GetClassName(Hnd, pcClassName, MAX_VALUE);
    aClassName := Trim(pcClassName);
    label1.Caption := aClassName;
    memoShowMessages.Lines.add(format('%2.3f %s on top', [Time * 24, aClassName]));//Screen.Forms[0].Name]);
  end;

  // task 1  Show remaining App when the app showing is closed.
  //
// moved to setComplementApp in MAIN
// sends callback to Main
//UpdateMainTick(Sender);
   UpdateMainEvent; //assigned Main/

  //CompAppHWND := parent as TMain)
  //If not IsWindow(FComplement) then
  //with Parent as TMain

//  begin
//    ComplementApp := 0;
//    // bypass if wsMax'
//    if WindowState = TWindowState.wsMinimized then
//      WindowState := wsNormal;  // surfaces self if swMin'
//    //Show;
//  end;

// task 2 show time and handles in use

// moved to setComplementApp
//    StatusBar.SimpleText := format('Hnd %d Comp %d Hr:%2.3f',[Handle, FComplementApp, Time * 24]);

//task 3 update Form Objects in LB
//    if self.MDIChildCount > 0 then
  UpdateListUI(Sender);
    //boo 100xs Jumper.Show;

  TaskTimer.Enabled := True;
end;

procedure TSideBar.UpdateMainEvent;
begin
  if Assigned(FOnUpdateMainEvent) then FOnUpdateMainEvent(Self);
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

//procedure TSideBar.UpdateMainTick(Sender: TObject);
//begin
////
//// if assigned (mainunitUpdate) then MainUnitUpdate(Sender);
//end;

end.
