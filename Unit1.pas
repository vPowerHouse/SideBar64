unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    MainMenu: TMainMenu;
    FileMenu: TMenuItem;
    FileDesktop1: TMenuItem;
    FileDesktop2: TMenuItem;
    procedure FileDesktop1Click(Sender: TObject);
    procedure FileDesktop2Click(Sender: TObject);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  BaseForm, Unit2, Unit4;

procedure TForm1.FileDesktop1Click(Sender: TObject);
begin
//  if form2 <> nil then



//  if not assigned(Form2) then
//    Form2 := TForm2.Create(Application)
//  else Form2.Show;
//  if Assigned(Form4) then
//      /// ---------------------------
//      ///"Cannot hide an MDI Child Form"
//      ///Form4.Hide;
//    Form4.showForm(False);

end;

procedure TForm1.FileDesktop2Click(Sender: TObject);
begin
//  if not Assigned(Form4) then
//    Form4 := TForm4.Create(Application)
//  else form4.Show;
//
//  if Assigned(Form2) then
//    Form2.showForm(False);
end;

end.
