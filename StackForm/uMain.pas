unit uMain;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.Generics.Collections,
  System.Actions,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.DialogService.Async,
  FMX.StdCtrls,
  FMX.MultiView,
  FMX.Controls.Presentation,
  FMX.Layouts,
  FMX.ActnList,
  FMX.Objects,
  FMX.Effects,
  FMX.Platform,
  System.ImageList,
  FMX.ImgList;

type
  TfMain = class(TForm)
    BtnBack: TButton;
    BtnMenu: TButton;
    MVMenu: TMultiView;
    PContent: TPanel;
    btnCloseMenu: TButton;
    Button1: TSpeedButton;
    Button2: TSpeedButton;
    ToolbarTitle: TLabel;
    lyMain: TLayout;
    StyleBook: TStyleBook;
    BottomBar: TGridPanelLayout;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    TopBar: TLayout;
    SpeedButton4: TSpeedButton;
    ImageList: TImageList;
    lyMenuTop: TLayout;
    procedure BtnBackClick(Sender: TObject);
    procedure btnCloseMenuClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure BottomBarClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
  private
    { Private declarations }
    // stack mobile object list
    FFrmList: TObjectList<TCustomForm>;

    // stack mobile procedures
    procedure CreateForm(ClassForm: TFmxObjectClass);
    procedure PushForm(AForm: TCustomForm);
    procedure PopForm;
    procedure FreeForm;
  public
    { Public declarations }

    // stack mobile model
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  fMain: TfMain;

implementation

{$R *.fmx}

uses
  FMX.DialogService, // to use messages
  uPalette,
  uText;

{$REGION 'Create a stack mobile (push & pop forms into a layout)'}

constructor TfMain.Create(AOwner: TComponent);
begin
  inherited;

  // create forms container
  FFrmList := TObjectList<TCustomForm>.Create;
end;

destructor TfMain.Destroy;
begin
  // destroy forms and container
  if Assigned(FFrmList) then
    FreeAndNil(FFrmList);

  inherited;
end;

procedure TfMain.CreateForm(ClassForm: TFmxObjectClass);
var
  AForm: TCustomForm;
begin
  inherited;

  // create form
  AForm := ClassForm.Create(Self) as TCustomForm;

  // asign to a form name based in datetime system
  // AForm.Name := AForm.Name + FormatDateTime('hhnnssmm', Now);
  PushForm(AForm);

  // update controls
  MVMenu.HideMaster;
  BtnMenu.Visible := False;
  BtnBack.Visible := True;
end;

procedure TfMain.PushForm(AForm: TCustomForm);
begin
  // if exists an active form, we return the references
  if FFrmList.Count > 0 then
  begin
    while PContent.ChildrenCount > 0 do
      PContent.Children[0].Parent := FFrmList.Items[FFrmList.Count - 1];
  end;

  // adds new form to the stack
  FFrmList.Add(AForm);

  // we assign new references to the principal container
  while AForm.ChildrenCount > 0 do
    AForm.Children[0].Parent := PContent;

  // if are any other container set up first this
  PContent.BringToFront;
end;

procedure TfMain.PopForm;
var
  AForm: TCustomForm;
begin
  // if don't have stack forms, bye bye
  if FFrmList.Count = 0 then
    Exit;

  // we return parent references
  while PContent.ChildrenCount > 0 do
    PContent.Children[0].Parent := FFrmList.Items[FFrmList.Count - 1];

  // unstack last shown form
  FFrmList.Delete(FFrmList.Count - 1);

  // if any form is into the stack
  if FFrmList.Count > 0 then
  begin
    // get last form
    AForm := FFrmList.Items[FFrmList.Count - 1];

    // put new references to the principal container
    while AForm.ChildrenCount > 0 do
      AForm.Children[0].Parent := PContent;
  end;
end;

procedure TfMain.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  // assign virtual or fisical back button action
  if Key = vkHardwareBack then
  begin
    Key := 0;
    FreeForm
  end;
end;

procedure TfMain.FormShow(Sender: TObject);
begin
  BtnMenu.Visible := True;
  BtnBack.Visible := False;
end;

procedure TfMain.FreeForm;
begin
  // if is a last form, update menus
  if FFrmList.Count = 1 then
  begin
    BtnBack.Visible := False;
    BtnMenu.Visible := True;
  end;

  // if exist any visible form, do a pop
  if FFrmList.Count > 0 then
    PopForm;
end;

procedure TfMain.BtnBackClick(Sender: TObject);
begin
  // free visible form
  FreeForm;
end;

procedure TfMain.btnCloseMenuClick(Sender: TObject);
begin
  // hide right menu
  MVMenu.HideMaster;
end;

{$ENDREGION}

procedure TfMain.Button1Click(Sender: TObject);
begin
  // create a child form
  CreateForm(TfPalette);
end;

procedure TfMain.Button2Click(Sender: TObject);
begin
  // create a child form
  CreateForm(TfText);
end;

procedure TfMain.BottomBarClick(Sender: TObject);
begin
  // bottom bar menu
  case (Sender as TSpeedButton).Tag of
    1:
      while FFrmList.Count > 0 do
        FreeForm;
    2:
      ;
    3:
      ;
  end;
end;

procedure TfMain.SpeedButton2Click(Sender: TObject);
begin
  // create a child form
  CreateForm(TfText);
end;

procedure TfMain.SpeedButton3Click(Sender: TObject);
begin
  // create a child form
  CreateForm(TfPalette);
end;

procedure TfMain.SpeedButton4Click(Sender: TObject);
begin
  Halt;
end;

end.
