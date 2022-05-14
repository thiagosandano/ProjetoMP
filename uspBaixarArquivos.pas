unit uspBaixarArquivos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Vcl.StdCtrls,
  Vcl.DBCtrls, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.FMTBcd,
  Data.SqlExpr, uspConect, Vcl.ExtCtrls, System.Actions, Vcl.ActnList,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent, winApi.UrlMon,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, System.StrUtils,
  Vcl.ComCtrls, IdAntiFreezeBase, IdAntiFreeze, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, Vcl.Imaging.pngimage, spTipos, spDML, System.Threading,
  Vcl.Imaging.jpeg, spHistoricoDownload, spFuncoesThread;

type
  TfspBaixarArquivos = class(TForm)
    Panel1: TPanel;
    btnIniciarDownload: TButton;
    btnExibirMensagem: TButton;
    btnFinalizarDownload: TButton;
    lblUrl: TLabel;
    edtUrl: TMemo;
    ActionList1: TActionList;
    actIniciarDownload: TAction;
    Cliente: TIdHTTP;
    actFinalizarDownload: TAction;
    pbProgresso: TProgressBar;
    lblStatus: TLabel;
    dlgSave: TSaveDialog;
    IdAntiFreeze1: TIdAntiFreeze;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    actExibirMensagem: TAction;
    Image1: TImage;
    Button1: TButton;
    actMostrarHistorico: TAction;
    Button2: TButton;
    actFechar: TAction;
    procedure actFinalizarDownloadExecute(Sender: TObject);
    procedure ClienteWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
    procedure ClienteWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure ClienteWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure actIniciarDownloadExecute(Sender: TObject);
    procedure actExibirMensagemExecute(Sender: TObject);
    procedure actMostrarHistoricoExecute(Sender: TObject);
    procedure actFecharExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    dDataInicio: TDate;
    FProgressBarTempo: TProgressBarTempo;
    FuncoesThread: TspFuncoesThread;
    fValorTotalDownload: Double;
    function PorcentagemPercorrida(fValorTotal, fValorAtual: Double): string;
    function RetornarTamanho(fValorAtual: Double): String;
    procedure SalvarDownload;
    procedure CancelarDownload;
  public
    { Public declarations }
  end;

var
  fspBaixarArquivos: TfspBaixarArquivos;

implementation

{$R *.dfm}

procedure TfspBaixarArquivos.actExibirMensagemExecute(Sender: TObject);
begin
   Application.MessageBox(pChar(fspBaixarArquivos.Caption), 'Download de Arquivos', MB_OK);
end;

procedure TfspBaixarArquivos.actFecharExecute(Sender: TObject);
begin
   if actIniciarDownload.Enabled then
      Close
   else
   if Application.MessageBox('Existe um Download em andamento, deseja realmente cancelar?', 'Download de Arquivos', MB_YESNO) = ID_YES then
   begin
      CancelarDownload;
      Close;
   end;
end;

procedure TfspBaixarArquivos.actFinalizarDownloadExecute(Sender: TObject);
begin
   CancelarDownload;
   actIniciarDownload.Enabled := True;
   FuncoesThread.LiberarThreads;
end;

procedure TfspBaixarArquivos.actIniciarDownloadExecute(Sender: TObject);
var
   fileDownload : TFileStream;
begin
   FuncoesThread                   := TspFuncoesThread.Create;
   FProgressBarTempo.ProgressBar   := pbprogresso;

   dlgSave.Filter             := ExtractFileExt(edtUrl.Text) + '|*' + ExtractFileExt(edtUrl.Text);
   dlgSave.FileName           := 'Arquivo Baixado';
   actIniciarDownload.Enabled := False;
   Cliente.Request.UserAgent  := 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20100101 Firefox/12.0';

   if dlgSave.Execute then
   begin
      try
         try
            dDataInicio         := Date;
            fileDownload        := TFileStream.Create(dlgSave.FileName + ExtractFileExt(edtUrl.Text), fmCreate);
            pbprogresso.Visible := True;
            lblStatus.Visible   := True;

            Cliente.Get(Trim(edtUrl.Text), fileDownload);
         finally
            FreeAndNil(fileDownload);
            actIniciarDownload.Enabled := True;
            SalvarDownload;
         end;
      except
          on e:Exception do
          begin
            raise Exception.Create(Pchar('Erro ' + e.Message));
          end;
      end;
   end;
end;

procedure TfspBaixarArquivos.actMostrarHistoricoExecute(Sender: TObject);
begin
   TfspHistoricoDownload.AbrirTela(Self);
end;

procedure TfspBaixarArquivos.CancelarDownload;
begin
   lblStatus.Caption := 'Download Cancelado';
   Cliente.Disconnect;
end;

procedure TfspBaixarArquivos.ClienteWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
begin
   FProgressBarTempo.iTempo := AWorkCount;

   FuncoesThread.IniciarThreads(FProgressBarTempo);

   lblStatus.Caption         := 'Baixando ... ' + RetornarTamanho(AWorkCount);
   fspBaixarArquivos.Caption := 'Download em ... ' + PorcentagemPercorrida(fValorTotalDownload, AWorkCount);
end;

procedure TfspBaixarArquivos.ClienteWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
   FProgressBarTempo.ProgressBar.Max := AWorkCountMax;

   //FuncoesThread.IniciarThreads(FProgressBarTempo);

   fValorTotalDownload := AWorkCountMax;
end;

procedure TfspBaixarArquivos.ClienteWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
   pbprogresso.Position      := 0;
   fspBaixarArquivos.Caption := 'Finalizado ...';
   pbprogresso.Visible       := False;
   lblStatus.Caption         := 'Download Finalizado ...';
end;

procedure TfspBaixarArquivos.FormClose(Sender: TObject;var Action: TCloseAction);
begin
  FuncoesThread.LiberarThreads;
end;

function TfspBaixarArquivos.PorcentagemPercorrida(fValorTotal, fValorAtual: Double): string;
begin
   Result := FloatToStr(((fValorAtual * 100) / fValorTotal));
   Result := FormatFloat('0%', StrToFloatDef(Result, 0));
end;

function TfspBaixarArquivos.RetornarTamanho(fValorAtual: Double): String;
begin
   Result := FloatToStr((fValorAtual / 1024) / 1024);
   Result := FormatFloat('0.000 KBs', StrToFloatDef(Result, 0));
end;

procedure TfspBaixarArquivos.SalvarDownload;
var
   DadosDownload: TDadosDownload;
begin
   DadosDownload.sURL        := edtURL.Text;
   DadosDownload.sDataInicio := DateToStr(dDataInicio);
   DadosDownload.sDataFim := DateToStr(Date);

   spDML.SalvarDadosDownload(DadosDownload);
end;

end.
