unit spHistoricoDownload;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, uspConect,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfspHistoricoDownload = class(TForm)
    grdLogDownload: TDBGrid;
    dsLog: TDataSource;
    pnFechar: TPanel;
    btnFechar: TButton;
    procedure btnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class procedure AbrirTela(Form: TForm);
  end;

var
  fspHistoricoDownload: TfspHistoricoDownload;

implementation

{$R *.dfm}

class procedure TfspHistoricoDownload.AbrirTela(Form: TForm);
begin
  inherited;

  fspHistoricoDownload := TfspHistoricoDownload.Create(Form);

  fspHistoricoDownload.Show;
end;

procedure TfspHistoricoDownload.btnFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TfspHistoricoDownload.FormShow(Sender: TObject);
begin
   fspConect.qryLog.Open;
end;

end.
