unit uPalette;

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
  FMX.Controls.Presentation,
  FMX.StdCtrls;

type
  TfPalette = class(TForm)
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fPalette: TfPalette;

implementation

{$R *.fmx}

uses
  uMain;

end.
