unit uspThread;

interface

uses
  System.Classes, Windows, Vcl.ComCtrls;

type
  spThread = class(TThread)
  private
     FTempo: integer;
     FProgressBar: TProgressBar;
  protected
    procedure AtualizarProgressBar(iConcluido: integer);
    procedure Execute; override;
  public
    constructor Create(ProgressBar: TProgressBar; iTempo: integer);

    class function Criar(ProgressBar: TProgressBar; iTempo: integer): spThread;
  end;

implementation

{ spThread }

procedure spThread.AtualizarProgressBar(iConcluido: integer);
begin
  FProgressBar.Position := iConcluido;
  Self.Sleep(FTempo);
end;

constructor spThread.Create(ProgressBar: TProgressBar; iTempo: integer);
begin
  inherited Create(False);

  Self.FreeOnTerminate := True;
  FProgressBar         := ProgressBar;
  FTempo               := iTempo;
end;

class function spThread.Criar(ProgressBar: TProgressBar; iTempo: integer): spThread;
begin
  Result := spThread.Create(ProgressBar, iTempo);
end;

procedure spThread.Execute;
var
  i: integer;
begin
  inherited;

  i := 0;
  while (i < 100) and not Terminated do
  begin
    Inc(i);

    Self.AtualizarProgressBar(FTempo);
  end;
end;

end.
