unit CHILDWIN;

interface

uses Winapi.Windows, System.Classes, Vcl.Graphics, Vcl.Forms, Vcl.Controls,
  Vcl.StdCtrls;

type
  TMDIChild = class(TForm)
    Memo1: TMemo;
    //procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

//procedure TMDIChild.Button1Click(Sender: TObject);
//begin
//  ChangeScale(120,96,True);
//end;

procedure TMDIChild.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
