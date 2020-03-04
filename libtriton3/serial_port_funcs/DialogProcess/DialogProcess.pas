unit DialogProcess;

interface

uses LCLIntf, LCLType, LMessages, SysUtils, Classes, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Graphics, Dialogs, ComCtrls;

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
    ProgressBar1: TProgressBar;
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

function TDialogProcess1.ProccBlockRam(BegPos, FinPos: integer): boolean;
var
  RxdAck, TxdByte: byte;
  dwSent: DWord;
  FirstZapros: boolean;
begin
  Screen.Cursor := crHourGlass;
  ProgressBar1.Visible := False;
  case CodCommand of
    4:    LabelMode.Caption := 'Erasing...';
    5:    if Form1.PageControl1.ActivePage.PageIndex <> 1 then
            LabelMode.Caption := 'Programming...';
    6:    LabelMode.Caption := 'Programming...';
    7:  begin LabelMode.Caption := 'Записано:';
          ProgressBar1.Min := 0;
          ProgressBar1.Max := FinPos;
          ProgressBar1.Position := BegPos;
//ProgressBar1.ForeColor := clBlue;
          ProgressBar1.Visible := True;
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
    //ReadFile(FPort, RxdAck, 1, dwSent, nil);
    dwSent := FileRead(FPort, RxdAck, 1);
    if dwSent = 0 then Continue;
    case RxdAck of
      $0AA: begin
              if FirstZapros then TxdByte := $10
              else if MessageDlg('Микросхема не чистая.'+#13+'Дальнейшая запись не возможна.'+#13+#13+
                  'Продолжать ?', mtConfirmation, [mbNo, mbYes], 0)= mrYes then TxdByte := $10
                   else TxdByte := $40;
              DialogProcess1.Update;
              FirstZapros := False;
              //WriteFile(FPort, TxdByte, 1, dwSent, nil);
              dwSent := FileWrite(FPort, TxdByte, 1);
              if TxdByte = $40 then
              begin
                FileClose(FPort);
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
              dwSent := FileWrite(FPort, TxdByte, 1);
            end;
    else if CodCommand = 7 then ProgressBar1.Position := ProgressBar1.Position + 1;
    end;
  until RxdAck = $0AF;
  FileClose(FPort);
end;


function TDialogProcess1.SaveBinDataToFile(var FN: file): boolean;
var
  Buf: array[1..256] of byte;
  RxdAck, TxdSum: byte;
  dwSent: DWord;
  RxBlok, Counter, k: Integer;
begin
  LabelMode.Caption := 'Сохранено:';
//ProgressBar1.ForeColor := clLime;
  ProgressBar1.Visible := True;
  Main1.Update;
  DialogProcess1.Update;
  Result := OpenComPortSearch($14, iCOMPort) = $14;
  if Result then
  begin
    TxdSum := 0;
    for k := 1 to 3 do                         //Прием заголовка
    begin
      //WriteFile(FPort, TxdSum, 1, dwSent, nil);
      dwSent := FileWrite(FPort, TxdSum, 10);
      //ReadFile(FPort, RxdAck, 1, dwSent, nil);
      dwSent := FileRead(FPort, RxdAck, 1);
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
          //WriteFile(FPort, TxdSum, 1, dwSent, nil);
          dwSent := FileWrite(FPort, TxdSum, 1);
          //ReadFile(FPort, RxdAck, 1, dwSent, nil);
          dwSent := FileRead(FPort, RxdAck, 1);
          if dwSent = 0 then Break;
          Buf[k] := RxdAck;
          TxdSum := (TxdSum + RxdAck)and $FF;
        end;
        if dwSent = 0 then Break;
        BlockWrite(FN, Buf, Counter, dwSent);
        ProgressBar1.Position := ProgressBar1.Position + Counter;
        RxBlok := RxBlok - Counter;
      until RxBlok = 0;
      Result := ControlCheckSumm(TxdSum);
    end;
  end;
  FileClose(FPort);
end;

function TDialogProcess1.DownloadHexFile(var FN: file): boolean;
var
  Buf: array[1..256] of byte;
  dwSent: DWord;
  TxdSum, RxdAck, i: byte;
begin
  LabelMode.Caption := 'Загружено:';
//ProgressBar1.ForeColor := clRed;
  ProgressBar1.Visible := True;
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
    //WriteFile(FPort, Buf, i, dwSent, nil);
    dwSent := FileWrite(FPort, Buf, i);
    Result := ControlCheckSumm(TxdSum);
    if not Result then Break;
    ProgressBar1.Position := ProgressBar1.Position + i + 2;
  until EOF(FN);
  FileClose(FPort);
end;

function TDialogProcess1.DownloadBinFile(var FN: file; BegAdr, LengthNum: Integer): boolean;
var
  Buf: array[1..256] of byte;
  dwSent: DWord;
  TxdSum: byte;
  NumRd, i, EndLoad: Integer;
begin
  LabelMode.Caption := 'Загружено:';
//ProgressBar1.ForeColor := clRed;
  ProgressBar1.Visible := True;
  Main1.Update;
  DialogProcess1.Update;
  EndLoad := ProgressBar1.Position + LengthNum;
  Result := OpenComPortSearch($10, iCOMPort) = $10;
  if Result then Result := LoadHeader(BegAdr, LengthNum);
  if Result then
  begin
    TxdSum := 0;
    repeat
      BlockRead(FN, Buf, SizeOf(Buf), NumRd);
      ProgressBar1.Position := ProgressBar1.Position + NumRd;
      for i := 1 to NumRd do TxdSum := (TxdSum + Buf[i]) and $FF;
      //WriteFile(FPort, Buf, NumRd, dwSent, nil);
      dwSent := FileWrite(FPort, Buf, NumRd);
    until (ProgressBar1.Position >= EndLoad) or EOF(FN);
    Result := ControlCheckSumm(TxdSum);
  end;
  FileClose(FPort);
end;
