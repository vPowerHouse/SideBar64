program Mdiapp;
{$WEAKLINKRTTI ON}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}

// Copyright PatFoley 2024

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
  NavTuner in 'NavTuner.pas' {SideBar},
  TwoHeadTypes in 'TwoHeadTypes.pas';
//  ChildWinDD in 'ChildWinDD.pas' {formNavLZ};

{$R *.RES}

var
  FileneedsOpened: Boolean;
//  LoaderFNOpen: Boolean;
  FN: string;

  DT1Handle,
  DT2Handle: HWND;

  M1,MainForm: TMainForm;   // moved here 2025.06.17  was in MAIN

//  M2,MainForm2: TMainForm2;           //"    "

  inCommand, outCommand: TDualCommand;

//  function TwoHeadLoader(var ShowHnd, DT1Handle, DT2Handle:HWND;{ const inOnTopH: HWND;} const aFN: string; const argInCommand: TDualCommand):TDualCommand;
//  var
//    CreateDT1,
//    CreateDT2,
//    DT1running,
//    DT2running,
//    isDT1onTop,
//    isDT2onTop: Boolean;
//
//  begin
//    Result     := dcNothing;
//    DT1Handle  := FindWindow(DT1winclassname, nil);
//    DT2Handle  := FindWindow(DT2winclassname, nil);
//
//    DT1running := DT1Handle > 0;
//    DT2running := DT2Handle > 0;
//    OnTopH := GetForegroundWindow; //was passed in
//    isDT1onTop := OnTopH = DT1Handle;
//    isDT2onTop := OnTopH = DT2Handle;
//    FileneedsOpened := FileExists(ParamStr(1));
//    LoaderFNOpen := FileExists(aFN);
//    if (isDT1onTop and DT2running) or DT2Running then
//       begin
//         ShowHnd := DT2Handle;
//       end;
//    if (isDT2onTop and DT1running) or DT1running then
//       begin
//         showHnd := DT1Handle;
//       end;
//
//    CreateDT1 := not DT1running;
//    CreateDT2 := DT1running and not DT2running;
//
//    if CreateDT1 then
//    begin
//      showHnd  := 0;
//      result := dcDT1;
//    end
//    else begin
//      if CreateDT2 then
//      begin
//        ShowHnd  := 0;
//        result := dcDT2;
//      end;
//    end;
//
//    if  (argInCommand = dcShowDT1)
//        and DT1running
//          then ShowHnd := DT1Handle;
//
//    if  (argInCommand = dcShowDT2)
//        and DT2running
//          then ShowHnd := DT2Handle;
//
//    if ShowHnd > 0
//    then begin
//      if IsIconic(ShowHnd) then
//        ShowWindow(ShowHnd, SW_RESTORE);
//      SetForegroundWindow(ShowHnd);
//      if LoaderFNOpen then
//      begin
//        if assigned(M1) then
//          M1.OpenMDIChild(AFN);
////        if assigned(M2)
////          then M2.OpenMDIChild(AFN);
//      end;
//      Result:= dcStart;
//    end;
//  end;


//
begin
//  LoaderVar := TwoHeadLoader;


//  OnTopH := GetForegroundWindow;
  inCommand := dcDT1;
  FN := ParamStr(1);    //supports drag drop
  FileneedsOpened := FileExists(FN);


//  var CommandOut := LoaderVar( ShowHnd, DT1Handle, DT2Handle,{ OnTopH,} FN, InCommand);
  OutCommand := TYenYang.urLoader1(DT1winclassname, DT2winclassname, FN, inCommand);

  case OutCommand of
    dcStart:;
    dcMoveFile12: begin
      MainForm.OpenMDIChild(FN);
      exit;
    end;


  end;

  Application.Initialize;
  //Application.MainFormOnTaskBar := True;
  // This doesn't work on this job  the side bar shows up
  // on all the other Desktops when used.
  // It gets an Icon on other taskbars too.
  Application.DefaultFont.Color := $1E69D2;// Chocolate $DEC4B0;// Light steel blue
  Application.DefaultFont.name := 'Palatino Linotype';
  Application.DefaultFont.size := 10;

  If OutCommand = dcDT1 // CreateDT1
  then
  begin
    //TStyleManager.TrySetStyle('Aqua Light Slate'); //different path in file dialog when no style applied!
    Application.CreateForm(TMainForm, MainForm);
//  Application.CreateForm(TformNavLZ, formNavLZ);
  if DT2Handle > 1 then
      MainForm.Dual := DT2Handle;
    MainForm.Role := 1;
    //M1 := MainForm;
    if FileneedsOpened then
      MainForm.OpenMDIChild(ParamStr(1));
  end

  else if OutCommand = dcDT2
    then begin
      // was 'Sky'
      TStyleManager.TrySetStyle('Windows10 Dark');
      Application.DefaultFont.size := 11; // 'Palatino Linotype'; //'Segoe UI';//
      Application.DefaultFont.Color := $DEC4B0;// Light steel blue
      Application.CreateForm(TMainForm2, MainForm);
      MainForm.Dual := DT1Handle;
      MainForm.Role := 2;
      //m1 := MainForm;
      if FileneedsOpened then
        MainForm.OpenMDIChild(ParamStr(1));
    end;
//  else Exit;

  Application.Run;
  ReportMemoryLeaksOnShutdown := True;

end.
