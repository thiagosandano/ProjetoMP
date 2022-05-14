program ProvaMP;

uses
  Vcl.Forms,
  uspBaixarArquivos in 'uspBaixarArquivos.pas' {fspBaixarArquivos},
  uspConect in 'uspConect.pas' {fspConect: TDataModule},
  spDML in 'spDML.pas',
  spTipos in 'spTipos.pas',
  spHistoricoDownload in 'spHistoricoDownload.pas' {fspHistoricoDownload},
  uspThread in 'uspThread.pas',
  spFuncoesThread in 'spFuncoesThread.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfspBaixarArquivos, fspBaixarArquivos);
  Application.CreateForm(TfspConect, fspConect);
  Application.CreateForm(TfspHistoricoDownload, fspHistoricoDownload);
  Application.Run;
end.
