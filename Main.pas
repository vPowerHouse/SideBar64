unit MAIN;
// forked from EMBA's Marco Cantu MDI uplift effort
interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.Menus, Vcl.StdCtrls, Vcl.Dialogs, Vcl.Buttons, Winapi.Messages,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdActns, Vcl.ActnList, Vcl.ToolWin,
  Vcl.ImgList, Vcl.FormTabsBar, System.ImageList, System.Actions,
  Vcl.BaseImageCollection, Vcl.ImageCollection, Vcl.VirtualImageList,
  Vcl.ActnMan, Vcl.ActnCtrls, Vcl.ActnMenus, Vcl.PlatformDefaultStyleActnCtrls,
  System.UITypes;

const
  wsNormal     = System.UITypes.TWindowState.wsNormal;
  wsMinimized  = System.UITypes.TWindowState.wsMinimized;
  wsMaximized  = System.UITypes.TWindowState.wsMaximized;

  //iniDT_Two: string = 'setDeskTop_Two';          // paramstr param1 tells dpr to make 2nd DT
  //StopOtherDeskTop: string = 'StopOtherDeskTop'; // command not used today
  DT_One = 'DeskTop_One';
  DT_Two = 'DeskTop_Two';
  Roles:TArray<string> = ['ZeroIndex', DT_One, DT_Two];
  Form2s: TArray<string> = ['One','Two','Three','Four','Five','SixteenThousand_OneHundred_NintyNine_NoHundreth'];
type
  // On the UI controls side carry some data references for convenience
  // the data side could use Dependance Injection to tie in UI controls
  TDataButton = class(TButton)
    Form: TControl;
    Strs: TStrings;
end;

type

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
    tbSideBarFloat: TToolButton;
    tbListForms2: TToolButton;
    tbOpenDT2: TToolButton;
    ToolButton15: TToolButton;
    tbtnTransfer: TToolButton;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure ListScreenFormsExecute(Sender: TObject);
    procedure btnShow_Other_AppClick(Sender: TObject);
    procedure tbListFormsClick(Sender: TObject);
    procedure FileFourOpenExecute(Sender: TObject);
    procedure FileNew1Execute(Sender: TObject);
    procedure FileOpen1Execute(Sender: TObject);
    procedure FileExit1Execute(Sender: TObject);
    procedure FileTwoOpenExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure HelpAbout1Execute(Sender: TObject);
    procedure tbSideBarFloatClick(Sender: TObject);
    procedure ToolButton15Click(Sender: TObject);
    procedure UpdateTaskfromRemote(Sender: TObject);
    procedure WindowCascade1Execute(Sender: TObject);
    procedure WindowTileHorizontal1Execute(Sender: TObject);
    procedure WindowTileVertical1Execute(Sender: TObject);
  private
    FDual: HWND;
    FRole: NativeInt;

    { Private declarations }
    procedure btnDataclick(Sender: TObject);
    procedure CreateMDIChild(const Name: string);
    procedure SetDual(const Value: HWND);
    procedure SetRole(const Value: NativeInt);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    procedure OpenMDIChild(const FileName: string);
  published
    property Dual: HWND read FDual write SetDual;
    property Role: NativeInt read FRole write SetRole;
  end;
type
  TMainForm2 = class(TMainForm)
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  end;

//var
//  MainForm: TMainForm;
//  MainForm2: TMainForm2;


implementation

{$R *.dfm}

uses CHILDWIN, About,
     baseform, Unit2, Unit4,
     TwoHeadTypes,
     NavTuner,
     ShellAPI,
     TlHelp32, Winapi.PsAPI,
     Math;

var  SideBar: TSideBar;

procedure jmpLogAdd(const inStr: string);
begin
  SideBar.MemoAdd(inStr);
end;

// alternate? https://en.delphipraxis.net/topic/3463-rzlauncher-vs-win-api-call/?tab=comments#comment-29107
// source https://stackoverflow.com/questions/38759198/open-external-application-with-passing-parameters-using-delphi-application

function RunApplication(const AExecutableFile, AParameters: string; const AShowOption: Integer = SW_SHOWNORMAL): NativeUInt;

var _SEInfo: TShellExecuteInfo;

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
  SideBar := TSideBar.Create(Application);
  SideBar.OnUpdateRemoteTask := UpdateTaskfromRemote;
  // start timer
  SideBar.btnRunStopClick(Sender);
end;

procedure TMainForm.ListScreenFormsExecute(Sender: TObject);
begin
  jmpLogAdd(Screen.ActiveForm.Caption + ' Looked at ');
  for var i := 0 to Screen.Formcount - 1 do
    jmpLogAdd(Screen.Forms[i].Name);
{   Staged event allowing the sidebar to show that different dialogs are
   when using style
  ShowMessage(Screen.Forms[i].Name);
 baby step touching the captions through Application.Screen found in forms
F.Caption := F.Caption + ' touching'; }
end;

procedure TMainForm.OpenMDIChild(const FileName: string);
begin
  CreateMDIChild(FileName);
end;

procedure TMainForm.btnDataclick(Sender: TObject);
var
  ChildBtn: TdataButton;
begin
  if Sender is TdataButton
    then begin
           ChildBtn := (Sender as TdataButton);
           if OpenDialog.Execute then
             ChildBtn.Strs.LoadFromFile(OpenDialog.FileName);
         end;
end;

procedure TMainForm.btnShow_Other_AppClick(Sender: TObject);
var
  RC: HWND;
begin
  if IsWindow(FDual)
    then begin
      if IsIconic(FDual) then
        ShowWindow(FDual, SW_RESTORE);
      SetForegroundWindow(FDual);
      Sleep(389);
      WindowState := wsminimized;
    end
  else
  begin
    RC := RunApplication('MDIAPP.exe', '', SW_SHOWNORMAL);
    sleep(300);
    Dual := FindWindow(DT2winclassname,nil);//GetforegroundWindow;
    jmpLogAdd(Format('PID:%d %s',[RC, SysErrorMessage(GetLastError)] ));
    ///a Using 'Hide' simply does not work here
    //     Hide;
    //b Somehow the mainforms show as minimized windows behind the taskbar.
    // The Iconic bottom feeders give 'vintage' look to the apps :)
    // though the styled version needs a click on the subs Icon to restore.
  end;
end;

//var ani: Boolean = true;
//var aniStep: NativeInt = 0;
//var offset: Integer;
//procedure TMainForm.Button1Click(Sender: TObject);
//
//    procedure dostuff(bjct: TObject);
//    begin
//      Inc(aniStep);
//    end;
//begin
//  Inc(aniStep);
//  If aniStep < 111 then
//  begin
//      offset := 1 + aniStep div 2;
//      Timer1.Enabled := true;
//      Button1.Caption := format('%d',[aniStep]);
//      Button1.Update;
//      //aniHelper(sender, aniStep);
//      dostuff(sender);
//
//  end
//  else
//    begin
//      aniStep := 0;
//      Timer1.Enabled := false;
//    end;
//
//
//end;

procedure TMainForm.tbListFormsClick(Sender: TObject);
begin
  ListScreenFormsExecute(Sender);
end;

//20mar2025 relic of
//procedure TMainForm.btnShowDT1Click(Sender: TObject);
////var
////  h2,h3,h4,H5, h6: HWND;
//////  b: boolean;
////  R: hwnd;
////  s: string;
//begin
////  r:= LoaderVar(h2,h3,h4,H5,h6);
//  //if b then        h2       h3       h4
//  //s:= format('dprHs %d dtONE:%d dtTWO:%d Top:%d x:%d', [h2,h3,h4,H5,h6]);
////  s:= 'need to check role';
////  StatusBar.SimpleText := 'Initializing back to One';
////  tbOpenDT1.Hint := 'show DT One';
////  label1.caption :=  s;
////  Button1.Enabled := True;
////
////  Button1.Caption := 'DT One';
////  btnShow_Other_App.Enabled := False;
//
//
//end;

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
      ChildForm4.ONCloseQuery := FormCloseQuery;


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
  CHILD.OnCloseQuery := FormCloseQuery;
  if FileExists(Name)
    then Child.Memo1.Lines.LoadFromFile(Name)
  else
    begin
      var btnData := TdataButton.Create(Child);
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

procedure TMainForm.SetDual(const Value: HWND);
var
  s, s1, s2: string;
begin
  if Dual <> Value then
  begin
    FDual := Value;
    s := 'Show ';
    // StatusBar.SimpleText gets overwritten
    jmpLogAdd(Format('%s %d Dual %d', [Roles[Role], Handle, FDual]));
    if Value = 0 then
      s := 'Start ';
    // To surface instance when other instance is closed
    // not working or losing the normal size
    if (Value = 0) and (WindowState = wsMinimized) then
    begin
      WindowState := wsNormal;
      s1 := ' Opened';
    end
    else s1 := 'DT_2';
    s2 := Format('%s %s %s', [s, Roles[Role], s1]);
    tbOpenDT2.Hint := s2;
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
  // var Boo does not work note assigned works now 3-20-2025
  for var mdiChildName in Form2s do // was SDA do
  begin
    MDIChildForm2 := TForm2.Create(Application);
    MDIChildForm2.Name := mdiChildName; // Form2s[TwoIdx];
    // fixup  ~ wire up messages
    MDIChildForm2.OnActivate := FormActivate;
    MDIChildForm2.OnCloseQuery := FormCloseQuery;
  end;
end;

procedure TMainForm.FormActivate(Sender: TObject);
begin
  inherited;
// also close query can set Sidebar parent
  if (Application.MainForm.MDIChildCount < 1)
     then begin
        SideBar.Parent := nil;//LandingZone;
        if SideBar.Visible = False then  SideBar.Visible := True;
        SideBar.BorderStyle := bsSizeable;
     end
  else
     if Sender is TForm
      then begin
        var form := TForm(Sender);

        var AdjustHeight := SideBar.memoShowMessages.top + 150;
        AdjustHeight := Max(AdjustHeight, form.Height);
        form.Height := AdjustHeight;
        SideBar.BorderIcons := [];
        SideBar.BorderStyle := bsnone;
        SideBar.Parent := form;
      end;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Assigned(SideBar) and (Application.MainForm.MDIChildCount < 2)
    then begin
      SideBar.Parent := nil;//LandingZone;
      if SideBar.Visible = False then  SideBar.Visible := True;
      SideBar.BorderStyle := bsSizeable;
    end;

   CanClose := True;
end;

procedure TMainForm.SetRole(const Value: NativeInt);
var
  s, s1: string;
  ImageIdx: Integer;
  RoleOther: TRoleEnum;
begin
  FRole := Value;
  RoleOther := reZero;
  ImageIdx := 19;
  Caption := Roles[FRole];
  case TRoleEnum(Role) of
    reZero:
      begin
        RoleOther := reDT2;
        ImageIdx := 19;
      end;
    reDT1:
      begin
        RoleOther := reDT2;
        ImageIdx := 19;
      end;
    reDT2:
      begin
        RoleOther := reDT1;
        ImageIdx := 18;
      end;
  end;
  s  := Roles[Ord(FRole)];
  s1 := Roles[Ord(RoleOther)];
  //s2 := Format('%s %s %s', [s, Roles[Ord(RoleOther)], s1]);
  tbOpenDT2.Hint := Format('Showing:%s. Switch to :%s?',[s, s1]);
  tbOpenDT2.ImageIndex := ImageIdx;
end;

var Sticky: Boolean = True;
procedure TMainForm.tbSideBarFloatClick(Sender: TObject);
begin
  if not Assigned(SideBar) then
    SideBar:= TSideBar.Create(Application);

  Sticky := not Sticky;
  if Sticky then
    SideBar.Parent := Self
  else
    SideBar.Parent := nil;
  SideBar.Show;
end;

procedure TMainForm.ToolButton15Click(Sender: TObject);
//var
//  WC: Twincontrol;
begin
//  WC :=GetParentForm(SideBar,True);
//  StatusBar.SimpleText := WC.GetNamePath;
//  WC :=GetParentForm(SideBar,false);
//  ShowMessage(WC.GetNamePath);
  if SideBar.Parent <> nil then
    ShowMessage(SideBar.Parent.Name)
  else
    ShowMessage('no parent');
end;

procedure TMainForm.UpdateTaskfromRemote(Sender: TObject);
begin
  // helper window timer calls this test
  // to
  // surface this(self) instance hidden app when fellow instance is closed.


  if  (Dual > 0) and not IsWindow(Dual)
                 and (WindowState = wsMinimized)
               then
                 // Dual property setter has code to surface
                 Dual := 0;
end;

{ TMainForm2 }

procedure TMainForm2.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WinClassName := DT2winclassname;
end;

end.
