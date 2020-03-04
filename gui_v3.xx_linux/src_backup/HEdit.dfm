object HexEdit: THexEdit
  Left = 439
  Top = 54
  Width = 569
  Height = 382
  HelpContext = 530
  HorzScrollBar.Visible = False
  Caption = 'HEX  Editor'
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Courier New'
  Font.Style = []
  FormStyle = fsMDIChild
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000088888888888888888800000000000
    0008FFFFFFFFFFFFFFFF8000000000000008FFFFFFFFFFFFFFFF800000000000
    0008FFFFFFFFFFFFFFFF8000000000000008F0000000000000FF800000000000
    0008FFFFFFFFFFFFFFFF8000000000000008FFFFFFFFFFFFFFFF800000000000
    0008F0000000000000FF8000000000000008FFFFFFFFFFFFFFFF800000000000
    0008FFFFFFFFFFFFFFFF8000000000000008F0000000000000FF800000000000
    0008FFFFFFFFFFFFFFFF8000000000000008FFFFFFFFFFFFFFFF800000000000
    0008F0000000000000FF8000000000000008FFFFFFFFFFFFFFFF800000000000
    0008FFFFFFFFFFFFFFFF8000000000000008F0000000000000FF800000000000
    0008FFFFFFFFFFFFFFFF8000000000000008FFFFFFFFFFFFFFFF800000000000
    0008F0000000000000FF8000000000000008FFFFFFFFFFFFFFFF800000000000
    0008FFFFFFFFFFFFFFFF8000000000000008FF44EFFFFFFF8888800000000000
    0008F44E4F4444448FFF8000000000000008FF44FFFFFFFF8FF8000000000000
    0008FFFFFFFFFFFF8F8000000000000000088888888888888800000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    FFFFFFFFFFFFFF00003FFE00003FFE00003FFE00003FFE00003FFE00003FFE00
    003FFE00003FFE00003FFE00003FFE00003FFE00003FFE00003FFE00003FFE00
    003FFE00003FFE00003FFE00003FFE00003FFE00003FFE00003FFE00003FFE00
    003FFE00003FFE00007FFE0000FFFE0001FFFE0003FFFFFFFFFFFFFFFFFF
  }
  Menu = MainMenu1
  PopupMenu = PopupMenu1
  Position = poDefaultPosOnly
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 561
    Height = 336
    Align = alClient
    BevelInner = bvLowered
    BevelOuter = bvLowered
    BorderWidth = 2
    TabOrder = 0
  end
  object MainMenu1: TMainMenu
    Left = 16
    Top = 16
    object EditMenu: TMenuItem
      Caption = '&Правка'
      GroupIndex = 20
      Hint = 'Команды встроенного редактора'
      OnClick = EditMenuClick
      object EditUndoItem: TMenuItem
        Caption = '&Отменить'
        Enabled = False
        Hint = 'Отмена последнего действия в редакторе'
        ShortCut = 16474
        OnClick = EditUndoItemClick
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object EditDelItem: TMenuItem
        Caption = '&Удалить'
        Hint = 'Удаление выделенного фрагмента или байта в позиции курсора'
        ShortCut = 46
        OnClick = EditDelItemClick
      end
      object EditCutItem: TMenuItem
        Caption = '&Вырезать'
        Enabled = False
        Hint = 'Удаление выделенного фрагмента в буфер'
        ShortCut = 16472
        OnClick = EditCutItemClick
      end
      object EditCopyItem: TMenuItem
        Caption = '&Копировать'
        Enabled = False
        Hint = 'Копирование выделенного фрагмента в буфер'
        ShortCut = 16451
        OnClick = EditCopyItemClick
      end
      object EditPasteItem: TMenuItem
        Caption = 'Вст&авить'
        Enabled = False
        Hint = 'Вставка содержимого буфера в позицию курсора'
        ShortCut = 16470
        OnClick = EditPasteItemClick
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object EditSelectItem: TMenuItem
        Caption = 'В&ыделить...'
        Hint = 'Команды для выделения фрагмента файла'
        ShortCut = 16449
        OnClick = EditSelectItemClick
      end
      object EditFuncItem: TMenuItem
        Caption = '&Функция...'
        Hint = 'Логические операции над выделенным фраментом'
        OnClick = EditFuncItemClick
      end
      object N8: TMenuItem
        Caption = '-'
      end
      object EditFindItem: TMenuItem
        Caption = 'По&иск и замена...'
        Hint = 'Вывод окна для поиска или замены данных'
        ShortCut = 16454
        OnClick = EditFindItemClick
      end
      object EditNextFindItem: TMenuItem
        Caption = '&Следующий поиск'
        Hint = 'Продолжение поиска с позиции курсора'
        ShortCut = 114
        OnClick = EditNextFindItemClick
      end
      object EditNextReplaceItem: TMenuItem
        Caption = 'Следующая &замена'
        Hint = 'Продолжение поиска и замены данных с позиции курсора'
        ShortCut = 115
        OnClick = EditNextReplaceItemClick
      end
      object N9: TMenuItem
        Caption = '-'
      end
      object EditGotoItem: TMenuItem
        Caption = '&Переход...'
        Hint = 'Переход на новый адрес'
        ShortCut = 16455
        OnClick = EditGotoItemClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object EditFont: TMenuItem
        Caption = '&Шрифт...'
        Hint = 'Вывод окна для выбора шрифта'
        OnClick = EditFontClick
      end
    end
  end
  object PrintDialog1: TPrintDialog
    Options = [poPageNums, poSelection]
    Left = 80
    Top = 16
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 48
    Top = 16
    object PopUndo: TMenuItem
      Caption = '&Отменить'
      Enabled = False
      GroupIndex = 20
      Hint = 'Отмена последнего действия в редакторе'
      ShortCut = 16474
      OnClick = EditUndoItemClick
    end
    object N22: TMenuItem
      Caption = '-'
      GroupIndex = 20
    end
    object PopDel: TMenuItem
      Caption = '&Удалить'
      GroupIndex = 20
      Hint = 'Удаление выделенного фрагмента или байта в позиции курсора'
      ShortCut = 46
      OnClick = EditDelItemClick
    end
    object PopCut: TMenuItem
      Caption = '&Вырезать'
      Enabled = False
      GroupIndex = 20
      Hint = 'Удаление выделенного фрагмента в буфер'
      ShortCut = 16472
      OnClick = EditCutItemClick
    end
    object PopCopy: TMenuItem
      Caption = '&Копировать'
      Enabled = False
      GroupIndex = 20
      Hint = 'Копирование выделенного фрагмента в буфер'
      ShortCut = 16451
      OnClick = EditCopyItemClick
    end
    object PopPaste: TMenuItem
      Caption = 'Вст&авить'
      Enabled = False
      GroupIndex = 20
      Hint = 'Вставка содержимого буфера в позицию курсора'
      ShortCut = 16470
      OnClick = EditPasteItemClick
    end
    object N16: TMenuItem
      Caption = '-'
      GroupIndex = 20
    end
    object PopSel: TMenuItem
      Caption = 'В&ыделить...'
      GroupIndex = 20
      Hint = 'Команды для выделения фрагмента файла'
      ShortCut = 16449
      OnClick = EditSelectItemClick
    end
    object N14: TMenuItem
      Caption = '-'
      GroupIndex = 20
    end
    object PopFind: TMenuItem
      Caption = 'По&иск и замена...'
      GroupIndex = 20
      Hint = 'Вывод окна для поиска или замены данных'
      ShortCut = 16454
      OnClick = EditFindItemClick
    end
    object N10: TMenuItem
      Caption = '-'
      GroupIndex = 20
    end
    object PopGoto: TMenuItem
      Caption = '&Переход...'
      GroupIndex = 20
      Hint = 'Переход на новый адрес'
      ShortCut = 16455
      OnClick = EditGotoItemClick
    end
  end
  object FontDialog: TFontDialog
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    MinFontSize = 0
    MaxFontSize = 0
    Options = [fdFixedPitchOnly, fdForceFontExist]
    Left = 112
    Top = 16
  end
end
