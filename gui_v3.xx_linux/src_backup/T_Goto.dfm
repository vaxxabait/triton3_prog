object GotoDlg: TGotoDlg
  Left = 525
  Top = 347
  ActiveControl = GotoText
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Переход по адресу'
  ClientHeight = 72
  ClientWidth = 196
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
    Width = 73
    Height = 13
    Caption = 'Новый  адрес:'
  end
  object OKBtn: TButton
    Left = 16
    Top = 40
    Width = 75
    Height = 25
    Caption = 'Перейти'
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 1
  end
  object CancelBtn: TButton
    Left = 104
    Top = 40
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Отмена'
    ModalResult = 2
    TabOrder = 2
  end
  object GotoText: TEdit
    Left = 104
    Top = 10
    Width = 81
    Height = 21
    Hint = 'Новый адрес в шестнадцатеричном формате'
    AutoSize = False
    CharCase = ecUpperCase
    MaxLength = 6
    TabOrder = 0
    OnChange = GotoTextChange
    OnKeyPress = FormKeyPress
  end
end
