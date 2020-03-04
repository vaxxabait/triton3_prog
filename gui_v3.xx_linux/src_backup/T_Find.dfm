object FindRepDlg: TFindRepDlg
  Left = 313
  Top = 301
  HelpContext = 740
  ActiveControl = FindText
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Поиск  и  замена'
  ClientHeight = 137
  ClientWidth = 369
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
    Top = 14
    Width = 34
    Height = 13
    Caption = 'Найти:'
  end
  object Label2: TLabel
    Left = 8
    Top = 46
    Width = 68
    Height = 13
    Caption = 'Заменить на:'
  end
  object FindButton: TButton
    Left = 280
    Top = 8
    Width = 81
    Height = 25
    Caption = '&Найти'
    Default = True
    ModalResult = 1
    TabOrder = 4
  end
  object CancelButton: TButton
    Left = 280
    Top = 104
    Width = 81
    Height = 25
    Cancel = True
    Caption = 'Отмена'
    ModalResult = 2
    TabOrder = 7
  end
  object FindText: TEdit
    Left = 80
    Top = 10
    Width = 185
    Height = 23
    Hint = 'Данные для поиска в HEX или ASCII формате'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnChange = FindTextChange
    OnEnter = FindTextEnter
    OnKeyPress = FindTextKeyPress
  end
  object ReplaceText: TEdit
    Left = 80
    Top = 42
    Width = 185
    Height = 23
    Hint = 'Данные для замены в HEX или ASCII формате'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnChange = ReplaceTextChange
    OnEnter = ReplaceTextEnter
    OnKeyPress = FindTextKeyPress
  end
  object ReplaceButton: TButton
    Left = 280
    Top = 40
    Width = 81
    Height = 25
    Caption = '&Заменить'
    Enabled = False
    ModalResult = 6
    TabOrder = 5
  end
  object ReplaceAllButton: TButton
    Left = 280
    Top = 72
    Width = 81
    Height = 25
    Caption = 'Заменить &Все'
    Enabled = False
    ModalResult = 10
    TabOrder = 6
  end
  object AsciiHex: TRadioGroup
    Left = 8
    Top = 72
    Width = 113
    Height = 57
    Hint = 'Формат данных (определяет в каком виде вводятся данные для поиска)'
    Caption = '&Формат данных  '
    ItemIndex = 1
    Items.Strings = (
      'ASCII'
      'HEX'
    )
    TabOrder = 2
    OnClick = AsciiHexClick
  end
  object GroupBox1: TGroupBox
    Left = 128
    Top = 72
    Width = 137
    Height = 57
    Caption = '&Поиск  '
    TabOrder = 3
    object FindStart: TCheckBox
      Left = 8
      Top = 14
      Width = 121
      Height = 17
      Hint = 'Определяет стартовый адрес поиска или замены'
      Caption = 'С позиции курсора'
      TabOrder = 0
    end
    object Matchcase: TCheckBox
      Left = 8
      Top = 34
      Width = 121
      Height = 17
      Hint = 'Поиск с учетом регистра (только для данных, введенных в ASCII формате)'
      Caption = 'С учетом регистра'
      TabOrder = 1
    end
  end
end
