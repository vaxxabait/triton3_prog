unit DialogProcess;

interface

uses LCLIntf, LCLType, LMessages, SysUtils, Classes, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Gauges, Graphics, Dialogs;

type
  TDialogProcess1 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    lbChipName: TLabel;
    cbAuto: TCheckBox;
    Panel2: TPanel;
    Bevel2: TBevel;
    Button2_Ok: TButton;
    CanselBtn: TButton;
    cbNewFile: TCheckBox;
    cbWrite: TCheckBox;
    cbLock: TCheckBox;
    edLoadAdres: TEdit;
    Panel3: TPanel;
    Bevel3: TBevel;
    LabelMode: TLabel;
    Gauge1: TGauge;
    LabelStatus: TLabel;
    Label2: TLabel;
    RepeatBtn: TButton;
    CloseBtn: TButton;
    stFileName: TStaticText;
    cbSerial: TCheckBox;
    Panel4: TPanel;
    Button4_No: TButton;
    Button4_Ok: TButton;
    Label4_1: TLabel;
    Label4_2: TLabel;
    Image1: TImage;
    Bevel4: TBevel;
    Panel5: TPanel;
    Bevel5: TBevel;
    Label5_1: TLabel;
    Label5_2: TLabel;
    Image2: TImage;
    Button5_No: TButton;
    Button5_Ok: TButton;
    procedure ConfirmErasing;
    procedure ConfirmProtect;
    procedure CofirmLockBits;
    procedure ConfirmProgramming;
    procedure ConfirmReading;
    procedure FormActivate(Sender: TObject);
    procedure LoadSaveDate;
    procedure ReadChipAndOpenFile;
    function SelectChipAuto(List: byte): boolean;
    procedure Button2_OkClick(Sender: TObject);
    procedure edLoadAdresKeyPress(Sender: TObject; var Key: Char);
    procedure cbNewFileClick(Sender: TObject);
    procedure UpdateStatus;
    function SaveBinDataToFile(var FN: file): boolean;
    function LoadFileAndProcess(IFileName: string): boolean;
    function OpenLoadAndProcess: boolean;
    function DownloadHexFile(var FN: file): boolean;
    function DownloadBinFile(var FN: file; BegAdr, LengthNum: Integer): boolean;
    function SetupBlockRam(BufAdr, BegAdr, FinAdr: Integer): boolean;
    function ProccBlockRam(BegPos, FinPos: integer): boolean;
    function ModifyBlokPar: boolean;
    procedure RepeatBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  end;

var
  DialogProcess1: TDialogProcess1;
  TempFileName: string;
  CodList: Byte;
  ModeError8, ErrorPresent: boolean;

implementation

uses Triton_Main1, DialogError, Triton_prog;

{$R *.DFM}

procedure TDialogProcess1.ConfirmErasing;
begin
  Panel4.BringToFront;
  Button4_Ok.SetFocus;
end;

procedure TDialogProcess1.ConfirmProtect;
begin
  case Form1.PageControl1.ActivePage.PageIndex of
    2: edLoadAdres.Text := Form1.meEncr3.Text;
    3: edLoadAdres.Text := Form1.meEeprom4.Text;
  else edLoadAdres.Text := '000000';
  end;
  case Form1.PageControl1.ActivePage.PageIndex of
    2: cbNewFile.Hint := 'Разрешает загрузку нового файла шифровальной таблицы';
    3: cbNewFile.Hint := 'Разрешает загрузку нового файла EEPROM данных';
  else cbNewFile.Hint := 'Разрешает загрузку нового файла в программатор по указанному адресу';
  end;
  cbSerial.Visible := False;
  cbWrite.Visible := False;
  cbLock.Visible :=(Form1.PageControl1.ActivePage.PageIndex=1)and Main1.MenuCommLock.Enabled;
end;

procedure TDialogProcess1.CofirmLockBits;
begin
  Panel5.BringToFront;
  Label5_2.Caption := 'Установить  защиту?';
  case Form1.PageControl1.ActivePage.PageIndex of
    1: Label5_1.Caption := 'Защита загрузочного сектора для некоторых микросхем устанавливается однократно. После чего изменить содержимое сектора невозможно!';
    3: Label5_1.Caption := 'При установленных битах защиты  УФ версии PIC контроллеров не могут быть стерты или перепрограммированы!';
  else Label5_1.Caption := 'Установить  защиту?';
       Label5_2.Caption := '';
  end;
  Button5_Ok.SetFocus;
end;

procedure TDialogProcess1.ConfirmProgramming;
begin
  Caption := 'Программирование микросхемы';
  cbNewFile.Hint := 'Разрешает загрузку нового файла в программатор по указанному адресу';
  case Form1.PageControl1.ActivePage.PageIndex of
    1: cbWrite.Hint := 'Разрешает запись микросхемы в режиме SDP';
    2: cbWrite.Hint := 'Разрешает автоматическую запись шифровальной таблицы';
    3: begin
         cbSerial.Caption := 'Запись ID Location   ';
//         if cbSerial.Checked then cbSerial.Caption := cbSerial.Caption + IntToHex(BlokPar[$84]*256 + BlokPar[$83], 4);
         cbWrite.Hint := 'Разрешает автоматическую запись EEPROM памяти данных';
       end;
  end;
  edLoadAdres.Text := '000000';
end;

procedure TDialogProcess1.ConfirmReading;
begin
  if Form1.PageControl1.ActivePage.PageIndex = 3 then
  begin
    cbNewFile.Enabled := False;
    cbSerial.Caption := 'Доступ к ID Location';
    cbWrite.Caption := 'Доступ к EEPROM памяти';
    cbLock.Caption := 'Конфигурационное слово';
  end
  else Button2_OkClick(Self);
end;

procedure TDialogProcess1.FormActivate(Sender: TObject);
begin
  CloseBtn.ModalResult := mrCancel;
  CodList := 1 shl Form1.PageControl1.ActivePage.PageIndex;
  lbChipName.Caption := Main1.StChipName.Caption;
  cbAuto.Visible := Form1.PageControl1.ActivePage.PageIndex < 3;
  cbAuto.Checked := cbAuto.Visible and((BlokPar[$2F] and $08) > 0);
  case CodCommand of
    4:      Caption := 'Стирание микросхемы';
    5: case Form1.PageControl1.ActivePage.PageIndex of
         1: Caption := 'Запись в режиме Software Data Protection';
         2: Caption := 'Программирование шифровальной таблицы';
         3: Caption := 'Программирование EEPROM данных';
       else Caption := 'Специальный режим записи';
       end;
    6: case Form1.PageControl1.ActivePage.PageIndex of
         1: Caption := 'Установка защиты загрузочного сектора';
         3: Caption := 'Программирование конфигурационного слова';
       else Caption := 'Установка битов защиты памяти программ';
       end;
    7:      Caption := 'Программирование микросхемы';
    8:      Caption := 'Проверка микросхемы на чистоту';
    9:      Caption := 'Подсчет контрольной суммы микросхемы';
    $0A:    Caption := 'Чтение микросхемы и открытие файла в редакторе';
    $0B:    Caption := 'Сверка с содержимым буфера';
    $14:    Caption := 'Сохранение данных в файле';
    $18:    Caption := 'Загрузка файла в программатор';
  end;
  Panel2.BringToFront;
  cbNewFile.Enabled := True;
  cbNewFile.Checked := False;
  edLoadAdres.Visible := True;
  edLoadAdres.Enabled := cbNewFile.Checked;
  cbSerial.Visible := True;
  cbSerial.Caption := Main1.MenuOptSQTP.Caption;
  cbSerial.Enabled := Form1.PageControl1.ActivePage.PageIndex = 3;
  cbSerial.Checked := cbSerial.Enabled and((BlokPar[$2F] and $80) > 0);
  cbWrite.Visible := True;
  cbWrite.Caption := Main1.MenuCommEncr.Caption;
  cbWrite.Enabled := Main1.MenuCommEncr.Visible and Main1.MenuCommEncr.Enabled;
  cbWrite.Checked := cbWrite.Enabled and((BlokPar[$2F] and $20) > 0);
  cbLock.Visible := True;
  cbLock.Caption := Main1.MenuCommLock.Caption;
  cbLock.Enabled := Main1.MenuCommLock.Visible and Main1.MenuCommLock.Enabled;
  if Form1.PageControl1.ActivePage.PageIndex = 3 then cbLock.Enabled := False;
  cbLock.Checked := cbLock.Enabled and((BlokPar[$2F] and $40) > 0);
  LabelMode.Caption := '';
  Button2_Ok.SetFocus;
  case CodCommand of
    4:         ConfirmErasing;
    5:         ConfirmProtect;
    6:         CofirmLockBits;
    7:         ConfirmProgramming;
    8,9,10,11: ConfirmReading;
    $14, $18:  LoadSaveDate;
  end;
end;

procedure TDialogProcess1.LoadSaveDate;
var
  FName: file;
  SizFile: integer;
  Status: boolean;
begin
  Panel3.BringToFront;
  RepeatBtn.Enabled := False;
  LabelStatus.Caption := 'Подождите,  программатор  занят !';
  stFileName.Caption := ExtractFileName(ProgFileName);
  Gauge1.MinValue := 0;
  Gauge1.Progress := 0;
  Screen.Cursor := crHourGlass;
  if CodCommand = $14 then
  begin
    AssignFile(FName, ProgFileName);
    Rewrite(FName, 1);
    Gauge1.MaxValue := FinalAdres - BeginAdres;
    if SaveBinDataToFile(FName) then
      LabelStatus.Caption := 'Чтение данных завершено.'
    else LabelStatus.Caption := 'Ошибка чтения файла.';
    CloseFile(FName);
  end;
  if CodCommand = $18 then
  begin
    AssignFile(FName, ProgFileName);
    Reset(FName, 1);
    SizFile := FileSize(FName);
    Gauge1.MaxValue := SizFile;
    if UpperCase(ExtractFileExt(ProgFileName))='.HEX' then
      Status := DownloadHexFile(FName)
    else Status := DownloadBinFile(FName, 0, SizFile);
    if Status then LabelStatus.Caption := 'Загрузка файла завершена.'
    else LabelStatus.Caption := 'Ошибка загрузки файла.';
    CloseFile(FName);
  end;
  LabelMode.Caption := '';
  Gauge1.Visible := False;
  Screen.Cursor := crDefault;
  CloseBtn.SetFocus;
end;

procedure TDialogProcess1.ReadChipAndOpenFile;
var
  FName: file;
  BegRom, FinRom: Integer;
  Status: boolean;
begin
  Panel3.BringToFront;
  RepeatBtn.Enabled := False;
  StFileName.Caption := 'Буфер программатора';
  LabelStatus.Caption := 'Подождите,  программатор  занят !';
  Screen.Cursor := crHourGlass;
  DialogProcess1.Update;
  if cbAuto.Checked then Status := SelectChipAuto(CodList)
  else Status := Form1.DisplayToBlokPar;
  if Status then Status := ModifyBlokPar;
  lbChipName.Caption := Main1.StChipName.Caption;
  AssignFile(FName, ProgFileName);
  Rewrite(FName, 1);
  Gauge1.MinValue := 0;
  Gauge1.Progress := 0;
  Gauge1.MaxValue := FinalAdres - BeginAdres;
  BegRom := BeginAdres;
  repeat
    if FinalAdres-BegRom > RamPgm then FinRom := BegRom + RamPgm - 1
    else FinRom := FinalAdres;
    if Status then Status := SetupBlockRam(0, BegRom, FinRom);
    if Status then Status := ProccBlockRam(0, 100);
    if ErrorPresent then
      if MessageDlg('Микросхема считана с ошибками. Загрузить данные в компьютер?', mtConfirmation,
          [mbYes, mbNo], 0) = idNo then Status := False;
    if Status then Status := SaveBinDataToFile(FName);
    BegRom := FinRom + 1;
    if not Status then Break;
  until FinRom >= FinalAdres;
  CloseFile(FName);
  if Status then SetupBlockRam(BuferAdres, BeginAdres, FinalAdres);
  if Status then CloseBtn.ModalResult := mrOk else CloseBtn.ModalResult := mrCancel;
  LabelMode.Caption := '';
  if Status then LabelStatus.Caption := 'Чтение данных завершено.'
  else LabelStatus.Caption := 'Ошибка чтения файла.';
  Gauge1.Visible := False;
  Screen.Cursor := crDefault;
  if not Status then RepeatBtn.Enabled := ErrorPresent;
  CloseBtn.SetFocus;
end;

function TDialogProcess1.LoadFileAndProcess(IFileName: string): boolean;
var
  FName: File;
  BegRom, FinRom, BegLoad, BegLength, SizFile, GauPos: Integer;
  TempCommand: byte;
begin
  Screen.Cursor := crHourGlass;
  AssignFile(FName, IFileName);
  Reset(FName, 1);
  SizFile := FileSize(FName);
  Gauge1.MinValue := 0;
  Gauge1.Progress := 0;
  Gauge1.MaxValue := SizFile;
  if UpperCase(ExtractFileExt(IFileName))='.HEX' then
  begin
    Result := DownloadHexFile(FName);
    if Result then Result := ProccBlockRam(0, 100);
  end
  else
  begin
    Result := BuferAdres < SizFile;
    if Result then Seek(FName, BuferAdres)
    else if MessageDlg('Ошибка. Адрес буфера превышает объём файла.', mtError, [mbOk], 0) = mrOk then Exit;
    GauPos := 0;
    BegRom := BeginAdres;
    BegLoad := LoadAdres + BuferAdres;
    repeat
      if FinalAdres-BegRom > RamPgm then FinRom := BegRom + RamPgm - 1
      else FinRom := FinalAdres;
      if Result then Result := SetupBlockRam(0, BegRom, FinRom);
      //Очистка памяти
      Gauge1.MaxValue := SizFile - BuferAdres;
      Gauge1.MinValue := BuferAdres;
      Gauge1.Progress := FilePos(FName);
      BegLength := SizFile - BuferAdres - Gauge1.Progress;
      if BegLength >= RamPgm then BegLength := FinRom - BegRom + 1;
      if Result then Result := DownloadBinFile(FName, BegLoad, BegLength);
      if Result then Result := ProccBlockRam(GauPos,((FinalAdres-BeginAdres)div RamPgm +1)*100);
      GauPos := Gauge1.Progress;
      BegRom := FinRom + 1;
      BegLoad := 0;
    until (FinRom = FinalAdres) or EOF(FName);
    if Result then SetupBlockRam(BuferAdres, BeginAdres, FinalAdres);
    if (FinalAdres - BeginAdres > RamPgm) and (CodCommand = 7) then
    begin
      TempCommand := CodCommand;
      CodCommand := 9;
      if Result then Result := ProccBlockRam(0,100);
      CodCommand := TempCommand;
    end;
  end;
  CloseFile(FName);
end;

function TDialogProcess1.ProccBlockRam(BegPos, FinPos: integer): boolean;
var
  RxdAck, TxdByte: byte;
  dwSent: DWord;
  FirstZapros: boolean;
begin
  Screen.Cursor := crHourGlass;
  Gauge1.Visible := False;
  case CodCommand of
    4:    LabelMode.Caption := 'Erasing...';
    5:    if Form1.PageControl1.ActivePage.PageIndex <> 1 then
            LabelMode.Caption := 'Programming...';
    6:    LabelMode.Caption := 'Programming...';
    7:  begin LabelMode.Caption := 'Записано:';
          Gauge1.MinValue := 0;
          Gauge1.MaxValue := FinPos;
          Gauge1.Progress := BegPos;
          Gauge1.ForeColor := clBlue;
          Gauge1.Visible := True;
        end;
    8:    LabelMode.Caption := 'Testing...';
    9:    LabelMode.Caption := 'Checking...';
    $0A:  LabelMode.Caption := 'Reading...';
    $0B:  LabelMode.Caption := 'Verifying...';
  end;
  Main1.Update;
  DialogProcess1.Update;
  FirstZapros := True;
  Result := OpenComPortSearch(CodCommand, iCOMPort) = CodCommand;
  if Result then
  repeat
    ReadFile(FPort, RxdAck, 1, dwSent, nil);
    if dwSent = 0 then Continue;
    case RxdAck of
      $0AA: begin
              if FirstZapros then TxdByte := $10
              else if MessageDlg('Микросхема не чистая.'+#13+'Дальнейшая запись не возможна.'+#13+#13+
                  'Продолжать ?', mtConfirmation, [mbNo, mbYes], 0)= mrYes then TxdByte := $10
                   else TxdByte := $40;
              DialogProcess1.Update;
              FirstZapros := False;
              WriteFile(FPort, TxdByte, 1, dwSent, nil);
              if TxdByte = $40 then
              begin
                CloseHandle(FPort);
                LabelMode.Caption := 'Процесс прерван пользователем.';
                LabelStatus.Caption := 'Микросхема не чистая.';
                Exit;
              end;
            end;
      $0A5, $0A6: begin ModeError8 := RxdAck = $0A5;
              case DialogError1.ShowModal of
                mrRetry:  TxdByte := $10;
                mrIgnore: TxdByte := $20;
                mrAbort:  TxdByte := $40;
              end;
              if not((CodCommand in[5,6,7])and(TxdByte=$10)) then ErrorPresent := True;
              DialogProcess1.Update;
              WriteFile(FPort, TxdByte, 1, dwSent, nil);
            end;
    else if CodCommand = 7 then Gauge1.Progress := Gauge1.Progress + 1;
    end;
  until RxdAck = $0AF;
  CloseHandle(FPort);
end;


function TDialogProcess1.SaveBinDataToFile(var FN: file): boolean;
var
  Buf: array[1..256] of byte;
  RxdAck, TxdSum: byte;
  dwSent: DWord;
  RxBlok, Counter, k: Integer;
begin
  LabelMode.Caption := 'Сохранено:';
  Gauge1.ForeColor := clLime;
  Gauge1.Visible := True;
  Main1.Update;
  DialogProcess1.Update;
  Result := OpenComPortSearch($14, iCOMPort) = $14;
  if Result then
  begin
    TxdSum := 0;
    for k := 1 to 3 do                         //Прием заголовка
    begin
      WriteFile(FPort, TxdSum, 1, dwSent, nil);
      ReadFile(FPort, RxdAck, 1, dwSent, nil);
      Buf[k] := RxdAck;
      TxdSum := (TxdSum + RxdAck)and $FF;
    end;
    Result := ControlCheckSumm(TxdSum);
    if Result then
    begin
      RxBlok := Buf[1] + Buf[2]*256 + Buf[3]*65536 + 1;
      TxdSum := 0;
      repeat
        if RxBlok < SizeOf(Buf) then Counter := RxBlok
        else Counter := SizeOf(Buf);
        for k := 1 to Counter do
        begin
          WriteFile(FPort, TxdSum, 1, dwSent, nil);
          ReadFile(FPort, RxdAck, 1, dwSent, nil);
          if dwSent = 0 then Break;
          Buf[k] := RxdAck;
          TxdSum := (TxdSum + RxdAck)and $FF;
        end;
        if dwSent = 0 then Break;
        BlockWrite(FN, Buf, Counter, dwSent);
        Gauge1.Progress := Gauge1.Progress + Counter;
        RxBlok := RxBlok - Counter;
      until RxBlok = 0;
      Result := ControlCheckSumm(TxdSum);
    end;
  end;
  CloseHandle(FPort);
end;

function TDialogProcess1.DownloadHexFile(var FN: file): boolean;
var
  Buf: array[1..256] of byte;
  dwSent: DWord;
  TxdSum, RxdAck, i: byte;
begin
  LabelMode.Caption := 'Загружено:';
  Gauge1.ForeColor := clRed;
  Gauge1.Visible := True;
  Main1.Update;
  DialogProcess1.Update;
  Result := OpenComPortSearch($18, iCOMPort) = $18;
  if Result then
  repeat
    TxdSum := 0;
    i := 1;
    repeat
      BlockRead(FN, RxdAck, 1, dwSent);
      Buf[i] := RxdAck;
      TxdSum := (TxdSum + RxdAck) and $FF;
      inc(i);
    until RxdAck = $0D;
    TxdSum := (TxdSum - RxdAck) and $FF;
    Dec(i, 2);
    BlockRead(FN, RxdAck, 1, dwSent);
    WriteFile(FPort, Buf, i, dwSent, nil);
    Result := ControlCheckSumm(TxdSum);
    if not Result then Break;
    Gauge1.Progress := Gauge1.Progress + i + 2;
  until EOF(FN);
  CloseHandle(FPort);
end;

function TDialogProcess1.DownloadBinFile(var FN: file; BegAdr, LengthNum: Integer): boolean;
var
  Buf: array[1..256] of byte;
  dwSent: DWord;
  TxdSum: byte;
  NumRd, i, EndLoad: Integer;
begin
  LabelMode.Caption := 'Загружено:';
  Gauge1.ForeColor := clRed;
  Gauge1.Visible := True;
  Main1.Update;
  DialogProcess1.Update;
  EndLoad := Gauge1.Progress + LengthNum;
  Result := OpenComPortSearch($10, iCOMPort) = $10;
  if Result then Result := LoadHeader(BegAdr, LengthNum);
  if Result then
  begin
    TxdSum := 0;
    repeat
      BlockRead(FN, Buf, SizeOf(Buf), NumRd);
      Gauge1.Progress := Gauge1.Progress + NumRd;
      for i := 1 to NumRd do TxdSum := (TxdSum + Buf[i]) and $FF;
      WriteFile(FPort, Buf, NumRd, dwSent, nil);
    until (Gauge1.Progress >= EndLoad) or EOF(FN);
    Result := ControlCheckSumm(TxdSum);
  end;
  CloseHandle(FPort);
end;

function TDialogProcess1.SelectChipAuto(List: byte): boolean;
var
  i: byte;
begin
  i := SelectTypeChip(List, $0FF);
  Result := i = 0;
  if Result then lbChipName.Caption := Main1.StChipName.Caption
  else
  begin
    LabelMode.Caption := 'Процесс остановлен.';
    LabelStatus.Caption := 'Signature error - ошибка определения микросхемы.';
  end;
end;

procedure TDialogProcess1.RepeatBtnClick(Sender: TObject);
var
  Status: boolean;
begin
  ErrorPresent := False;
  RepeatBtn.Enabled := False;
  if CodCommand = $0A then begin ReadChipAndOpenFile; Exit end;
  LabelMode.Caption := '';
  LabelStatus.Caption := 'Подождите,  программатор  занят !';
  DialogProcess1.Update;
  Status := True;
  if cbAuto.Checked then
  begin
    Status := SelectChipAuto(CodList);
    if Status then Status := ModifyBlokPar;
  end;
  if Status and (CodCommand in [4, 6, 9]) then Status := ProccBlockRam(0, 100);
  if Status and (CodCommand in [5, 7, 8, 11]) then
    if FinalAdres - BeginAdres > RamPgm then Status := LoadFileAndProcess(TempFileName)
      else Status := ProccBlockRam(0, 100);
  Gauge1.Visible := False;
  if Status then Status := ReadBlokPar($13, $27) and ReadBlokPar($0FA, $0FC);
  if Status then UpdateStatus else
  begin
    LabelMode.Caption := 'Процесс остановлен.';
    LabelStatus.Caption := 'Ошибка передачи данных.'
  end;
  Screen.Cursor := crDefault;
  RepeatBtn.Enabled := True;
  RepeatBtn.SetFocus;
end;

procedure TDialogProcess1.Button2_OkClick(Sender: TObject);
var
  Status, DisableRepeat: boolean;
begin
  ErrorPresent := False;
  if CodCommand = $0A then begin ReadChipAndOpenFile; Exit end;
  Panel3.BringToFront;
  RepeatBtn.Enabled := False;
  LabelMode.Caption := '';
  LabelStatus.Caption := 'Подождите,  программатор  занят !';
  DialogProcess1.Update;
  if (Form1.PageControl1.ActivePage.PageIndex=1) and (cbWrite.Checked) then
  begin
    Caption := 'Запись в режиме Software Data Protection';
    CodCommand := 5;
  end;
  stFileName.Caption := ExtractFileName(ProgFileName);
  if cbAuto.Checked then Status := SelectChipAuto(CodList)
  else Status := Form1.DisplayToBlokPar;
  if Status then Status := ModifyBlokPar;
  DisableRepeat := Status;
  TempFileName := ProgFileName;
  if Status and (cbNewFile.Checked = False) then
    case CodCommand of         //Проверяем необходимость загрузки файла
      5:  if (Form1.PageControl1.ActivePage.PageIndex =1) then
            TempFileName := Main1.CheckNeedDownLoad(ProgFileName);
      7:  TempFileName := Main1.CheckNeedDownLoad(ProgFileName);
      8:  TempFileName := Main1.CheckNeedDownLoad(ProgFileName);
      11: TempFileName := Main1.CheckNeedDownLoad(ProgFileName);
    end;
  if Status and (CodCommand in [4, 6, 9]) then Status := ProccBlockRam(0, 100);
  if Status and (CodCommand in [5, 7, 8, 11]) then
  begin
    LoadAdres := HexStrToInt(edLoadAdres.Text);
    if cbNewFile.Checked or(TempFileName='') then Status := OpenLoadAndProcess
    else if (FinalAdres-BeginAdres >RamPgm)or(ProgFileName<>TempFileName) then
           Status := LoadFileAndProcess(TempFileName)
         else Status := ProccBlockRam(0, 100);
  end;
  Gauge1.Visible := False;
  if Status then Status := ReadBlokPar($13, $27) and ReadBlokPar($0FA, $0FC);
  if Status then UpdateStatus else
  begin
    LabelMode.Caption := 'Процесс остановлен.';
    LabelStatus.Caption := 'Ошибка передачи данных.'
  end;
  Screen.Cursor := crDefault;
  RepeatBtn.Enabled := DisableRepeat;
  if RepeatBtn.Enabled then RepeatBtn.SetFocus;
end;

procedure TDialogProcess1.UpdateStatus;
begin
  if ((BlokPar[$27] and 55) > 0) or ErrorPresent then
  begin                                        //Ошибки!!!
    LabelMode.Caption := 'Процесс остановлен.';
    LabelStatus.Caption := 'Ошибки в процессе работы с микросхемой.';
    case (BlokPar[$27] and 7) of
      2: LabelStatus.Caption := 'Signature error - ошибка определения микросхемы.';
      3: LabelStatus.Caption := 'Unknown chip - неизвестная микросхема.';
      4: LabelStatus.Caption := 'Faulty chip - дефектная микросхема.';
      5: LabelStatus.Caption := 'Faulty data - дефектная микросхема.';
      7: LabelStatus.Caption := 'Faulty power - дефектная микросхема.';
    end;
    if (BlokPar[$27] and $10) > 0 then         //Ошибки в процессе работы
    begin
      LabelStatus.Caption := 'Число ошибок  - ' + IntToHex(BlokPar[$0FC]*65536+BlokPar[$0FB]*256+BlokPar[$0FA], 6);
      case CodCommand of
        4: LabelMode.Caption := 'ERASE  ERROR  - Ошибка стирания.';
        5: LabelMode.Caption := 'WRITE  ERROR  - Ошибка записи.';
        6: LabelMode.Caption := 'WRITE  ERROR  - Ошибка записи.';
        7: LabelMode.Caption := 'WRITE  ERROR  - Ошибка записи микросхемы.';
        8: if (BlokPar[$27] and $20) > 0 then
             LabelMode.Caption := 'Дальнейшая запись не возможна.'
           else
             LabelMode.Caption := 'Микросхема не чистая, но запись возможна.';
        $0A: LabelMode.Caption := 'READ  ERROR  - Ошибка чтения.';
        $0B: LabelMode.Caption := 'VERIFY  ERROR  - Ошибка сравнения.';
        $2A: LabelMode.Caption := 'READ  ERROR  - Ошибка чтения.';
      end;
    end;
  end
  else
  begin                                        //Всё OK
    LabelMode.Caption := '';
    LabelStatus.Caption := 'Контрольная сумма   -  ' + IntToHex(BlokPar[$14]*256+BlokPar[$13], 4);
    case CodCommand of
      4: LabelStatus.Caption := 'ERASE  OK  - Микросхема стёрта.';
      5: LabelStatus.Caption := 'WRITE  OK  - Программирование прошло успешно.';
      6: LabelStatus.Caption := 'WRITE  OK  - Программирование прошло успешно.';
      7: LabelMode.Caption := 'WRITE  OK  - Микросхема запрограммирована.';
      8: LabelStatus.Caption := 'TEST  OK  - Микросхема чистая.';
      $0A: LabelMode.Caption := 'READ  OK  - Микросхема считана в буфер.';
      $0B: LabelMode.Caption := 'VERIFY  OK  - Сверка прошла успешно.';
      $2A: LabelMode.Caption := 'READ  OK  - Микросхема считана в компьютер.';
    end;
  end;
end;

procedure TDialogProcess1.cbNewFileClick(Sender: TObject);
begin
  edLoadAdres.Enabled := cbNewFile.Checked;
  if CodCommand = 5 then
    case Form1.PageControl1.ActivePage.PageIndex of
      2: edLoadAdres.Enabled := False;
      3: edLoadAdres.Enabled := False;
    end;
end;

procedure TDialogProcess1.edLoadAdresKeyPress(Sender: TObject;
  var Key: Char);
begin
  Key := UpCase(Key);
  if not (Key in ['0'..'9', 'A'..'F', ^H]) then Key := #0;
end;

function TDialogProcess1.SetupBlockRam(BufAdr, BegAdr, FinAdr: Integer): boolean;
begin
  BlokPar[$55] := Lo(BufAdr);          //Адреса микросхемы
  BlokPar[$56] := BufAdr shr 8;
  BlokPar[$57] := BufAdr shr 16;
  BlokPar[$58] := Lo(BegAdr);
  BlokPar[$59] := BegAdr shr 8;
  BlokPar[$5A] := BegAdr shr 16;
  BlokPar[$5B] := Lo(FinAdr);
  BlokPar[$5C] := FinAdr shr 8;
  BlokPar[$5D] := FinAdr shr 16;
  Result := WriteBlokPar($55, $5D);
end;

function TDialogProcess1.OpenLoadAndProcess: boolean;
begin
  Main1.OpenDialog1.Title := 'Загрузка файла в программатор';
  Result := Main1.OpenDialog1.Execute;
  if Result then
  begin
    cbNewFile.Checked := False;
    ProgFileName := Main1.OpenDialog1.FileName;
    Form1.StFileName.Caption := ProgFileName;
    stFileName.Caption := ExtractFileName(ProgFileName);
    Result := LoadFileAndProcess(ProgFileName);
  end;
end;

function TDialogProcess1.ModifyBlokPar: boolean;
begin
  if cbSerial.Checked then BlokPar[$2F] := BlokPar[$2F] or $80
  else BlokPar[$2F] := BlokPar[$2F] and $7F;
  if cbWrite.Checked then BlokPar[$2F] := BlokPar[$2F] or $20
  else BlokPar[$2F] := BlokPar[$2F] and $DF;
  if cbLock.Checked then BlokPar[$2F] := BlokPar[$2F] or $40
  else BlokPar[$2F] := BlokPar[$2F] and $BF;
  BlokPar[$2F] := BlokPar[$2F] and $F7;     //Отключить AUTO
  Result := WriteBlokPar($2F, $2F);
end;

{
LabelMode.Caption := 'Процесс остановлен.';
LabelMode.Caption := 'Невозможно считать состояние программатора.';
LabelStatus.Caption := 'Чтение данных завершено.';
LabelStatus.Caption := 'Загрузка файла завершена.';
LabelStatus.Caption := 'Ошибка загрузки данных в программатор.';
LabelStatus.Caption := 'Программатор не отвечает.';
LabelStatus.Caption := 'Ошибка контрольной суммы';
LabelStatus.Caption := 'Ошибка загрузки файла.';
LabelStatus.Caption := 'Ошибка чтения файла.';
LabelStatus.Caption := 'Ошибка загрузки файла в программатор.';

  case Status of
    1:  LabelStatus.Caption := 'Файл. Ошибка открытия COM-порта.';
    2:  LabelStatus.Caption := 'Загрузка файла. Ошибка заголовка.';
    3:  LabelStatus.Caption := 'Загрузка файла. Ошибка контрольной суммы.';
    4:  LabelStatus.Caption := 'Чтение файла. Ошибка заголовка.';
    5:  LabelStatus.Caption := 'Чтение файла. Ошибка контрольной суммы.';
    6:  LabelStatus.Caption := 'Команда. Ошибка открытия COM-порта.';
    7:  LabelStatus.Caption := 'Параметры. Ошибка открытия COM-порта.';
    8:  LabelStatus.Caption := 'Ошибка установки адреса блока.';
    9:  LabelStatus.Caption := 'Ошибка. Адрес буфера превышает объём файла.';
    10: LabelStatus.Caption := 'Загрузка файла. Файл не найден.';
    11: LabelStatus.Caption := 'Выбор микросхемы. Ошибка открытия COM-порта.';
    12: LabelStatus.Caption := 'Выбор микросхемы. Ошибка заголовка.';
    13: LabelStatus.Caption := 'Выбор микросхемы. Ошибка контрольной суммы.';

    $FF: LabelStatus.Caption := 'Ошибка определения типа микросхемы.';
  end;}

procedure TDialogProcess1.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ExtractFileExt(TempFileName)= '.~MP' then DeleteFile(TempFileName);
  Form1.UpdateContrPanel(BlokPar[$2E]);
  case BlokPar[$2E] of
    1:  Form1.UpdateAutoTabShet1;
    2:  Form1.UpdateAutoTabShet2;
    4:  Form1.UpdateAutoTabShet3;
    8:  Form1.UpdateAutoTabShet4;
    16: Form1.UpdateAutoTabShet5;
    32: Form1.UpdateAutoTabShet6;
  end;
  Action := caHide;
end;

end.
