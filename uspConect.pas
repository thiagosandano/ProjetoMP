unit uspConect;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, Data.DbxSqlite, Data.SqlExpr, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TfspConect = class(TDataModule)
    fdConexao: TFDConnection;
    qryLog: TFDQuery;
    qryLogCODIGO: TFMTBCDField;
    qryLogURL: TStringField;
    qryLogdatainicio: TWideStringField;
    qryLogdatafim: TWideStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fspConect: TfspConect;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TfspConect.DataModuleCreate(Sender: TObject);
begin
   fdConexao.Connected := True;
end;

end.
