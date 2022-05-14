unit spFuncoesThread;

interface

uses
  uspThread, System.SysUtils, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.ComCtrls;

type
  TProgressBarTempo = record
    ProgressBar: TProgressBar;
    iTempo: integer;
    FThread: TThread;
  end;

  TspFuncoesThread = class
  private
    FprogressBarTempo: TProgressBarTempo;

    procedure SetarComponentes(progressBarTempo: TProgressBarTempo);
    procedure TratarExcecoes;
    procedure CriarThread;
  public
    procedure LiberarThreads;
    procedure IniciarThreads(progressBarTempo: TProgressBarTempo);
  end;


implementation

{ TspFuncoesThread }

procedure TspFuncoesThread.CriarThread;
begin
   FprogressBarTempo.FThread := spThread.Criar(FprogressBarTempo.ProgressBar, FprogressBarTempo.iTempo);
end;

procedure TspFuncoesThread.IniciarThreads(progressBarTempo: TProgressBarTempo);
begin
  SetarComponentes(progressBarTempo);
  LiberarThreads;
  TratarExcecoes;
  CriarThread;
end;

procedure TspFuncoesThread.LiberarThreads;
begin
   if Assigned(FprogressBarTempo.FThread)  then
      FprogressBarTempo.FThread.Terminate;
end;

procedure TspFuncoesThread.SetarComponentes(
  progressBarTempo: TProgressBarTempo);
begin
   FprogressBarTempo := progressBarTempo;
end;

procedure TspFuncoesThread.TratarExcecoes;
begin
 if not Assigned(FProgressBarTempo.ProgressBar) then
    raise Exception.Create('Componente Progress Bar não encontrado');
end;

end.
