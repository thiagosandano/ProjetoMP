unit spDML;

interface

uses
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, spTipos, uspConect, Dialogs, System.SysUtils, VCL.Forms;

  procedure SalvarDadosDownload(DadosDownload: TDadosDownload);


implementation

{ TspDML }

procedure SalvarDadosDownload(DadosDownload: TDadosDownload);
var
   qryAux: TFDQuery;
begin
   try
      qryAux := TFDQuery.Create(nil);
      qryAux.SQL.Clear;

      qryAux.Connection     := fspConect.fdConexao;
      qryAux.ConnectionName := 'sqliteConection';

      qryAux.SQL.Text := 'insert into logdownload( codigo' +#13#10+
                         '                         , url' +#13#10+
                         '                         , datainicio' +#13#10+
                         '                         , datafim' +#13#10+
                         '                         ) Values (' +#13#10+
                         '                         (select coalesce(max(codigo),0) + 1 from logdownload l)' +#13#10+
                         '                         , ' + QuotedStr(DadosDownload.sURL) +#13#10+
                         '                         , ' + QuotedStr(DadosDownload.sDataInicio) +#13#10+
                         '                         , ' + QuotedStr(DadosDownload.sDataFim)+ ')';

      qryAux.ExecSQL;
      except
      on e:Exception do
      begin
         raise Exception.Create(Pchar('Erro ' + e.Message));
      end;
   end;
end;

end.
