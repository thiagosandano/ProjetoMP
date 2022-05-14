object fspConexao: TfspConexao
  Left = 0
  Top = 0
  Caption = 'fspConexao'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object fdConexao: TFDConnection
    ConnectionName = 'sqliteConection'
    Params.Strings = (
      'User_Name=softplan'
      'Password=softplan'
      'ConnectionDef=SQLite_Demo')
    Left = 88
    Top = 24
  end
end
