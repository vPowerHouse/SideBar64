unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  BaseForm, Vcl.StdCtrls, Vcl.Menus;

type
  TForm2 = class(TBaseForm)
    ComboBox1: TComboBox;
    MainMenu1: TMainMenu;
    mTwo: TMenuItem;
    mReg: TMenuItem;
    mBig: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mBigClick(Sender: TObject);
    procedure mRegClick(Sender: TObject);
  end;

//var
//  Form2: TForm2;

implementation

{$R *.dfm}

uses
  Unit1;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TForm2.mBigClick(Sender: TObject);
begin
  SetChildMaxSize;
end;

procedure TForm2.mRegClick(Sender: TObject);
begin
  SetChildNormalSize
end;

{ TForm2 }

end.
