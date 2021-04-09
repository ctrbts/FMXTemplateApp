program SingleForm;

uses
  System.StartUpCopy,
  FMX.Forms,
  uLogin in 'uLogin.pas' {fLogin},
  uMain in 'uMain.pas' {fMain},
  uPerfil in 'uPerfil.pas' {fPerfil};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
