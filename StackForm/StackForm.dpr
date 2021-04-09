program StackForm;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {fMain},
  uText in 'uText.pas' {fText},
  uPalette in 'uPalette.pas' {fPalette};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
