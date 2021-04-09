unit uPerfil;

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
  FMX.Controls.Presentation,
  FMX.Objects,
  FMX.Layouts,
  FMX.DialogService;

type
  TfPerfil = class(TForm)
    VertScrollBox1: TVertScrollBox;
    HeaderLayout: TLayout;
    BackgroundRect: TRectangle;
    lyMenu: TLayout;
    btnBack: TButton;
    rbBackground: TRectangle;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    StyleBook: TStyleBook;
    procedure btnBackClick(Sender: TObject);
  private
    { Private declarations }
    function MsgBox(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons:
      TMsgDlgButtons; const ADefaultButton: TMsgDlgBtn): Integer;
  public
    { Public declarations }
  end;

function ShowPerfil(): TfPerfil;

var
  fPerfil: TfPerfil;

implementation

uses
  uMain;

{$R *.fmx}

function ShowPerfil(): TfPerfil;
begin
  if Assigned(fPerfil) then
    fPerfil.Free;

  fPerfil := TfPerfil.Create(Application);
  while fPerfil.ChildrenCount > 0 do
    fPerfil.Children[0].Parent := fMain.lyClient;

  fMain.lyClient.BringToFront;
  Result := fPerfil;
end;

function TfPerfil.MsgBox(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons:
  TMsgDlgButtons; const ADefaultButton: TMsgDlgBtn): Integer;
var
  mr: TModalResult;
begin
  mr := mrNone;
  // standart call with callback anonimous method
  TDialogService.MessageDialog(AMessage, ADialogType, AButtons, ADefaultButton, 0,
    procedure(const AResult: TModalResult)
    begin
      mr := AResult
    end);

  while mr = mrNone do // wait for modal result
    Application.ProcessMessages;
  Result := mr;
end;

procedure TfPerfil.btnBackClick(Sender: TObject);
begin
  FreeAndNil(fPerfil);
end;

end.

