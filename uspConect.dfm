object fspConect: TfspConect
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 150
  Width = 215
  object fdConexao: TFDConnection
    ConnectionName = 'sqliteConection'
    Params.Strings = (
      
        'Database=C:\Users\Thiago\Documents\Embarcadero\Studio\Projects\S' +
        'PPROVA.db'
      'ConnectionDef=SQLite_Demo')
    Connected = True
    LoginPrompt = False
    Left = 40
    Top = 24
  end
  object qryLog: TFDQuery
    Connection = fdConexao
    SQL.Strings = (
      'select l.codigo'
      '     , l.url'
      '     , cast(l.datainicio as varchar(10)) as datainicio'
      '     , cast(l.datafim as varchar(10)) as datafim'
      '  from logdownload l'
      ' where 1=1')
    Left = 104
    Top = 24
    object qryLogCODIGO: TFMTBCDField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Precision = 22
      Size = 0
    end
    object qryLogURL: TStringField
      FieldName = 'URL'
      Origin = 'URL'
      Size = 600
    end
    object qryLogdatainicio: TWideStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Data Inicio'
      FieldName = 'datainicio'
      Origin = 'datainicio'
      ProviderFlags = []
      ReadOnly = True
      Size = 32767
    end
    object qryLogdatafim: TWideStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Data Fim'
      FieldName = 'datafim'
      Origin = 'datafim'
      ProviderFlags = []
      ReadOnly = True
      Size = 32767
    end
  end
end
