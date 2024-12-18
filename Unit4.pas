unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  BaseForm, Vcl.StdCtrls, Vcl.Menus;

type
  TForm4 = class(TBaseForm)
    ComboBox1: TComboBox;
    MainMenu1: TMainMenu;
    mFour: TMenuItem;
    mReg: TMenuItem;
    mBig: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
//    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure mBigClick(Sender: TObject);
    procedure mRegClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //Action := TCloseAction.caFree;
  //FreeAndNil(Self);
  //Destroy;
    Action := caFree;

end;

//procedure TForm4.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
//begin
//end;

//Action := caFree;

procedure TForm4.mBigClick(Sender: TObject);
begin
  SetChildMaxsize;
end;

procedure TForm4.mRegClick(Sender: TObject);
begin
  SetChildNormalSize;
end;

end.
