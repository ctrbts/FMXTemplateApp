unit uMain;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.Generics.Collections,
  System.ImageList,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.StdCtrls,
  FMX.MultiView,
  FMX.ImgList,
  FMX.Objects,
  FMX.Layouts,
  FMX.DialogService,
  FMX.Controls.Presentation;

type
  TfMain = class(TForm)
    mvMenu: TMultiView;
    StyleLight: TStyleBook;
    mnuInicio: TSpeedButton;
    ImageList: TImageList;
    lyClient: TLayout;
    btnExit: TSpeedButton;
    btnCloseMenu: TSpeedButton;
    lyTopMain: TLayout;
    rtBackTop: TRectangle;
    Layout2: TLayout;
    btnMenu: TButton;
    btnProfile: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure MenuClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure btnProfileClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function MsgBox(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons:
      TMsgDlgButtons; const ADefaultButton: TMsgDlgBtn): Integer;
  end;

var
  fMain: TfMain;

implementation

uses
  uLogin,
  uPerfil;

{$R *.fmx}

function TfMain.MsgBox(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons:
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

procedure TfMain.btnProfileClick(Sender: TObject);
begin
  ShowPerfil();
end;

procedure TfMain.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  // evita el retroceso y ocultamiento en entornos mobiles
  if (Key = vkHardwareBack) or (Key = vkHome) then
    Key := 0;
end;

procedure TfMain.MenuClick(Sender: TObject);
var
  Itens: TEnumerator<TCustomForm>;
begin
  case TSpeedButton(Sender).Tag of
    1:
      ShowLogin();
    10:
      Application.Terminate;
  end;

  mvMenu.HideMaster;
end;

end.

