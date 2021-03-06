object FunctionDlg: TFunctionDlg
  Left = 333
  Top = 319
  ActiveControl = MaskEditBegin
  BorderStyle = bsDialog
  Caption = 'Функция над блоком'
  ClientHeight = 145
  ClientWidth = 321
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 56
    Height = 13
    Caption = 'Фрагмент:'
  end
  object Label2: TLabel
    Left = 216
    Top = 16
    Width = 36
    Height = 13
    Caption = 'Маска '
  end
  object OKBtn: TButton
    Left = 232
    Top = 80
    Width = 81
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 4
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 232
    Top = 112
    Width = 81
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 5
  end
  object RadioGroup1: TRadioGroup
    Left = 8
    Top = 40
    Width = 217
    Height = 97
    Hint = 'Логическая операция над выделенным фрагментом и байтом-маской'
    Caption = 'Функция  '
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      '&AND'
      '&OR'
      '&XOR'
      'NO&T'
      'NAN&D'
      'NO&R'
      'X&NOR'
      '&FILL'
    )
    TabOrder = 3
    OnClick = RadioGroup1Click
  end
  object MaskEditFinal: TMaskEdit
    Left = 144
    Top = 8
    Width = 53
    Height = 25
    Hint = 'Конечный адрес блока'
    AutoSize = False
    CharCase = ecUpperCase
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Courier New'
    Font.Style = []
    MaxLength = 6
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 1
    OnKeyPress = MaskEditKeyPress
  end
  object MaskEditBegin: TMaskEdit
    Left = 80
    Top = 8
    Width = 53
    Height = 25
    Hint = 'Начальный адрес блока'
    AutoSize = False
    CharCase = ecUpperCase
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Courier New'
    Font.Style = []
    MaxLength = 6
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 0
    OnKeyPress = MaskEditKeyPress
  end
  object MaskEditMask: TMaskEdit
    Left = 264
    Top = 8
    Width = 41
    Height = 25
    Hint = 'Байт-маска для логических операций или для заливки '
    AutoSize = False
    CharCase = ecUpperCase
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Courier New'
    Font.Style = []
    MaxLength = 2
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 2
    OnKeyPress = MaskEditKeyPress
  end
end
