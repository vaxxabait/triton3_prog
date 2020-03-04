unit Triton_Main1;

{$MODE Delphi}

interface

uses LCLIntf, LCLType, Forms, Classes, Menus, Buttons, Registry, INIFiles,
  Controls, Dialogs, ComCtrls, StdCtrls, ExtCtrls, FileUtil, SysUtils;

type
  TMain1 = class(TForm)
    MainMenu1: TMainMenu;
    MenuFile: TMenuItem;
    MenuFileLoad: TMenuItem;
    MenuFileSave: TMenuItem;
    MenuFileOpen: TMenuItem;
    N8: TMenuItem;
    MenuFileExit: TMenuItem;
    MenuOpt: TMenuItem;
    MenuOptSelCom: TMenuItem;
    N1: TMenuItem;
    MenuOptAutoWrite: TMenuItem;
    MenuOptClearMemory: TMenuItem;
    N5: TMenuItem;
    MenuOptSQTP: TMenuItem;
    MenuComm: TMenuItem;
    MenuCommBlank: TMenuItem;
    MenuCommSum: TMenuItem;
    MenuCommProg: TMenuItem;
    MenuCommVerify: TMenuItem;
    N19: TMenuItem;
    MenuCommErase: TMenuItem;
    MenuCommEncr: TMenuItem;
    MenuCommLock: TMenuItem;
    MenuHelp: TMenuItem;
    MenuHelpHelp: TMenuItem;
    MenuHelpAbout: TMenuItem;
    MenuCOM11: TMenuItem;
    MenuCOM21: TMenuItem;
    MenuCOM31: TMenuItem;
    MenuCOM41: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    ToolBar: TToolBar;
    OpenButton: TToolButton;
    SaveButton: TToolButton;
    ToolButton1: TToolButton;
    UndoButton: TToolButton;
    CutButton: TToolButton;
    CopyButton: TToolButton;
    PasteButton: TToolButton;
    ToolButton2: TToolButton;
    BlankButton: TToolButton;
    CheckButton: TToolButton;
    RDButton: TToolButton;
    ProgButton: TToolButton;
    VerifyButton: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    SummButton: TToolButton;
    ToolButton5: TToolButton;
    SumStText: TStaticText;
    StatusBar: TStatusBar;
    MenuFileNew: TMenuItem;
    N3: TMenuItem;
    StChipName: TStaticText;
    ToolButton6: TToolButton;
    N4: TMenuItem;
    MenuFileHexToBin: TMenuItem;
    MenuWindow: TMenuItem;
    TileCascade: TMenuItem;
    TileVertical: TMenuItem;
    TileHorizontal: TMenuItem;
    MenuOptSelectChip: TMenuItem;
    MenuFileBufSave: TMenuItem;
    MenuFileBufSaveAs: TMenuItem;
    ImageList1: TImageList;
    FindButton: TToolButton;
    FindNextButton: TToolButton;
    ReplaceButton: TToolButton;
    ToolButton10: TToolButton;
    NewButton: TToolButton;
    N2: TMenuItem;
    MenuOptIniProg: TMenuItem;
    MenuCommRead: TMenuItem;
    procedure ConfigOpen(const AConfigName: string);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ShowHint(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure UpdateMenuItem(Sender: TObject);
    procedure MenuFileClick(Sender: TObject);
    procedure MenuFileNewClick(Sender: TObject);
    procedure MenuFileOpenClick(Sender: TObject);
    procedure MenuFileSaveEdClick(Sender: TObject);
    procedure MenuFileSaveAsClick(Sender: TObject);
    procedure MenuFileLoadClick(Sender: TObject);
    procedure MenuFileSaveClick(Sender: TObject);
    procedure MenuFilePrintClick(Sender: TObject);
    procedure MenuFileHexToBinClick(Sender: TObject);
    procedure MenuFileExitClick(Sender: TObject);
    procedure UndoButtonClick(Sender: TObject);
    procedure CutButtonClick(Sender: TObject);
    procedure CopyButtonClick(Sender: TObject);
    procedure PasteButtonClick(Sender: TObject);
    procedure FindButtonClick(Sender: TObject);
    procedure FindNextButtonClick(Sender: TObject);
    procedure ReplaceButtonClick(Sender: TObject);
    procedure SummButtonClick(Sender: TObject);
    procedure MenuOptClick(Sender: TObject);
    procedure MenuCOM11Click(Sender: TObject);
    procedure MenuCOM21Click(Sender: TObject);
    procedure MenuCOM31Click(Sender: TObject);
    procedure MenuCOM41Click(Sender: TObject);
    procedure MenuOptIniProgClick(Sender: TObject);
    procedure MenuOptAutoWriteClick(Sender: TObject);
    procedure MenuOptClearMemoryClick(Sender: TObject);
    procedure MenuOptSQTPClick(Sender: TObject);
    procedure MenuCommClick(Sender: TObject);
    procedure MenuCommBlankClick(Sender: TObject);
    procedure MenuCommSumClick(Sender: TObject);
    procedure MenuCommReadClick(Sender: TObject);
    procedure MenuCommProgClick(Sender: TObject);
    procedure MenuCommVerifyClick(Sender: TObject);
    procedure MenuCommEraseClick(Sender: TObject);
    procedure MenuCommEncrClick(Sender: TObject);
    procedure MenuCommLockClick(Sender: TObject);
    procedure TileHorizontalClick(Sender: TObject);
    procedure TileVerticalClick(Sender: TObject);
    procedure TileCascadeClick(Sender: TObject);
    procedure MenuHelpAboutClick(Sender: TObject);
    procedure MenuHelpHelpClick(Sender: TObject);
    function FindChildWindow(FN: string): Boolean;
    function CheckNeedDownLoad(ChFileName: string): string;
  private
//    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
//    procedure WMCHILDACTIVATE(var Message: TWMCHILDACTIVATE); message WM_CHILDACTIVATE;
  end;

  function OpenComPort(CodComm, NumPort: Integer): Integer;
  function OpenComPortSearch(CodComm, NumPort: Integer): Integer;
  function ControlCheckSumm(CheckSum: byte): Boolean;
  function HexStrToInt(const S: string): Longint;
  function HexToBinConverter(InFileName: string): Integer;

var
  Main1: TMain1;
  FPort: THandle;
  ChipBlok: array [1..8] of byte;                //Количество м/сх
  BlokPar: array [$0..$FF] of byte;              //Блок параметров
  ProgFileName, EncrFileName: string;            //Имя файла программы и EEPROM
  CodCommand: byte;                              //Код команды
  LoadAdres, BeginAdres, FinalAdres, BuferAdres: Integer;
  MaxAdres, EncrpAdres: Integer;
  CfgWord: array[1..2] of byte;                  //Config WORD for PIC
  CfgWordPic: DWord;
  EEBuf: array[1..2048] of byte;
  SizeEEBufer: Integer;
const
  iCOMPort: Integer = 0;                         //Номер COM порта:0-COM1; 1-COM2
  ComEn: array [1..4] of Boolean = (False,False,False,False);
  ChipName: string = 'No chip  ';
  RamPgm: Integer = 131072;
  ProgrammerEnabled: boolean = False;
  ProgrammerVersion: integer = 0;

implementation

uses  DialogProcess, AboutBox, Triton_prog, HEdit, TextEditor,
  DialogSQTP;

{$R *.lfm}


//procedure TMain1.WMDropFiles(var Msg: TWMDropFiles);
//var
//  CFileName: array[0..MAX_PATH] of Char;
//  FileNameExt: string;
//begin
//  try
//    if DragQueryFile(Msg.Drop, 0, CFileName, MAX_PATH) > 0 then
//    begin
//      FileNameExt := UpperCase(ExtractFileExt(CFileName));
//      if FileNameExt = '.HEX' then with TTextEdit.Create(Self) do Open(CFileName)
//      else with THexEdit.Create(Self) do Open(CFileName);
//      Msg.Result := 0;
//    end;
//  finally DragFinish(Msg.Drop);
//  end;
//end;

//procedure TMain1.WMCHILDACTIVATE(var Message: TWMCHILDACTIVATE);
//begin
//  UpdateMenuItem(Self);
//end;

function OpenComPort(CodComm, NumPort: Integer): Integer;
var
  //DCB: TDCB;
  //COMMTIMEOUTS: TCOMMTIMEOUTS;
  TxdCom: array[1..2] of byte;
  dwSent: DWord;
begin
  Result := 0;
  FPort := FileOpen('/dev/ttyUSB0',fmOpenReadWrite or fmShareDenyWrite);
  if FPort = INVALID_HANDLE_VALUE then Exit;
  //GetCommState(FPort,DCB);
//   DCB.BaudRate := 57600;
//   DCB.ByteSize := 8;
//   DCB.Parity   := NOPARITY;
//   DCB.StopBits := ONESTOPBIT;
//  SetCommState(FPort, DCB);
//  GetCommTimeouts(Fport,COMMTIMEOUTS);
//   COMMTIMEOUTS.ReadIntervalTimeout := 2000;
//   COMMTIMEOUTS.ReadTotalTimeoutMultiplier := 50;
//   COMMTIMEOUTS.ReadTotalTimeoutConstant := 2000;
//   COMMTIMEOUTS.WriteTotalTimeoutMultiplier := 0;
//   COMMTIMEOUTS.WriteTotalTimeoutConstant := 0;
//  SetCommTimeouts(FPort,COMMTIMEOUTS);
  TxdCom[1] := $55;
  TxdCom[2] := CodComm;
  //WriteFile(FPort, TxdCom, 2, dwSent, nil);
  dwSent := FileWrite(FPort, TxdCom, 2);
  //if not ReadFile(FPort,Result,1,dwSent,nil) or (Result<>CodComm) or
    //(Result=$13) or (Result=$1F) or (Result=$1E) then FileClose(FPort);

  dwSent := FileRead(FPort,Result,1);
  if (Result<>CodComm) or
    (Result=$13) or (Result=$1F) or (Result=$1E) then FileClose(FPort);
end;

function OpenComPortSearch(CodComm, NumPort: Integer): Integer;
var
  TxdCom: array[1..3] of byte;
  dwSent: DWord;
  i: integer;
begin
  Result := OpenComPort(CodComm, NumPort);
  if Result <> CodComm then
  begin
    for i := 1 to 3 do TxdCom[i] := 0;
    if FPort <> INVALID_HANDLE_VALUE then
    begin
      //ReadFile(FPort, Result, 1, dwSent, nil);
      dwSent := FileRead(FPort, Result, 1);

      //WriteFile(FPort, TxdCom, 3, dwSent, nil);
      dwSent := FileWrite(FPort, TxdCom, 3);
      FileClose(FPort); { *Converted from CloseHandle*  }
    end;
    OpenComPort($1F, NumPort);
    Result := OpenComPort(CodComm, NumPort);
  end;
end;

function ControlCheckSumm(CheckSum: byte):Boolean;
var
  RxdByte: byte;
  dwSent: DWord;
begin
  //WriteFile(FPort, CheckSum, 1, dwSent, nil);
  dwSent := FileWrite(FPort, CheckSum, 1);
  //ReadFile(FPort, RxdByte, 1, dwSent, nil);
  dwSent := FileRead(FPort, RxdByte, 1);
  Result := (RxdByte = CheckSum) and (dwSent = 1);
end;

function HexStrToInt(const S: string): Longint;
var
  Digit, I: Byte;
begin
  Result := 0;
  for I := 1 to Length(S) do
  begin
    Digit := ord(S[I]) - ord('0');
    if Digit > 10 then Dec(Digit, 7);
    Result := Result * 16 + Digit;
  end;
end;

function HexToBinConverter(InFileName: string): Integer;
var
  FNameBIN: File;
  FNameHEX: TextFile;
  St: string;
  FileBuffer: array [0..131071] of byte;
  Count, Address, Offset, i: Integer;
begin
  //FillMemory(@FileBuffer, 131072, $FF);
  FillByte(FileBuffer, 131072, $FF);
  AssignFile(FNameHEX, InFileName);
  Reset (FNameHEX);
  Offset := 0;
  Result := 0;
  while not EOF(FNameHEX) do
  repeat
    ReadLn(FNameHEX, St);
    if St[8] + St[9] = '02' then
      Offset := HexStrToInt(St[10]+St[11]+St[12]+St[13]+'0');
    if St[8] + St[9] = '00' then
    begin
      Count := HexStrToInt(St[2]+St[3]);
      Address := Offset + HexStrToInt(St[4]+St[5]+St[6]+St[7]);
      for i := 1 to Count do
      begin
        FileBuffer[Address] := HexStrToInt(St[i*2+8]+St[i*2+9]);
        inc(Address);
        if Result < Address then Result := Address;
      end;
    end;
  until EOLN(FNameHEX);
  CloseFile(FNameHEX);
  AssignFile(FNameBIN, ChangeFileExt(InFileName, '.bin'));
  Rewrite(FNameBIN, 1);
  BlockWrite(FNameBIN, FileBuffer, Result, i);
  CloseFile(FNameBIN);
end;

function TMain1.FindChildWindow(FN: string): Boolean;
var
  i: integer;
begin
  Result := False;
  if (ActiveMDIChild <> nil) and (MDIChildCount > 1) then
    for i := 1 to MDIChildCount do
    begin
      Result :=(THexEdit(ActiveMDIChild).Caption=FN)or(TTextEdit(ActiveMDIChild).Caption=FN);
      if Result then Exit else Next;
    end;
end;

function TMain1.CheckNeedDownLoad(ChFileName: string): string;
begin
  Result := ChFileName;
  if FindChildWindow(ChFileName)then
    if (ActiveMDIChild is THexEdit) and (THexEdit(ActiveMDIChild).Modified) then
{      if MessageDlg(Format('Сохранить изменения в файле %s?', [ChFileName]), mtConfirmation,
        [mbYes, mbNo], 0) = idYes then THexEdit(ActiveMDIChild).Save('')
      else}
      begin
        Result := ChangeFileExt(ChFileName, '.~MP');
        THexEdit(ActiveMDIChild).SaveTmp(Result);
      end;
end;



procedure TMain1.ConfigOpen(const AConfigName: string);
begin
  Caption := 'ТРИТОН - ' + ExtractFileName(AConfigName);
  OpenDialog1.InitialDir := ExtractFilePath(AConfigName);

end;

procedure TMain1.FormCreate(Sender: TObject);
var
  Reg: TRegistry;
  PathIniFile : string;
  iniSettings : TINIFile;
begin
  Application.OnHint := ShowHint;
  Screen.OnActiveFormChange := UpdateMenuItem;
  PathIniFile := ExtractFilePath(Application.ExeName);
  Application.HelpFile := PathIniFile + 'Triton.hlp';
  iniSettings := TINIFile.Create(PathIniFile + 'Triton.ini');
  try
    if iniSettings.ReadInteger(Name, 'Left', -1) = -1 then
    begin
      Width := Screen.Width - 100;
      Height := Screen.Height - 70;
      Left := (Screen.Width - Width) div 2;
      Top := (Screen.Height - Height) div 2;
      OpenDialog1.InitialDir := PathIniFile;
    end
    else
    begin
      Left := iniSettings.ReadInteger(Name, 'Left', Left);
      Top := iniSettings.ReadInteger(Name, 'Top', Top);
      Width := iniSettings.ReadInteger(Name, 'Width', Width);
      Height := iniSettings.ReadInteger(Name, 'Height', Height);
      case iniSettings.ReadInteger(Name, 'WindowState', 1) of
        0: WindowState := wsMinimized;
        1: WindowState := wsNormal;
        2: WindowState := wsMaximized;
      end;
      iCOMPort := iniSettings.ReadInteger(Name, 'ComPort', iCOMPort);
      case iCOMPort of
        0: MenuCOM11.Checked := True;
        1: MenuCOM21.Checked := True;
        2: MenuCOM31.Checked := True;
        3: MenuCOM41.Checked := True;
      end;
      OpenDialog1.InitialDir := iniSettings.ReadString(Name, 'Files_Dir', '');
      OpenDialog1.FilterIndex := iniSettings.ReadInteger(Name, 'Filter_Index', 1);
    end;
  finally iniSettings.Free;
  end;
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_LOCAL_MACHINE;
  if Reg.OpenKey('Hardware\Devicemap\Serialcomm', False) then
  begin
    if Reg.ValueExists('COM4')or Reg.ValueExists('SERIAL4')then ComEn[4] := True;
    if Reg.ValueExists('COM3')or Reg.ValueExists('SERIAL3')then ComEn[3] := True;
    if Reg.ValueExists('COM2')or Reg.ValueExists('SERIAL2')then ComEn[2] := True;
    if Reg.ValueExists('COM1')or Reg.ValueExists('SERIAL1')then ComEn[1] := True;
    MenuCOM11.Enabled := ComEn[1];
    MenuCOM21.Enabled := ComEn[2];
    MenuCOM31.Enabled := ComEn[3];
    MenuCOM41.Enabled := ComEn[4];
  end;
  Reg.Destroy;
  StChipName.Caption := ChipName;
end;

procedure TMain1.FormShow(Sender: TObject);
begin
  //DragAcceptFiles(Handle, True);
end;

procedure TMain1.ShowHint(Sender: TObject);
begin
  if Length(Application.Hint) > 0 then
  begin
    StatusBar.SimplePanel := True;
    StatusBar.SimpleText := Application.Hint;
  end
  else StatusBar.SimplePanel := False;
end;

procedure TMain1.FormDestroy(Sender: TObject);
var
  PathIniFile : string;
  iniSettings : TINIFile;
begin
  PathIniFile := ExtractFilePath(Application.ExeName);
  iniSettings := TINIFile.Create(PathIniFile + 'Triton.ini');
  try
    iniSettings.WriteInteger(Name, 'ComPort', iCOMPort);
    iniSettings.WriteInteger(Name, 'Filter_Index', OpenDialog1.FilterIndex);
    iniSettings.WriteString(Name, 'Files_Dir', OpenDialog1.InitialDir);
    if WindowState=wsMinimized then iniSettings.WriteInteger(Name, 'WindowState', 0);
    if WindowState=wsMaximized then iniSettings.WriteInteger(Name, 'WindowState', 2);
    if WindowState=wsNormal then
    begin
      iniSettings.WriteInteger(Name, 'WindowState', 1);
      iniSettings.WriteInteger(Name, 'Left', Left);
      iniSettings.WriteInteger(Name, 'Top', Top);
      iniSettings.WriteInteger(Name, 'Width', Width);
      iniSettings.WriteInteger(Name, 'Height', Height);
    end;
  finally iniSettings.Free;
  end;
end;

procedure TMain1.UpdateMenuItem(Sender: TObject);
begin
  if ActiveMDIChild = nil then Exit;
  SaveButton.Enabled := (ActiveMDIChild is THexEdit)and(THexEdit(ActiveMDIChild).Modified);
  UndoButton.Enabled := False;
  CutButton.Enabled := (ActiveMDIChild is THexEdit)and(THexEdit(ActiveMDIChild).DumpGetSelLength <>0);
  CopyButton.Enabled := CutButton.Enabled;
  PasteButton.Enabled := (ActiveMDIChild is THexEdit)and(pWorkBuf <> nil);
  FindButton.Enabled := (ActiveMDIChild is THexEdit)or(ActiveMDIChild is TTextEdit);
  FindNextButton.Enabled := (ActiveMDIChild is THexEdit)or(ActiveMDIChild is TTextEdit);
  ReplaceButton.Enabled := ActiveMDIChild is THexEdit;
  SummButton.Enabled := ActiveMDIChild is THexEdit;
  if ActiveMDIChild is THexEdit then
    StatusBar.Panels[0].Text := 'Адрес:  ' + IntToHex(THexEdit(ActiveMDIChild).DumpGetSelStart, 6)
  else StatusBar.Panels[0].Text := '';
  if SaveButton.Enabled then StatusBar.Panels[1].Text := 'Modified'
  else StatusBar.Panels[1].Text := '';
end;

procedure TMain1.MenuFileClick(Sender: TObject);
begin
  if (ActiveMDIChild = nil) then Exit;
  MenuFileBufSave.Enabled := (ActiveMDIChild is THexEdit)and(THexEdit(ActiveMDIChild).Modified);
  MenuFileBufSaveAs.Enabled := (ActiveMDIChild is THexEdit);
end;

procedure TMain1.MenuFileNewClick(Sender: TObject);
begin
  THexEdit.Create(Self);
end;

procedure TMain1.MenuFileOpenClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Открытие файла для редактирования';
  if OpenDialog1.Execute then
    if not FindChildWindow(OpenDialog1.FileName) then
    begin
      ProgFileName := OpenDialog1.FileName;
      Form1.StFileName.Caption := ProgFileName;
      if UpperCase(ExtractFileExt(OpenDialog1.FileName)) = '.HEX' then
        with TTextEdit.Create(Self) do Open(ProgFileName)
      else with THexEdit.Create(Self) do Open(ProgFileName);
      SummButtonClick(Sender);
      OpenDialog1.InitialDir := ExtractFilePath(ProgFileName);
    end;
end;

procedure TMain1.MenuFileSaveEdClick(Sender: TObject);
begin
  if not (ActiveMDIChild = nil) then
    if ActiveMDIChild is THexEdit then
      if THexEdit(ActiveMDIChild).Caption = 'NewFile.tmp' then
        MenuFileSaveAsClick(Sender)
      else THexEdit(ActiveMDIChild).Save('');
end;

procedure TMain1.MenuFileSaveAsClick(Sender: TObject);
begin
  if not (ActiveMDIChild = nil) then
    if (ActiveMDIChild is THexEdit) and SaveDialog1.Execute then
    begin
      THexEdit(ActiveMDIChild).Save(SaveDialog1.FileName);
      ProgFileName := SaveDialog1.FileName;
      Form1.StFileName.Caption := ProgFileName;
    end;
end;

procedure TMain1.MenuFileLoadClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Загрузка файла в программатор';
  OpenDialog1.FileName := '';
  if OpenDialog1.Execute then
  begin
    ProgFileName := OpenDialog1.FileName;
    Form1.StFileName.Caption := ProgFileName;
    if not FindChildWindow(OpenDialog1.FileName) then
    begin
      if UpperCase(ExtractFileExt(OpenDialog1.FileName)) = '.HEX' then
        with TTextEdit.Create(Self) do Open(ProgFileName)
      else with THexEdit.Create(Self) do Open(ProgFileName);
      SummButtonClick(Sender);
      OpenDialog1.InitialDir := ExtractFilePath(ProgFileName);
    end;
    CodCommand := $18;
    DialogProcess1.ShowModal;
  end;
end;

procedure TMain1.MenuFileSaveClick(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    ProgFileName := SaveDialog1.FileName;
    Form1.StFileName.Caption := ProgFileName;
    CodCommand := $14;
    DialogProcess1.ShowModal;
  end;
end;

procedure TMain1.MenuFilePrintClick(Sender: TObject);
begin
  if not (ActiveMDIChild = nil) then
  begin
    if ActiveMDIChild is THexEdit then
      THexEdit(ActiveMDIChild).EditorPrintFile(Sender);
    if ActiveMDIChild is TTextEdit then
      TTextEdit(ActiveMDIChild).RichEditPrintFile(Sender);
  end;
end;

procedure TMain1.MenuFileHexToBinClick(Sender: TObject);
var
  EndAddress, TempFilterIndex: Integer;
begin
  OpenDialog1.Title := 'Преобразование шестнадцатеричного файла';
  OpenDialog1.Filter := 'Шестнадцатиричные (*.hex)|*.hex';
  TempFilterIndex := OpenDialog1.FilterIndex;
  OpenDialog1.FilterIndex := 0;
  OpenDialog1.FileName := '';
  if OpenDialog1.Execute and FileExistsUTF8(OpenDialog1.FileName) { *Converted from FileExists*  } then
  begin
    EndAddress := HexToBinConverter(OpenDialog1.FileName);
    //MessageBox(0,PChar('Преобразование файла  ' + ExtractFileName(OpenDialog1.FileName) + '  завершено.' + #13 +
     //'Объём двоичного файла  -  ' + IntToStr(EndAddress) + ' байт.'), 'Преобразование шестнадцатеричного файла',
     //MB_ICONINFORMATION or mb_TaskModal);
     MessageBox(0,PChar('Преобразование файла  ' + ExtractFileName(OpenDialog1.FileName) + '  завершено.' + #13 +
     'Объём двоичного файла  -  ' + IntToStr(EndAddress) + ' байт.'), 'Преобразование шестнадцатеричного файла',
     MB_ICONINFORMATION);
  end;
  OpenDialog1.Filter := 'Двоичные файлы (*.bin, *.rom, *.tsk)|*.bin;*.rom;*.tsk|Шестнадцатиричные (*.hex)|*.hex|Все файлы (*.*)|*.*';
  OpenDialog1.FilterIndex := TempFilterIndex;
end;

procedure TMain1.MenuFileExitClick(Sender: TObject);
begin
  Close;
end;

procedure TMain1.UndoButtonClick(Sender: TObject);
begin
  if not (ActiveMDIChild = nil) then
    if ActiveMDIChild is THexEdit then
      THexEdit(ActiveMDIChild).EditUndoItemClick(Sender);
end;

procedure TMain1.CutButtonClick(Sender: TObject);
begin
  if not (ActiveMDIChild = nil) then
    if ActiveMDIChild is THexEdit then
      THexEdit(ActiveMDIChild).EditCutItemClick(Sender);
end;

procedure TMain1.CopyButtonClick(Sender: TObject);
begin
  if not (ActiveMDIChild = nil) then
    if ActiveMDIChild is THexEdit then
      THexEdit(ActiveMDIChild).EditCopyItemClick(Sender);
end;

procedure TMain1.PasteButtonClick(Sender: TObject);
begin
  if not (ActiveMDIChild = nil) then
    if ActiveMDIChild is THexEdit then
      THexEdit(ActiveMDIChild).EditPasteItemClick(Sender);
end;

procedure TMain1.SummButtonClick(Sender: TObject);
begin
  if not (ActiveMDIChild = nil) then
    if ActiveMDIChild is THexEdit then
      SumStText.Caption := THexEdit(ActiveMDIChild).DumpCheckSum;
end;

procedure TMain1.FindButtonClick(Sender: TObject);
begin
  if not (ActiveMDIChild = nil) then
  begin
    if ActiveMDIChild is THexEdit then
      THexEdit(ActiveMDIChild).EditFindItemClick(Sender);
    if ActiveMDIChild is TTextEdit then
      TTextEdit(ActiveMDIChild).EditFindItemClick(Sender);
  end;
end;

procedure TMain1.FindNextButtonClick(Sender: TObject);
begin
  if not (ActiveMDIChild = nil) then
  begin
    if ActiveMDIChild is THexEdit then
      THexEdit(ActiveMDIChild).EditNextFindItemClick(Sender);
    if ActiveMDIChild is TTextEdit then
      TTextEdit(ActiveMDIChild).EditNextFindItemClick(Sender);
  end;
end;

procedure TMain1.ReplaceButtonClick(Sender: TObject);
begin
  if not (ActiveMDIChild = nil) then
    if ActiveMDIChild is THexEdit then
      THexEdit(ActiveMDIChild).EditNextReplaceItemClick(Sender);
end;

procedure TMain1.MenuOptClick(Sender: TObject);
begin
  MenuOptSQTP.Enabled := (Form1.PageControl1.ActivePage.PageIndex=3)and(Form1.ComboBox4.ItemIndex<>-1);
end;

procedure TMain1.MenuCOM11Click(Sender: TObject);
begin
  MenuCOM11.Checked := True;
  iCOMPort := 0;
end;

procedure TMain1.MenuCOM21Click(Sender: TObject);
begin
  MenuCOM21.Checked := True;
  iCOMPort := 1;
end;

procedure TMain1.MenuCOM31Click(Sender: TObject);
begin
  MenuCOM31.Checked := True;
  iCOMPort := 2;
end;

procedure TMain1.MenuCOM41Click(Sender: TObject);
begin
  MenuCOM41.Checked := True;
  iCOMPort := 3;
end;

procedure TMain1.MenuOptIniProgClick(Sender: TObject);
begin
  Form1.FormCreate(Sender);
end;

procedure TMain1.MenuOptAutoWriteClick(Sender: TObject);
begin
  MenuOptAutoWrite.Checked := not MenuOptAutoWrite.Checked;
  if MenuOptAutoWrite.Checked then BlokPar[$2F] := BlokPar[$2F] or $01
  else BlokPar[$2F] := BlokPar[$2F] and $FE;
  if not WriteBlokPar($2F, $2F) then
    MenuOptAutoWrite.Checked := not MenuOptAutoWrite.Checked;
end;

procedure TMain1.MenuOptClearMemoryClick(Sender: TObject);
begin
  MenuOptClearMemory.Checked := not MenuOptClearMemory.Checked;
  if MenuOptClearMemory.Checked then BlokPar[$2F] := BlokPar[$2F] or $04
  else BlokPar[$2F] := BlokPar[$2F] and $FB;
  if not WriteBlokPar($2F, $2F) then
    MenuOptClearMemory.Checked := not MenuOptClearMemory.Checked;
end;

procedure TMain1.MenuOptSQTPClick(Sender: TObject);
begin
  if Form1.PageControl1.ActivePage.PageIndex <> 3 then Exit;
  if not Assigned(SQTPNumbDlg) then SQTPNumbDlg := TSQTPNumbDlg.Create(Self);
  if not ReadBlokPar($83, $85) then SQTPNumbDlg.SQTPNumb.Text := IntToHex(0, 4)
  else SQTPNumbDlg.SQTPNumb.Text := IntToHex(BlokPar[$84]*256 + BlokPar[$83], 4);
  SQTPNumbDlg.cbSqtpEn.Checked := (BlokPar[$2F] and $80) > 0;
  SQTPNumbDlg.cbAutoIncr.Checked := BlokPar[$85] = 1;
  if SQTPNumbDlg.ShowModal = mrOk then
  begin
    MenuOptSQTP.Checked := SQTPNumbDlg.cbSqtpEn.Checked;
    if MenuOptSQTP.Checked then BlokPar[$2F] := BlokPar[$2F] or $80
    else BlokPar[$2F] := BlokPar[$2F] and $6F;
    if SQTPNumbDlg.cbAutoIncr.Checked then BlokPar[$2F] := BlokPar[$2F] or $10
    else BlokPar[$2F] := BlokPar[$2F] and $EF;
    WriteBlokPar($2F, $2F);
    BlokPar[$83] := Lo(HexStrToInt(SQTPNumbDlg.SQTPNumb.Text));
    BlokPar[$84] := (HexStrToInt(SQTPNumbDlg.SQTPNumb.Text)) shr 8;
    if SQTPNumbDlg.cbAutoIncr.Checked then BlokPar[$85] := 1
    else BlokPar[$85] := 0;
    if WriteBlokPar($83, $85) then OpenComPortSearch($13, iCOMPort);
  end;
end;

procedure TMain1.MenuCommClick(Sender: TObject);
begin
  MenuCommErase.Visible := (BlokPar[$2D] and 16) > 0;
  MenuCommErase.Enabled := (BlokPar[$2D] and 16) > 0;
  MenuCommEncr.Visible := (BlokPar[$2D] and 4) > 0;
  MenuCommEncr.Enabled := (BlokPar[$2D] and 4) > 0;
  MenuCommLock.Visible := (BlokPar[$2D] and 8) > 0;
  MenuCommLock.Enabled := (BlokPar[$2D] and 8) > 0;
end;

procedure TMain1.MenuCommBlankClick(Sender: TObject);
begin
  CodCommand := $8;
  DialogProcess1.ShowModal;
end;

procedure TMain1.MenuCommSumClick(Sender: TObject);
begin
  CodCommand := $9;
  DialogProcess1.ShowModal;
end;

procedure TMain1.MenuCommReadClick(Sender: TObject);
var
  TempString, TempPcharString: array[0..255] of Char;
begin
  Form1.StFileName.Caption := 'Буфер программатора';

  //GetTempPath(255, TempPcharString);
  TempPcharString := GetTempDir(False);
  GetTempFileName(TempPcharString, 'Triton', 0, TempString);
  if FileExistsUTF8(StrPas(TempString)) { *Converted from FileExists*  } then ProgFileName := StrPas(TempString);
  CodCommand := $0A;
  if DialogProcess1.ShowModal = mrOk then
  begin
    with THexEdit.Create(Self) do
      begin Open(ProgFileName); Modified := True; end;
    StatusBar.Panels[1].Text := 'Modified';
    SummButtonClick(Sender);
    Form1.StFileName.Caption := ProgFileName;
  end;
end;

procedure TMain1.MenuCommProgClick(Sender: TObject);
begin
  CodCommand := $7;
  DialogProcess1.ShowModal;
end;

procedure TMain1.MenuCommVerifyClick(Sender: TObject);
begin
  CodCommand := $0B;
  DialogProcess1.ShowModal;
end;

procedure TMain1.MenuCommEraseClick(Sender: TObject);
begin
  CodCommand := $4;
  DialogProcess1.ShowModal;
end;

procedure TMain1.MenuCommEncrClick(Sender: TObject);
begin
  CodCommand := $5;
  DialogProcess1.ShowModal;
end;

procedure TMain1.MenuCommLockClick(Sender: TObject);
begin
  CodCommand := $6;
  DialogProcess1.ShowModal;
end;

procedure TMain1.TileHorizontalClick(Sender: TObject);
begin
  //TileMode := (tbHorizontal);
  Tile;
end;

procedure TMain1.TileVerticalClick(Sender: TObject);
begin
  //TileMode := (tbVertical);
  Tile;
end;

procedure TMain1.TileCascadeClick(Sender: TObject);
begin
  Cascade;
end;

procedure TMain1.MenuHelpAboutClick(Sender: TObject);
begin
  if not Assigned(AboutBox1) then AboutBox1 := TAboutBox1.Create(Self);
  AboutBox1.ShowModal;
end;

procedure TMain1.MenuHelpHelpClick(Sender: TObject);
begin
//  Application.HelpJump('Hlp_xxxxxxxxxxxx_');
end;

end.
