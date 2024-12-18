unit MAIN;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.Menus, Vcl.StdCtrls, Vcl.Dialogs, Vcl.Buttons, Winapi.Messages,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdActns, Vcl.ActnList, Vcl.ToolWin,
  Vcl.ImgList, Vcl.FormTabsBar, System.ImageList, System.Actions,
  Vcl.BaseImageCollection, Vcl.ImageCollection, Vcl.VirtualImageList,
  Vcl.ActnMan, Vcl.ActnCtrls, Vcl.ActnMenus, Vcl.PlatformDefaultStyleActnCtrls
  //,System.Types,
  ,System.UITypes;
    // ^ for dynarray
const
  wsNormal     = System.UITypes.TWindowState.wsNormal;
  wsMinimized  = System.UITypes.TWindowState.wsMinimized;
  wsMaximized  = System.UITypes.TWindowState.wsMaximized;

  //iniDT_Two: string = 'setDeskTop_Two';          // paramstr param1 tells dpr to make 2nd DT
  //StopOtherDeskTop: string = 'StopOtherDeskTop'; // command not used today
  DT_One = 'DeskTop_One';
  DT_Two = 'DeskTop_Two';
  DT1winclassname = 'Pats1stDeskTop';
  DT2winclassname = 'Second_DeskTop' ;
  Roles:TArray<string> = ['ZeroIndex', DT_One, DT_Two];
  Form2s: TArray<string> = ['One','Two','Three','Four','Five','Six'];
type
  TRoleEnum = (reZero, reDT1, reDT2);

  // On the UI side tie in some data for convience
  // the data side could DI to tie in some UI
  TdataButton = class(TButton)
    Form: TForm;
    Strs: TStrings;
  end;


//type
  TMainForm = class(TForm)
    OpenDialog: TOpenDialog;
    StatusBar: TStatusBar;
    ActionList1: TActionList;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    FileNew1: TAction;
    FileSave1: TAction;
    FileExit1: TAction;
    FileOpen1: TAction;
    FileSaveAs1: TAction;
    WindowCascade1: TWindowCascade;
    WindowTileHorizontal1: TWindowTileHorizontal;
    WindowMinimizeAll1: TWindowMinimizeAll;
    HelpAbout1: TAction;
    FileClose1: TWindowClose;
    WindowTileVertical1: TWindowTileVertical;
    FormTabsBar1: TFormTabsBar;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    ActionMainMenuBar1: TActionMainMenuBar;
    ActionManager1: TActionManager;
    FileFourOpen: TAction;
    FileTwoOpen: TAction;
    ListScreenForms: TAction;
    Action2: TAction;
    Label1: TLabel;
    ToolBar1: TToolBar;
    ToolButton9: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    ToolButton3: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton14: TToolButton;
    ToolButton13: TToolButton;
    tbListForms2: TToolButton;
    tbOpenDT2: TToolButton;
    tbOpenDT1: TToolButton;
    ToolButton15: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure ListScreenFormsExecute(Sender: TObject);
    procedure btnShow_Other_AppClick(Sender: TObject);
    procedure tbListFormsClick(Sender: TObject);
    procedure btnShowDT1Click(Sender: TObject);
    procedure FileFourOpenExecute(Sender: TObject);
    procedure FileNew1Execute(Sender: TObject);
    procedure FileOpen1Execute(Sender: TObject);
    procedure FileExit1Execute(Sender: TObject);
    procedure FileTwoOpenExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure HelpAbout1Execute(Sender: TObject);
    procedure ToolButton13Click(Sender: TObject);
    procedure ToolButton15Click(Sender: TObject);
    procedure UpdateTaskfromRemote(Sender: TObject);
    procedure WindowCascade1Execute(Sender: TObject);
    procedure WindowTileHorizontal1Execute(Sender: TObject);
    procedure WindowTileVertical1Execute(Sender: TObject);
  private
    FComplementApp: HWND;
    FRole: NativeInt;

    { Private declarations }
    procedure btnDataclick(Sender: TObject);
    procedure CreateMDIChild(const Name: string);
    procedure SetComplementApp(const Value: HWND);
    procedure SetRole(const Value: NativeInt);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
  published
    property ComplementApp: HWND read FComplementApp write SetComplementApp;
    property Role: NativeInt read FRole write SetRole;
  end;
type
  TMainForm2 = class(TMainForm)
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  end;

var
  MainForm,
  MainForm2: TMainForm2;


implementation

{$R *.dfm}

uses CHILDWIN, About,
     baseform, Unit2, Unit4,
     NavTuner,
     ShellAPI,
     TlHelp32, Winapi.PsAPI,
     Math;
//var
//  Jumper: TSideBar;

procedure jmpLogAdd(const inStr: string);
begin
  Jumper.MemoAdd(inStr);
end;

// alternate? https://en.delphipraxis.net/topic/3463-rzlauncher-vs-win-api-call/?tab=comments#comment-29107
// source https://stackoverflow.com/questions/38759198/open-external-application-with-passing-parameters-using-delphi-application

function RunApplication(const AExecutableFile, AParameters: string; const AShowOption: Integer = SW_SHOWNORMAL): NativeUInt;
var
  _SEInfo: TShellExecuteInfo;
begin
  Result := 0;
  if not FileExists(AExecutableFile) then
    Exit;

  FillChar(_SEInfo, SizeOf(_SEInfo), 0);
  _SEInfo.cbSize := SizeOf(TShellExecuteInfo);
  _SEInfo.fMask := SEE_MASK_NOCLOSEPROCESS;
  // _SEInfo.Wnd := Application.Handle;
  _SEInfo.lpFile := PChar(AExecutableFile);
  _SEInfo.lpParameters := PChar(AParameters);
  _SEInfo.nShow := AShowOption;
  if ShellExecuteEx(@_SEInfo) then
  begin
    WaitForInputIdle(_SEInfo.hProcess, 3000);
    Result := GetProcessID(_SEInfo.hProcess);
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
//  Jumper := TSideBar.Create(Application);
  Jumper.OnUpdateMainEvent := UpdateTaskfromRemote;
end;

/// baby step touching the captions through Application.Screen found in forms
///F.Caption := F.Caption + ' touching';
/// leave to
procedure TMainForm.ListScreenFormsExecute(Sender: TObject);
begin
  jmpLogAdd(Screen.ActiveForm.Caption + ' Looked at ');
  for var i := 0 to Screen.Formcount - 1 do
    jmpLogAdd(Screen.Forms[i].Name);
  // Staged event allowing the sidebar to show that different dialogs are
  // when using style
  ShowMessage(Screen.ActiveForm.Name);
end;

procedure TMainForm.btnDataclick(Sender: TObject);
var
  ChildBtn: TdataButton;
begin
  if Sender is TdataButton then
    ChildBtn := (Sender as TdataButton)
  else
    Exit;

  if OpenDialog.Execute then
  begin
    ChildBtn.Strs.LoadFromFile(OpenDialog.FileName);
    ChildBtn.Form.Caption := OpenDialog.FileName;
  end;
end;

procedure TMainForm.btnShow_Other_AppClick(Sender: TObject);
var
  sParamStrLine: string;
//  sH: string;
  RC: HWNd;

//  h2,h3,h4,H5, h6: HWND;
//  b: boolean;
//  R: hwnd;
//  s: string;
//begin
  //if b then        h2       h3       h4

begin

  if IsWindow(FComplementApp)
    then begin
      if IsIconic(FComplementApp) then
         ShowWindow(FComplementApp, SW_RESTORE);
      SetForegroundWindow(FComplementApp);
      Sleep(389);
      WindowState := wsminimized;
    end
  else
  begin
    RC := RunApplication('MDIAPP.exe', '', 1);
    sleep(300);
    ComplementApp := FindWindow(DT2winclassname,nil);//GetforegroundWindow;
    jmpLogAdd(Format('PID:%d %s',[RC, SysErrorMessage(GetLastError)] ));
    ///a Using 'Hide' simply does not work here
    //     Hide;
    // The Iconic bottom feeders give 'vintage' look to apps :)
    // though the styled version needs a click on Icon to restore.
    //  Button1Click(Sender);
    //btnShowDT1Click(Sender);
    //btnShow_Other_AppClick(Sender);
    //WindowState := wsminimized;
//    Exit
  end;



end;

procedure TMainForm.tbListFormsClick(Sender: TObject);
begin
  ListScreenFormsExecute(Sender);
end;

procedure TMainForm.btnShowDT1Click(Sender: TObject);
//var
//  h2,h3,h4,H5, h6: HWND;
////  b: boolean;
//  R: hwnd;
//  s: string;
begin
//  r:= LoaderVar(h2,h3,h4,H5,h6);
  //if b then        h2       h3       h4
  //s:= format('dprHs %d dtONE:%d dtTWO:%d Top:%d x:%d', [h2,h3,h4,H5,h6]);
//  s:= 'need to check role';
//  StatusBar.SimpleText := 'Initializing back to One';
//  tbOpenDT1.Hint := 'show DT One';
//  label1.caption :=  s;
//  Button1.Enabled := True;
//
//  Button1.Caption := 'DT One';
//  btnShow_Other_App.Enabled := False;


end;

procedure TMainForm.FileFourOpenExecute(Sender: TObject);
begin
  var
    ChildForm4Index: Integer := 0;
  var
    CreatedAll_NamesProvided: Boolean;

  repeat
    var
      ChildForm4 := TForm4.Create(Application);
    ChildForm4.Name := ChildForm4.ComboBox1.Items[ChildForm4Index];
    ChildForm4.OnActivate := FormActivate;
    ChildForm4.OnDeActivate := FormDeactivate;


    Inc(ChildForm4Index);
    CreatedAll_NamesProvided := ChildForm4Index + 1 = ChildForm4.ComboBox1.Items.Count;
  until CreatedAll_NamesProvided;

end;

procedure TMainForm.CreateMDIChild(const Name: string);
var
  Child: TMDIChild;
begin
  { create a new MDI child window }
  Child := TMDIChild.Create(Application);
  Child.Caption := Name;
  Child.OnActivate := FormActivate;
  if FileExists(Name)
    then Child.Memo1.Lines.LoadFromFile(Name)
  else
    begin
      var btnData := TdataButton.Create(Self);
      btnData.Parent := Child;
      btnData.Left := 10;
      btnData.Top := 10;
      btnData.Hint := 'shows open file dialog';
      btnData.ShowHint := True;
      btnData.Caption := 'Open text file';
      btnData.Strs  := Child.Memo1.Lines;
      btnData.Form := Child;
      btnData.OnClick := btnDataClick;
    end;
end;

procedure TMainForm.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WinClassName := DT1winclassname;
end;

procedure TMainForm.FileNew1Execute(Sender: TObject);
begin
  CreateMDIChild('LAZY_' + IntToStr(MDIChildCount + 1));
end;

procedure TMainForm.FileOpen1Execute(Sender: TObject);
begin
  if OpenDialog.Execute then
    CreateMDIChild(OpenDialog.FileName);
end;

procedure TMainForm.HelpAbout1Execute(Sender: TObject);
var
  ChildAbout: TAboutBox;
begin
  ChildAbout:= TAboutBox.Create(Application);
  ChildAbout.OnActivate := FormActivate;
end;

procedure TMainForm.SetComplementApp(const Value: HWND);
var
  s, s1, s2: string;
  ImageIdx: Integer;
  RoleOther: TRoleEnum;
  btnOutShow: Boolean;
  btnbackShow: Boolean;
begin
  if ComplementApp <> Value then
  begin
    FComplementApp := Value;
    s := 'Show ';
    // StatusBar.SimpleText gets overwritten
    jmpLogAdd(Format('%s %d Comp %d', [Roles[Role], Handle, FComplementApp]));
    if Value = 0 then
      s := 'Start';
    // To surface instance when other instance is closed
    // not working or losing the normal size
    if (Value = 0) and (WindowState = wsMinimized) then
    begin
      WindowState := wsNormal;
      s1 := ' Closing?';
    end
    else s1 := ' ca setter';
    // end;
    //'Port' Invertor
    case TRoleEnum(Role) of
     reZero:
        begin
          RoleOther := reZero;
          btnOutShow := True;
          ImageIdx := 3;
          //btnbackShow := True;
        end;
      reDT1:
        begin
          RoleOther := reDT2;
          btnOutShow := True;
          ImageIdx := 3;
          //btnbackShow := False;
        end;
      reDT2:
        begin
          RoleOther := reDT1;
          btnOutShow := True;
          ImageIdx := 4;
          btnbackShow := True;
        end;
    end;
    s2 := Format('%s %s %s', [s, Roles[Ord(RoleOther)], s1]);
    //tbOpenDT1.Hint := s2;
    tbOpenDT2.Hint := s2;
    tbOpenDT2.Visible := btnOutShow;
    tbOpenDT2.ImageIndex := ImageIdx;
    //tbOpenDT1.Visible := btnbackShow;
  end;
end;

procedure TMainForm.WindowCascade1Execute(Sender: TObject);
begin
  Cascade;
end;

procedure TMainForm.WindowTileHorizontal1Execute(Sender: TObject);
begin
  TileMode := tbHorizontal;
  Tile;
end;

procedure TMainForm.WindowTileVertical1Execute(Sender: TObject);
begin
  TileMode := tbVertical;
  Tile;
end;

procedure TMainForm.FileExit1Execute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.FileTwoOpenExecute(Sender: TObject);
var

  MDIChildForm2: TForm2;
  // SDA: TStringDynArray;
begin
  // SDA := Form2s;
  /// assigned doesn't work on child windows?
  // if not assigned(Form2) then

  // var Boo does not work


  for var mdiChildName in Form2s do // was SDA do
  // while TwoIdx <= High(form2s) do
  begin
      // create first
    MDIChildForm2 := TForm2.Create(Application);
    MDIChildForm2.Name := mdiChildName; // Form2s[TwoIdx];
    // fixup later  ~ wire up messages
    MDIChildForm2.OnActivate := FormActivate;
  //  Inc(TwoIdx);
  end;
end;
//  end;(
//  while TwoIdx <= High(form2s) do
//  begin
//  Repeat
//    var mdiForm2 := TForm2.Create(Application);
//          mdiform2.Name := Form2s[TwoIdx];
//              // fixup later
//                  mdiForm2.OnActivate := FormActivate;
//                      Inc(TwoIdx);
//                        Until TwoIdx >= High(Form2s);
//
//end;

procedure TMainForm.FormActivate(Sender: TObject);
//var
//  LZ: TControl;
begin
  //inherited;

  if (Application.MainForm.MDIChildCount < 3)
    // and (Sender is TMainForm)
    // or (Sender is TMainForm2)
     then begin
        Jumper.Parent := nil;//LandingZone;
        if Jumper.Visible = False then  Jumper.Visible := True;
        Jumper.BorderStyle := bsSizeable;
     end

  else if Sender is TForm then
  begin
    var form := TForm(Sender);
    var AdjustHeight := Jumper.memoShowMessages.top + 150;
        AdjustHeight := Max(AdjustHeight, form.Height);
        form.Height := AdjustHeight;
    Jumper.BorderIcons := [];
    Jumper.BorderStyle := bsnone;
    Jumper.Parent := form;
  end;
end;

procedure TMainForm.FormDeactivate(Sender: TObject);
begin
  if (Application.MainForm.MDIChildCount < 3)
    // and (Sender is TMainForm)
    // or (Sender is TMainForm2)
     then begin
        Jumper.Parent := nil;//LandingZone;
        if Jumper.Visible = False then  Jumper.Visible := True;
        Jumper.BorderStyle := bsSizeable;
     end

end;

procedure TMainForm.SetRole(const Value: NativeInt);
var
  s, s1, s2: string;
  ImageIdx: Integer;
  RoleOther: TRoleEnum;
  btnOutShow: Boolean;
  btnbackShow: Boolean;

begin
  FRole := Value;
  Caption := Roles[FRole];
  //tbOpenDT2.Hint := Roles[FRole-1];
  case TRoleEnum(Role) of
     reZero:
        begin
          RoleOther := reDT2;
          btnOutShow := True;
          ImageIdx := 4;
          //btnbackShow := True;
        end;
      reDT1:
        begin
          RoleOther := reDT2;
          btnOutShow := True;
          ImageIdx := 4;
          //btnbackShow := False;
        end;
      reDT2:
        begin
          RoleOther := reDT1;
          btnOutShow := False;
          ImageIdx := 3;
          btnbackShow := True;
        end;
    end;
  s2 := Format('%s %s %s', [s, Roles[Ord(RoleOther)], s1]);
  tbOpenDT2.Hint := s2;
  tbOpenDT2.ImageIndex := ImageIdx;
end;

procedure TMainForm.ToolButton13Click(Sender: TObject);
begin
  if not Assigned(Jumper) then
    Jumper:= TSideBar.Create(Application);
  Jumper.Parent := nil;
  //Jumper.movetoFront;
  Jumper.Show;
end;

procedure TMainForm.ToolButton15Click(Sender: TObject);
var
  WC: Twincontrol;
begin
  WC :=GetParentForm(jumper,True);
  StatusBar.SimpleText := WC.GetNamePath;
  WC :=GetParentForm(jumper,false);
  ShowMessage(WC.GetNamePath);
end;


procedure TMainForm.UpdateTaskfromRemote(Sender: TObject);
begin
  // Task update start switch when fellow app is started

  // surface hidden app when fellow app is closed.
  if             (ComplementApp > 0)
     and not IsWindow(ComplementApp)
     and (WindowState = wsMinimized)
   then
 // begin
    ComplementApp := 0;
  //  windowstate := TWindowState.wsNormal;
 //   BringtoFront;
 //   Visible := True;
    //if Visible = False then  Visible := True;
 // end;

end;

{ TMainForm2 }

procedure TMainForm2.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WinClassName := DT2winclassname;
end;

end.
