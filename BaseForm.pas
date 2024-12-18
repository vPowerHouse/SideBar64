unit BaseForm;

interface

uses
  Vcl.Forms;

type
  TBaseForm = class(TForm)
  public
    procedure ShowForm(const AShow: Boolean);
// Tried action caFree here
//    procedure FormClose(Sender: TObject; var Action: TCloseAction);

// Allows loading non visible form
//  procedure AfterConstruction; override;
  procedure SetChildMaxSize;
  procedure SetChildNormalSize;
//   procedure ChangeMDIVisiblity(const bShow: Boolean);

  end;

implementation

uses
  Winapi.Windows;

{ TBaseForm }



procedure TBaseForm.SetChildMaxsize;
begin
  WindowState := TWindowState.wsMaximized;
end;

procedure TBaseForm.SetChildNormalSize;
begin
 WindowState := TWindowState.wsNormal;
end;

///// Alternate to ShowWindow uses code in after construction for fformstate
//procedure TBaseForm.ChangeMDIVisiblity(const bShow: Boolean);
//begin
//  if bShow then
//  Include(FFormState,fsVisible)
//  else
//  Exclude(FFormState, fsVisible);
//end;

/// just calling this seemed to work
//procedure TBaseForm.AfterConstruction;
//begin

////  Exclude(FFormState, fsVisible);
//  inherited;
//
//end;

procedure TBaseForm.ShowForm(const AShow: Boolean);
begin
  If not IsWindow(Handle) then exit;
  if AShow then
    ShowWindow(Handle, SW_SHOW)
  else

  //  CloseWindow(Handle);
   ShowWindow(Handle,SW_SHOWMINIMIZED);// SW_MINIMIZE);
end;

end.
