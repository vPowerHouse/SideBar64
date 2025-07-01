unit TwoHeadTypes;

interface
  uses
    windows,
    vcl.StdCtrls, Classes, Controls;
const
  DT1winclassname = 'Pats1stDeskTop';
  DT2winclassname = 'Second_DeskTop' ;

type
  TRoleEnum = (reZero, reDT1, reDT2, reTelePort12, reTelePort21);
  TDualCommand = (dcStart, dcDT1, dcDT2, dcShowDT1, dcShowDT2, dcOpenFile, dcMoveFile12, dcMoveFile21, dcStop, dcNothing);
  //
  //TDualCommands = Set of TDualCommand;
  //
  TDualCommands = Array of TDualCommand;


var
  //  https://stackoverflow.com/questions/1187487/how-to-access-delphi-function-at-dpr-scope
  LoaderVar: function (var ShowHnd, DT1Handle, DT2Handle:HWND;
    {const inOnTopH: HWND;}const AFN: string; const incommandH: TDualCommand):TDualCommand;

type
  TYenYang = Class
  class function urLoader (var ShowHnd, DT1Handle, DT2Handle:HWND;
       const AFN: string; const incommandH: TDualCommand):TDualCommand;
  class function urLoader1 (const DT1winclassname, DT2winclassname: PWideChar; const AFN: string;
  const incommandH: TDualCommand): TDualCommand;
  End;
implementation

{ TYenYang }

class function TYenYang.urLoader(var ShowHnd, DT1Handle, DT2Handle: HWND;
    const AFN: string; const incommandH: TDualCommand): TDualCommand;
  begin
  end;

class function TYenYang.urLoader1(const DT1winclassname, DT2winclassname: PWideChar;const AFN: string;
  const incommandH: TDualCommand): TDualCommand;

  var
    CreateDT1,
    CreateDT2,
    DT1running,
    DT2running,
    isDT1onTop,
    isDT2onTop,
    LoaderFNOpen: Boolean;

    DT1Handle,
    DT2Handle,
    OnTopH,
    ShowHnd: HWND;


  begin
    Result     := dcNothing;
    ShowHnd := 0;
    DT1Handle  := FindWindow(DT1winclassname, nil);
    DT2Handle  := FindWindow(DT2winclassname, nil);

    DT1running := DT1Handle > 0;
    DT2running := DT2Handle > 0;
    OnTopH := GetForegroundWindow; //was passed in
    isDT1onTop := OnTopH = DT1Handle;
    isDT2onTop := OnTopH = DT2Handle;
// Fix at call
//    FileneedsOpened := FileExists(ParamStr(1));
//    LoaderFNOpen := FileExists(aFN);
    if (isDT1onTop and DT2running) or DT2Running then
       begin
         ShowHnd := DT2Handle;
       end;
    if (isDT2onTop and DT1running) or DT1running then
       begin
         showHnd := DT1Handle;
       end;

    CreateDT1 := not DT1running;
    CreateDT2 := DT1running and not DT2running;

    if CreateDT1 then
    begin
      showHnd  := 0;
      result := dcDT1;
    end
    else begin
      if CreateDT2 then
      begin
        ShowHnd  := 0;
        result := dcDT2;
      end;
    end;

    if  (InCommandH = dcShowDT1)
        and DT1running
          then ShowHnd := DT1Handle;

    if  (InCommandH = dcShowDT2)
        and DT2running
          then ShowHnd := DT2Handle;

    if ShowHnd > 0
    then begin
      if IsIconic(ShowHnd) then
        ShowWindow(ShowHnd, SW_RESTORE);
      SetForegroundWindow(ShowHnd);
      if AFN <> '' then
      begin
        Result := dcMoveFile12;
//        if assigned(M1) then
//          dcMoveFile12
//          M1.OpenMDIChild(AFN);
//        if assigned(M2)
//          then M2.OpenMDIChild(AFN);
      end else
      Result:= dcStart;
    end;

end;

end.
