object AboutForm: TAboutForm
  Left = 357
  Top = 233
  BorderStyle = bsDialog
  Caption = 'Info über Enigma...'
  ClientHeight = 323
  ClientWidth = 314
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 120
    Top = 288
    Width = 75
    Height = 25
    Caption = '&Ok'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Panel1: TPanel
    Left = 8
    Top = 16
    Width = 297
    Height = 257
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object Label1: TLabel
      Left = 32
      Top = 16
      Width = 232
      Height = 75
      Caption = 'Enigma'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -64
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 132
      Top = 112
      Width = 33
      Height = 19
      Caption = 'V1.0'
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsItalic]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 131
      Top = 152
      Width = 36
      Height = 37
      Caption = 'by'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 56
      Top = 208
      Width = 185
      Height = 36
      Caption = 'Jörn Franke'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -32
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 104
      Top = 160
      Width = 20
      Height = 27
      Caption = 'ã'
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Symbol'
      Font.Style = []
      ParentFont = False
    end
  end
end
