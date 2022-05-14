object fspHistoricoDownload: TfspHistoricoDownload
  Left = 0
  Top = 0
  Caption = 'Hist'#243'rido de Downloads'
  ClientHeight = 507
  ClientWidth = 1039
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object grdLogDownload: TDBGrid
    Left = 0
    Top = 0
    Width = 1039
    Height = 466
    Align = alClient
    DataSource = dsLog
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'CODIGO'
        Width = 48
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'URL'
        Width = 847
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'datainicio'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'datafim'
        Width = 64
        Visible = True
      end>
  end
  object pnFechar: TPanel
    Left = 0
    Top = 466
    Width = 1039
    Height = 41
    Align = alBottom
    TabOrder = 1
    ExplicitLeft = 536
    ExplicitTop = 408
    ExplicitWidth = 185
    object btnFechar: TButton
      Left = 480
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Fechar'
      TabOrder = 0
      OnClick = btnFecharClick
    end
  end
  object dsLog: TDataSource
    DataSet = fspConect.qryLog
    Left = 1000
    Top = 424
  end
end
