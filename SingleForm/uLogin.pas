unit uLogin;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.StdCtrls,
  FMX.Objects,
  FMX.Edit,
  FMX.Layouts,
  FMX.Controls.Presentation,
  FMX.Ani,
  FMX.Effects;

type
  TfLogin = class(TForm)
    HorzCenterLayout: TLayout;
    imgBackground: TImage;
    btnLogin: TButton;
    VertCenterLayout: TLayout;
    rtFondo: TRectangle;
    procedure btnLoginClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function ShowLogin(): TfLogin;

var
  fLogin: TfLogin;

implementation

uses
  uMain;

{$R *.fmx}

function ShowLogin(): TfLogin;
begin
  if Assigned(fLogin) then
    fLogin.Free;

  fLogin := TfLogin.Create(Application);
  while fLogin.ChildrenCount > 0 do
    fLogin.Children[0].Parent := fMain.lyClient;

  fMain.lyClient.BringToFront;
  Result := fLogin;
end;

procedure TfLogin.btnLoginClick(Sender: TObject);
begin
  FreeAndNil(fLogin);
end;

end.

