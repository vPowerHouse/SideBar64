program Mdiapp;
{ $WEAKLINKRTTI ON}
{ $RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}

uses
  Forms,
  Winapi.Windows,
  System.SysUtils,
  ShellAPI,
  Dialogs,
  Main in 'Main.pas' {MainForm},
  CHILDWIN in 'CHILDWIN.PAS' {MDIChild},
  Vcl.Themes,
  Vcl.Styles,
  NavTuner in 'NavTuner.pas' {SideBar};

{$R *.RES}

var
  //inNewAppHnd,
  ShowHnd,
  //CompHforDT1,CompHforDT2,
  OnTopH: HWND;
  DT1Handle: HWND;
  DT2Handle: HWND;


function TwoHeadLoader(var ShowHnd, DT1Handle, DT2Handle, OnTopH, commandH: HWND): Hwnd;
var

  Create1stApp,
  Create2ndApp,
  DT1running,
  DT2running,
  isDT1onTop,
  isDT2onTop: Boolean;

begin
  Result     := 0;
  DT1Handle  := FindWindow(DT1winclassname, nil);
  DT2Handle  := FindWindow(DT2winclassname, nil);
  DT1running := DT1Handle > 0;
  DT2running := DT2Handle > 0;

  isDT1onTop := OnTopH = DT1Handle;
  isDT2onTop := OnTopH = DT2Handle;

  if (isDT1onTop and DT2running) or DT2Running then
    ShowHnd := DT2Handle;
  if (isDT2onTop and DT1running) or DT1running then
    showHnd := DT1Handle;

  Create1stApp :=  DT2running and ((not DT1running) or not DT2running);
  if Create1stApp then
  begin
    showHnd := 0;
    CommandH := 1;
//    Exit(commandH)
  end
  else


  Create2ndApp := DT1running and not DT2running;
  if Create2ndApp then
  begin
    ShowHnd := 0;
    CommandH := 2;
//    Exit(commandH)
//    DT1Handle := inNewAppHnd;
  end;

//  CompHforDT2 := DT1Handle;
//  CompHforDT1 := DT2Handle;



  if ShowHnd > 0
  then begin
    if IsIconic(ShowHnd) then
      ShowWindow(ShowHnd, SW_RESTORE);
    SetForegroundWindow(ShowHnd);
    commandH := 0;
    Exit;
    //break;
    //halt;
  end;
  Result := commandH;
end;


begin
  LoaderVar := TwoHeadLoader;
  var command1:HWND := 1;
    DT1Handle := findwindow(DT1winclassname, nil);
//  inNewAppHnd := 42;//Application.Handle;
  OnTopH := GetForegroundWindow;

  if
    (LoaderVar( ShowHnd, DT1Handle, DT2Handle, OnTopH, Command1) > 0)
    and (command1 = 1)
    or (Command1 = 2)
  then

  Jumper := TSideBar.Create(Application);
  //Jumper.ListHwnd;

  Application.Initialize;
  //  this doesn't work on this job  the side bar shows up
  // on all the other Desktops when used.
  // It stlls gets an Icon ?
  //Application.MainFormOnTaskBar := True;
  Application.DefaultFont.Color := $DEC4B0;// Light steel blue
  Application.DefaultFont.name := 'Palatino Linotype';

  If command1 = 1 //   Create1stApp
    then begin
     // TStyleManager.TrySetStyle('Aqua Light Slate'); //different path in file dialog when no style applied!
      Application.CreateForm(TMainForm, MainForm);
      if  DT2Handle > 1 then
      MainForm.ComplementApp := DT2Handle;//CompHforDT1;
      Mainform.Role := 1;
      //MainForm.Caption := '   DT_One;
//      Application.Run;
//  ReportMemoryLeaksOnShutdown := True;

    end
  else
  if Command1 = 2 then

    begin
      TStyleManager.TrySetStyle('Windows10 Dark'); //was 'Sky'
      Application.DefaultFont.size := 14;//'Palatino Linotype'; //'Segoe UI';//
      //Application.DefaultFont.Color := $DEC4B0;// Light steel blue

      Application.CreateForm(TMainForm2, MainForm2);
      MainForm2.ComplementApp := DT1Handle;
      Mainform2.role := 2;
      //MainForm2.Caption := DT_Two + ' Gut ' + ParamStr(2);
//      Application.Run;
//      ReportMemoryLeaksOnShutdown := True;

    end;

  //Application.CreateForm(TJumper, Jumper);
      Application.Run;
      ReportMemoryLeaksOnShutdown := True;


end.
