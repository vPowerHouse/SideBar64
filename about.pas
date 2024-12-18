unit about;

interface

uses Winapi.Windows, System.Classes, Vcl.Graphics, Vcl.Forms, Vcl.Controls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TAboutBox = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    Comments: TLabel;
    ListBox1: TListBox;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  AboutBox: TAboutBox;

implementation

{$R *.dfm}


procedure TAboutBox.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TAboutBox.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;


{ TAboutBox }

end.

