unit Triton_prog;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Buttons, StdCtrls, MaskEdit, ComCtrls;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label26: TLabel;
    Button1_1: TButton;
    ComboBox1: TComboBox;
    TabSheet2: TTabSheet;
    Label12: TLabel;
    Label14: TLabel;
    ComboBox2: TComboBox;
    Button2_2: TButton;
    Button2_3: TButton;
    RadioGroup2: TRadioGroup;
    CheckBox2_3: TCheckBox;
    Button2_1: TButton;
    TabSheet3: TTabSheet;
    Label8: TLabel;
    Label13: TLabel;
    ComboBox3: TComboBox;
    RadioGroup3: TRadioGroup;
    Button3_1: TButton;
    Button3_2: TButton;
    Button3_3: TButton;
    CheckBox3_3: TCheckBox;
    CheckBox3_2: TCheckBox;
    GroupBox3_2: TGroupBox;
    Label4: TLabel;
    meEncr3: TMaskEdit;
    Button3_21: TButton;
    Button3_22: TButton;
    TabSheet4: TTabSheet;
    Label1: TLabel;
    Label3: TLabel;
    ComboBox4: TComboBox;
    Button4_1: TButton;
    Button4_2: TButton;
    CheckBox4_2: TCheckBox;
    GroupBox4_2: TGroupBox;
    Label6: TLabel;
    meEeprom4: TMaskEdit;
    Button4_21: TButton;
    Button4_22: TButton;
    TabSheet5: TTabSheet;
    Label24: TLabel;
    Label10: TLabel;
    ComboBox5: TComboBox;
    TabSheet6: TTabSheet;
    Label25: TLabel;
    Label11: TLabel;
    ComboBox6: TComboBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    CheckBox1: TCheckBox;
    Label2: TLabel;
    Label15: TLabel;
    LbPuls: TLabel;
    ComBoxVpp: TComboBox;
    ComBoxPuls: TComboBox;
    Label16: TLabel;
    LbNumb: TLabel;
    ComBoxVccwr: TComboBox;
    ComBoxNumb: TComboBox;
    Label36: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    ComBoxVccnom: TComboBox;
    ComBoxVccmin: TComboBox;
    ComBoxVccmax: TComboBox;
    Label22: TLabel;
    Label23: TLabel;
    Label35: TLabel;
    meBegin1: TMaskEdit;
    meFinal1: TMaskEdit;
    meBufer1: TMaskEdit;
    Button1: TButton;
    StFileName: TStaticText;
    Bevel1: TBevel;
    Bevel2: TBevel;
    LbPage: TLabel;
    ComBoxPage: TComboBox;
    btnPIC: TButton;
    Panel2: TPanel;
    GroupBox4_4: TGroupBox;
    Label4_6: TLabel;
    Label4_7: TLabel;
    Label4_8: TLabel;
    Label4_9: TLabel;
    ComboBox4_6: TComboBox;
    ComboBox4_7: TComboBox;
    ComboBox4_8: TComboBox;
    ComboBox4_9: TComboBox;
    Panel1: TPanel;
    GroupBox4_3: TGroupBox;
    Label4_1: TLabel;
    Label4_2: TLabel;
    Label4_3: TLabel;
    Label4_4: TLabel;
    Label4_5: TLabel;
    ComboBox4_1: TComboBox;
    ComboBox4_2: TComboBox;
    ComboBox4_3: TComboBox;
    ComboBox4_4: TComboBox;
    ComboBox4_5: TComboBox;
    CheckBox5_3: TCheckBox;
    Button5_3: TButton;
    RadioGroup5_3: TRadioGroup;
    Label4_10: TLabel;
    ComboBox4_10: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ComBoxVppChange(Sender: TObject);
    procedure ComBoxVccwrChange(Sender: TObject);
    procedure ComBoxVccnomChange(Sender: TObject);
    procedure ComBoxVccminChange(Sender: TObject);
    procedure ComBoxVccmaxChange(Sender: TObject);
    procedure ComBoxPulsChange(Sender: TObject);
    procedure ComBoxNumbChange(Sender: TObject);
    procedure meAddressChange(Sender: TObject);
    procedure meBegin1Exit(Sender: TObject);
    procedure meFinal1Exit(Sender: TObject);
    procedure meBufer1Exit(Sender: TObject);
    procedure meAddressKeyPress(Sender: TObject; var Key: Char);
    procedure RadioGroup2Click(Sender: TObject);
    procedure CheckBox2_3Click(Sender: TObject);
    procedure meEncr3Exit(Sender: TObject);
    procedure CheckBox3_2Click(Sender: TObject);
    procedure RadioGroup3Click(Sender: TObject);
    procedure CheckBox3_3Click(Sender: TObject);
    procedure meEeprom4Exit(Sender: TObject);
    procedure CheckBox4_2Click(Sender: TObject);
    procedure ComboBox1DropDown(Sender: TObject);
    procedure ComboBox2DropDown(Sender: TObject);
    procedure ComboBox3DropDown(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure ComboBox4Change(Sender: TObject);
    procedure ComboBox5Change(Sender: TObject);
    procedure ComboBox6Change(Sender: TObject);
    procedure UpdateContrPanel(var Num_List: byte);
    procedure UpdateAutoTabShet1;
    procedure UpdateAutoTabShet2;
    procedure UpdateAutoTabShet3;
    procedure UpdateAutoTabShet4;
    procedure UpdateAutoTabShet5;
    procedure UpdateAutoTabShet6;
    procedure UpdateTabShet1;
    procedure UpdateTabShet2;
    procedure UpdateTabShet3;
    procedure UpdateTabShet4;
    procedure UpdateTabShet5;
    procedure UpdateTabShet6;
    procedure PageControl1Change(Sender: TObject);
    procedure BlokParToDisplay;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure Button1_1Click(Sender: TObject);
    procedure Button2_2Click(Sender: TObject);
    procedure Button2_3Click(Sender: TObject);
    procedure Button4_21Click(Sender: TObject);
    procedure Button3_21Click(Sender: TObject);
    procedure Button3_22Click(Sender: TObject);
    procedure Button4_22Click(Sender: TObject);
    function DisplayToBlokPar: boolean;
    function WordToConfigPic: boolean;
    function ConfigPicToWord: boolean;
    procedure UpdateConfigPIC(Sender: TObject);
    procedure ComBoxPageChange(Sender: TObject);
    procedure btnPICClick(Sender: TObject);
    function UpdataPIC12C_5xx: boolean;
    function UpdataPIC16C_505: boolean;
    function UpdataPIC12C_67x: boolean;
    function UpdataPIC16C_55x: boolean;
    function UpdataPIC16C_18pinOLD: boolean;
    function UpdataPIC16C_62x: boolean;
    function UpdataPIC16C_71x: boolean;
    function UpdataPIC16C_xxOLD: boolean;
    function UpdataPIC16C_xxNEW: boolean;
    function UpdataPIC16F_xx: boolean;
    function UpdataPIC16F_87x: boolean;
    function UpdataPIC16C_92x: boolean;
    function UpdataPIC16C_77x: boolean;
    function UpdataPIC16C_715: boolean;
    function UpdataPIC16F_62x: boolean;
    procedure RadioGroup5_3Click(Sender: TObject);
    procedure CheckBox5_3Click(Sender: TObject);
  end;

  function ReadChipBlok: Boolean;
  function SelectTypeChip(ListNumber: byte; ChipNumber: Integer): Integer;
  function WriteBlokPar(BlokBegin, BlokEnd: Integer): Boolean;
  function ReadBlokPar(BlokBegin, BlokEnd: Integer): Boolean;
  function LoadHeader(BlokBegin, BlokLength: Integer): Boolean;
  function WriteBlokRam(BlokBegin, BlokLength: Integer; var Buffer: array of byte): Boolean;
  function ReadBlokRam(BlokBegin, BlokLength: Integer; var Buffer: array of byte): Boolean;


var
  Form1: TForm1;

implementation

uses Triton_Main1, DialogProcess, HEdit;

{$R *.lfm}


function ReadChipBlok: Boolean;
var
  TxdBuf: array[1..2] of byte;
  RxdBuf: array[1..9] of char;
  TxdSum: byte;
  dwSent: DWord;
  i, k, n: Integer;
  Error: PChar;
begin
  Error := 'Ошибка открытия COM порта.';
  Form1.ComboBox1.Items.Clear;
  Form1.ComboBox2.Items.Clear;
  Form1.ComboBox3.Items.Clear;
  Form1.ComboBox4.Items.Clear;
  Form1.ComboBox5.Items.Clear;
  Form1.ComboBox6.Items.Clear;
  Result :=(OpenComPortSearch($1C,iCOMPort)=$1C)and FileRead(FPort); { *Converted from ReadFile*  }
  if Result then for n := 1 to 8 do
  begin
    if ChipBlok[n] > 0 then for k := 0 to ChipBlok[n] -1 do
    begin
      Sleep(2);
      TxdBuf[1] := $30;
      TxdBuf[2] := 9;
      WriteFile(FPort, TxdBuf, 2, dwSent, nil);
      FileRead(FPort); { *Converted from ReadFile*  }
      TxdSum := 0;
      for i := 1 to 9 do TxdSum := (TxdSum + Ord(RxdBuf[i])) and $FF;
      Result := ControlCheckSumm(TxdSum);
      if not Result then Break else
      case n of
        1: Form1.ComboBox1.Items.Append(RxdBuf);
        2: Form1.ComboBox2.Items.Append(RxdBuf);
        3: Form1.ComboBox3.Items.Append(RxdBuf);
        4: Form1.ComboBox4.Items.Append(RxdBuf);
        5: Form1.ComboBox5.Items.Append(RxdBuf);
        6: Form1.ComboBox6.Items.Append(RxdBuf);
      end;
    end;
    if not Result then Break;
    Error := 'Блок микросхем. Ошибка КС.';
  end;
  FileClose(FPort); { *Converted from CloseHandle*  }
  if not Result then MessageBox(0,Error,'Инициализация',mb_IconStop or mb_TaskModal);
end;

function SelectTypeChip(ListNumber: byte; ChipNumber: Integer): Integer;
var
  Buf: array[0..127] of byte;
  TxdSum: byte;
  dwSent: DWord;
  k: Integer;
  Stat: boolean;
begin
  Stat := False;
  Result := 11;
  if OpenComPortSearch($16, iCOMPort) = $16 then
  begin
    Buf[0] := $2E;                            //Адрес
    Buf[1] := 3;                              //Длина
    Buf[2] := ListNumber;
    Buf[3] := BlokPar[$2F] and $FD;
    Buf[4] := ChipNumber;
    TxdSum := (Buf[2] + Buf[3] + Buf[4]) and $FF;
    WriteFile(FPort, Buf, 5, dwSent, nil);
    Result := 12;
    if ControlCheckSumm(TxdSum) then
    begin
      Buf[0] := $2D;
      Buf[1] := $85 - $2D + 1;
      TxdSum := Buf[1];
      FileRead(FPort); { *Converted from ReadFile*  }
      if (Result = 0) and (dwSent = 1) then
      begin
        WriteFile(FPort, Buf, 2, dwSent, nil);
        Stat := FileRead(FPort); { *Converted from ReadFile*  }
        TxdSum := 0;
        if Stat then for k := 0 to dwSent-1 do TxdSum :=(TxdSum+Buf[k])and $FF;
        if Stat then Stat := ControlCheckSumm(TxdSum);
        if Stat then for k := 0 to dwSent-1 do BlokPar[k+$2D] := Buf[k];
        if not Stat then Result := 13;
      end;
    end;
  end;
  FileClose(FPort); { *Converted from CloseHandle*  }
  if Stat then Form1.UpdateContrPanel(ListNumber);
//  if not Result then MessageBox(0,'Прием блока параметров. Ошибка КС.','Выбор микросхемы',mb_IconStop or mb_TaskModal);
end;

function WriteBlokPar(BlokBegin, BlokEnd: Integer): Boolean;
var
  Buf: array[0..1] of byte;
  TxdSum: byte;
  dwSent: DWord;
  k: Integer;
begin
  Result := OpenComPortSearch($11, iCOMPort) = $11;
  if Result then
  begin
    Buf[0] := BlokBegin;
    Buf[1] := BlokEnd - BlokBegin + 1;
    WriteFile(FPort, Buf, 2, dwSent, nil);
    TxdSum := 0;
    for k := BlokBegin to BlokEnd do TxdSum :=(TxdSum + BlokPar[k])and $FF;
    WriteFile(FPort,BlokPar[BlokBegin],(BlokEnd-BlokBegin+1),dwSent,nil);
    Result := ControlCheckSumm(TxdSum);
  end;
  FileClose(FPort); { *Converted from CloseHandle*  }
  if not Result then MessageBox(0,'Передача блока параметров. Ошибка КС.','Загрузка данных',mb_IconStop or mb_TaskModal);
end;

function ReadBlokPar(BlokBegin, BlokEnd: Integer): Boolean;
var
  Buf: array[0..255] of byte;
  TxdSum: byte;
  dwSent: DWord;
  k: Integer;
begin
  Result := OpenComPortSearch($15, iCOMPort) = $15;
  if Result then
  begin
    Buf[0] := BlokBegin;
    Buf[1] := BlokEnd - BlokBegin + 1;
    TxdSum := Buf[1];
    WriteFile(FPort, Buf, 2, dwSent, nil);
    Result := FileRead(FPort); { *Converted from ReadFile*  }
    TxdSum := 0;
    if Result then for k := 0 to dwSent-1 do TxdSum :=(TxdSum + Buf[k])and $FF;
    if Result then Result := ControlCheckSumm(TxdSum);
    if Result then for k := 0 to dwSent-1 do BlokPar[k+BlokBegin] := Buf[k];
  end;
  FileClose(FPort); { *Converted from CloseHandle*  }
  if not Result then MessageBox(0,'Прием блока параметров. Ошибка КС.','Загрузка данных',mb_IconStop or mb_TaskModal);
end;

function LoadHeader(BlokBegin, BlokLength: Integer): Boolean;
var
  Buf: array[0..10] of byte;
  TxdSum: byte;
  dwSent: DWord;
  k: Integer;
begin
  Buf[0] := $30;
  Buf[1] := 9;
  Buf[2] := Lo(BlokBegin);
  Buf[3] := BlokBegin shr 8;
  Buf[4] := BlokBegin shr 16;
  Buf[5] := 0;
  Buf[6] := 0;
  Buf[7] := 0;
  Buf[8] := Lo(BlokLength -1);
  Buf[9] := (BlokLength -1) shr 8;
  Buf[10]:= (BlokLength -1) shr 16;
  TxdSum := 0;
  for k := 2 to 10 do TxdSum :=(TxdSum + Buf[k])and $FF;
  WriteFile(FPort, Buf, 11, dwSent, nil);
  Result := ControlCheckSumm(TxdSum);
end;

function WriteBlokRam(BlokBegin, BlokLength: Integer; var Buffer: array of byte): Boolean;
var
  TxdSum: byte;
  dwSent: DWord;
  i: Integer;
begin
  Result := OpenComPortSearch($10, iCOMPort) = $10;
  if Result then Result := LoadHeader(BlokBegin, BlokLength);
  if Result then
  begin
    TxdSum := 0;
    for i := 0 to (BlokLength - 1) do TxdSum :=(TxdSum + Buffer[i])and $FF;
    WriteFile(FPort, Buffer, BlokLength, dwSent, nil);
    Result := ControlCheckSumm(TxdSum);
  end;
  FileClose(FPort); { *Converted from CloseHandle*  }
  if not Result then MessageBox(0,'Ошибка загрузки данных в программатор.','Загрузка данных',mb_IconStop or mb_TaskModal);
end;

function ReadBlokRam(BlokBegin, BlokLength: Integer; var Buffer: array of byte): Boolean;
var
  RxdAck, TxdSum: byte;
  dwSent: DWord;
  i: Integer;
begin
  Result := OpenComPortSearch($1D, iCOMPort) = $1D;
  if Result then Result := LoadHeader(BlokBegin, BlokLength);
  if Result then
  begin
    TxdSum := 0;
    for i := 0 to (BlokLength - 1) do
    begin
      WriteFile(FPort, TxdSum, 1, dwSent, nil);
      FileRead(FPort); { *Converted from ReadFile*  }
      TxdSum := (TxdSum + RxdAck)and $FF;
      Buffer[i] := RxdAck;
      if dwSent = 0 then Break;
    end;
    Result := ControlCheckSumm(TxdSum);
  end;
  FileClose(FPort); { *Converted from CloseHandle*  }
  if not Result then MessageBox(0,'Ошибка чтения данных из ОЗУ.','Загрузка данных',mb_IconStop or mb_TaskModal);
end;


procedure TForm1.FormCreate(Sender: TObject);
var
  i: integer;
begin
  Main1.StatusBar.SimplePanel := True;
  Main1.StatusBar.SimpleText := '  Инициализация программатора . . .';
  Main1.StatusBar.Update;
  ProgrammerEnabled := False;
  if not(ComEn[1] or ComEn[2] or ComEn[3] or ComEn[4]) then
    Main1.StatusBar.SimpleText := '  Нет доступных COM портов.'
  else
  begin
    for i := 0 to 3 do if ComEn[i+1] then
    begin
      ProgrammerVersion := OpenComPort($1F, i);
      ProgrammerEnabled := ProgrammerVersion in [$1E, $1F];
      if ProgrammerEnabled then
      begin
        iCOMPort := i;
        case iCOMPort of
          0: Main1.MenuCOM11.Checked := True;
          1: Main1.MenuCOM21.Checked := True;
          2: Main1.MenuCOM31.Checked := True;
          3: Main1.MenuCOM41.Checked := True;
        end;
        Main1.StatusBar.SimplePanel := False;
        Break;
      end;
    end;
  end;
  if ProgrammerEnabled then ProgrammerEnabled := ReadChipBlok and ReadBlokPar($2C, $FF);
  if ProgrammerEnabled then
  begin
    RamPgm := BlokPar[$FD] + BlokPar[$FE]*256 + BlokPar[$FF]*65536 + 1;
    BlokPar[$2F] := BlokPar[$2F] and $FD; // Сброс флага "Запрос-ответ"
    if BlokPar[$2C] >= 128 then
    begin
      UpdateContrPanel(BlokPar[$2E]);
      case BlokPar[$2E] of
        1:  UpdateAutoTabShet1;
        2:  UpdateAutoTabShet2;
        4:  UpdateAutoTabShet3;
        8:  begin
              UpdateAutoTabShet4;
              TabSheet4.Enabled := ProgrammerVersion = $1E;
              if ProgrammerVersion <> $1E then
               MessageBox(0, 'Для работы с PIC контроллерами необходима версия программатора не ниже V3.45',
               'Инициализация программатора',mb_IconStop or mb_TaskModal);
            end;
        16: UpdateAutoTabShet5;
        32: UpdateAutoTabShet6;
      end;
    end
    else
    begin
      Main1.StatusBar.SimplePanel := True;
      Main1.StatusBar.SimpleText := '  Начните работу с выбора типа микросхемы !';
      ComboBox1.ItemIndex := 0;
      SelectTypeChip(1, ComboBox1.ItemIndex);
    end;
  end;
  if ProgrammerEnabled then Form1.WindowState := wsNormal
  else Form1.WindowState := wsMinimized;
  Form1.Enabled := ProgrammerEnabled;
  Main1.MenuComm.Enabled := ProgrammerEnabled;
  Main1.MenuFileLoad.Enabled := ProgrammerEnabled;
  Main1.MenuFileSave.Enabled := ProgrammerEnabled;
  Main1.MenuOptAutoWrite.Enabled := ProgrammerEnabled;
  Main1.MenuOptClearMemory.Enabled := ProgrammerEnabled;
  Main1.MenuOptSQTP.Enabled := ProgrammerEnabled;
  Main1.BlankButton.Enabled := ProgrammerEnabled;
  Main1.CheckButton.Enabled := ProgrammerEnabled;
  Main1.RDButton.Enabled := ProgrammerEnabled;
  Main1.ProgButton.Enabled := ProgrammerEnabled;
  Main1.VerifyButton.Enabled := ProgrammerEnabled;
  if not ProgrammerEnabled then MessageBox(0,PChar('Программатор не отвечает.'+#13+#13
      +'Проверьте интерфейсный кабель,'+#13+'питание программатора и'+#13
      +'установите режим ''Select mode''.'),'Инициализация программатора',mb_IconStop or mb_TaskModal);
end;


procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then BlokPar[$2F] := BlokPar[$2F] or $08
  else BlokPar[$2F] := BlokPar[$2F] and $F7;
  if not WriteBlokPar($2F, $2F) then CheckBox1.Checked :=(BlokPar[$2F] and $08)=0;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Main1.MenuFileLoadClick(Sender);
end;

procedure TForm1.ComBoxVppChange(Sender: TObject);
begin
  CheckBox1.Checked := False;
  BlokPar[$4C] := ComBoxVpp.ItemIndex + 10;      //Напряжение записи
  if not WriteBlokPar($4C, $4C) then ComBoxVpp.ItemIndex := -1;
end;

procedure TForm1.ComBoxVccwrChange(Sender: TObject);
begin
  CheckBox1.Checked := False;
  BlokPar[$54] := ComBoxVccwr.ItemIndex + 10;    //Напряжения питания
  if not WriteBlokPar($54, $54) then ComBoxVccwr.ItemIndex := -1;
end;

procedure TForm1.ComBoxVccnomChange(Sender: TObject);
begin
  CheckBox1.Checked := False;
  BlokPar[$53] := ComBoxVccnom.ItemIndex + 10;   //Напряжения питания
  if not WriteBlokPar($53, $53) then ComBoxVccnom.ItemIndex := -1;
end;

procedure TForm1.ComBoxVccminChange(Sender: TObject);
begin
  CheckBox1.Checked := False;
  BlokPar[$51] := ComBoxVccmin.ItemIndex + 10;   //Напряжения питания
  if not WriteBlokPar($51, $51) then ComBoxVccmin.ItemIndex := -1;
end;

procedure TForm1.ComBoxVccmaxChange(Sender: TObject);
begin
  CheckBox1.Checked := False;
  BlokPar[$52] := ComBoxVccmax.ItemIndex + 10;   //Напряжения питания
  if not WriteBlokPar($52, $52) then ComBoxVccmax.ItemIndex := -1;
end;

procedure TForm1.ComBoxPulsChange(Sender: TObject);
begin
  CheckBox1.Checked := False;                  //Длительность импульса записи
  if ComBoxPuls.ItemIndex >= 9 then BlokPar[$4D] := ComBoxPuls.ItemIndex + 120
  else BlokPar[$4D] := ComBoxPuls.ItemIndex + 1;
  if not WriteBlokPar($4D, $4D) then ComBoxPuls.ItemIndex := -1;
end;

procedure TForm1.ComBoxNumbChange(Sender: TObject);
begin
  CheckBox1.Checked := False;
  BlokPar[$6C] := ComBoxNumb.ItemIndex + 1;      //Количество импульсов записи
  if not WriteBlokPar($6C, $6C) then ComBoxNumb.ItemIndex := -1;
end;

procedure TForm1.ComBoxPageChange(Sender: TObject);
begin
  case ComBoxPage.ItemIndex of
    0: BlokPar[$4D] := 1;
    1: BlokPar[$4D] := 2;
    2: BlokPar[$4D] := 4;
    3: BlokPar[$4D] := 8;
    4: BlokPar[$4D] := 16;
    5: BlokPar[$4D] := 32;
    6: BlokPar[$4D] := 64;
    7: BlokPar[$4D] := 128;
    8: BlokPar[$4D] := 0;
  end;
  if not WriteBlokPar($4D, $4D) then ComBoxPuls.ItemIndex := -1;
end;

procedure TForm1.meAddressChange(Sender: TObject);
begin
  CheckBox1.Checked := False;
end;

procedure TForm1.meBegin1Exit(Sender: TObject);
var
  i: Integer;
begin
  i := HexStrToInt(meBegin1.Text);
  if (PageControl1.ActivePage = TabSheet4) and (i<>0) then
  begin
    MessageBox(0,'Для PIC контроллеров начальный адрес должен быть равен нулю.','Установка адреса',MB_ICONWARNING or mb_TaskModal);
    i := 0;
    meBegin1.Text := IntToHex(BeginAdres, 6);
  end;
  if (i > FinalAdres) or (i > MaxAdres) then
  begin
    MessageBox(0,'Начальный адрес. Недопустимое значение.','Установка адреса',MB_ICONWARNING or mb_TaskModal);
    meBegin1.Text := IntToHex(BeginAdres, 6);
    meBegin1.SetFocus;
    meBegin1.SelectAll;
  end
  else
  begin
    BeginAdres := i;
    meBegin1.Text := IntToHex(BeginAdres, 6);
    BlokPar[$58] := Lo(BeginAdres);
    BlokPar[$59] := BeginAdres shr 8;
    BlokPar[$5A] := BeginAdres shr 16;
    if not WriteBlokPar($58, $5A) then meBegin1.Text := '';
  end;
end;

procedure TForm1.meFinal1Exit(Sender: TObject);
var
  i: Integer;
begin
  i := HexStrToInt(meFinal1.Text);
  if (i < BeginAdres) or (i > MaxAdres) then
  begin
    MessageBox(0,'Конечный адрес. Недопустимое значение.','Установка адреса',MB_ICONWARNING or mb_TaskModal);
    meFinal1.Text := IntToHex(FinalAdres, 6);
    meFinal1.SetFocus;
    meFinal1.SelectAll;
  end
  else
  begin
    FinalAdres := i;
    meFinal1.Text := IntToHex(FinalAdres, 6);
    BlokPar[$5B] := Lo(FinalAdres);
    BlokPar[$5C] := FinalAdres shr 8;
    BlokPar[$5D] := FinalAdres shr 16;
    if not WriteBlokPar($5B, $5D) then meFinal1.Text := '';
  end;
end;

procedure TForm1.meBufer1Exit(Sender: TObject);
var
  i: Integer;
begin
  i := HexStrToInt(meBufer1.Text);
  if i > RamPgm then
  begin
    MessageBox(0,'Адрес буфера. Недопустимое значение.','Установка адреса',MB_ICONWARNING or mb_TaskModal);
    meBufer1.Text := IntToHex(BuferAdres, 6);
    meBufer1.SetFocus;
    meBufer1.SelectAll;
  end
  else
  begin
    BuferAdres := i;
    meBufer1.Text := IntToHex(BuferAdres, 6);
    BlokPar[$55] := Lo(BuferAdres);
    BlokPar[$56] := BuferAdres shr 8;
    BlokPar[$57] := BuferAdres shr 16;
    if not WriteBlokPar($55, $57) then meBufer1.Text := '';
  end;
end;

procedure TForm1.meEncr3Exit(Sender: TObject);
var
  i: Integer;
begin
  i := HexStrToInt(meEncr3.Text);
  if i > RamPgm then
  begin
    MessageBox(0,'Адрес превышает объём памяти.','Установка адреса',MB_ICONWARNING or mb_TaskModal);
    meEncr3.Text := IntToHex(EncrpAdres, 6);
    meEncr3.SetFocus;
    meEncr3.SelectAll;
  end
  else
  begin
    EncrpAdres := i;
    meEncr3.Text := IntToHex(EncrpAdres, 6);
    BlokPar[$60] := Lo(EncrpAdres);
    BlokPar[$61] := EncrpAdres shr 8;
    BlokPar[$62] := EncrpAdres shr 16;
    if not WriteBlokPar($60, $62) then meEncr3.Text := '';
  end;
end;

procedure TForm1.meEeprom4Exit(Sender: TObject);
var
  i: Integer;
begin
  i := HexStrToInt(meEeprom4.Text);
  if i > RamPgm then
  begin
    MessageBox(0,'Адрес превышает объём памяти.','Установка адреса',MB_ICONWARNING or mb_TaskModal);
    meEeprom4.Text := IntToHex(EncrpAdres, 6);
    meEeprom4.SetFocus;
    meEeprom4.SelectAll;
  end
  else
  begin
    EncrpAdres := i;
    meEeprom4.Text := IntToHex(EncrpAdres, 6);
    BlokPar[$60] := Lo(EncrpAdres);
    BlokPar[$61] := EncrpAdres shr 8;
    BlokPar[$62] := EncrpAdres shr 16;
    if not WriteBlokPar($60, $62) then meEeprom4.Text := '';
  end;
end;

procedure TForm1.meAddressKeyPress(Sender: TObject; var Key: Char);
begin
  Key := UpCase(Key);
  if not (Key in ['0'..'9', 'A'..'F', ^H]) then Key := #0;
end;

procedure TForm1.RadioGroup2Click(Sender: TObject);
begin
  CheckBox1.Checked := False;
  if (RadioGroup2.ItemIndex + 1) > BlokPar[$6D] then
  begin
    MessageBox(0,'Этот сектор недоступен!','Выбор загрузочного сектора',mb_IconExclamation or mb_TaskModal);
    BlokPar[$4B] := BlokPar[$6D];
    RadioGroup2.ItemIndex := BlokPar[$6D] - 1;
  end
  else BlokPar[$4B] := RadioGroup2.ItemIndex + 1; //Количество бит защиты
  if not WriteBlokPar($4B, $4B) then RadioGroup2.ItemIndex := -1;
end;

procedure TForm1.CheckBox2_3Click(Sender: TObject);
begin
  if CheckBox2_3.Checked then BlokPar[$2F] := BlokPar[$2F] or $40
  else BlokPar[$2F] := BlokPar[$2F] and $BF;
  if not WriteBlokPar($2F, $2F) then CheckBox2_3.State := cbGrayed;
end;

procedure TForm1.CheckBox3_2Click(Sender: TObject);
begin
  if CheckBox3_2.Checked then BlokPar[$2F] := BlokPar[$2F] or $20
  else BlokPar[$2F] := BlokPar[$2F] and $DF;
  if not WriteBlokPar($2F, $2F) then CheckBox3_2.State := cbGrayed;
end;

procedure TForm1.RadioGroup3Click(Sender: TObject);
begin
  CheckBox1.Checked := False;
  if (RadioGroup3.ItemIndex + 1) > BlokPar[$6D] then
  begin
    MessageBox(0,'Этого бита защиты в микросхеме нет!','Установка битов защиты',mb_IconExclamation or mb_TaskModal);
    BlokPar[$4B] := BlokPar[$6D];
    RadioGroup3.ItemIndex := BlokPar[$6D] - 1;
  end
  else BlokPar[$4B] := RadioGroup3.ItemIndex + 1; //Количество бит защиты
  if not WriteBlokPar($4B, $4B) then RadioGroup3.ItemIndex := -1;
end;

procedure TForm1.CheckBox3_3Click(Sender: TObject);  //Lock bits
begin
  if CheckBox3_3.Checked then BlokPar[$2F] := BlokPar[$2F] or $40
  else BlokPar[$2F] := BlokPar[$2F] and $BF;
  if not WriteBlokPar($2F, $2F) then CheckBox3_3.State := cbGrayed;
end;

procedure TForm1.CheckBox4_2Click(Sender: TObject);  //EEPROM data
begin
  if CheckBox4_2.Checked then BlokPar[$2F] := BlokPar[$2F] or $20
  else  BlokPar[$2F] := BlokPar[$2F] and $DF;
  if not WriteBlokPar($2F, $2F) then CheckBox4_2.State := cbGrayed;
end;


procedure TForm1.UpdateContrPanel(var Num_List: byte);
var
  k: integer;
begin
  for k := 1 to 9 do ChipName[k] := Chr(BlokPar[k+$3F]);
  Main1.StChipName.Caption := ChipName;
  case Num_List of
    1:  UpdateTabShet1;
    2:  UpdateTabShet2;
    4:  UpdateTabShet3;
    8:  UpdateTabShet4;
    16: UpdateTabShet5;
    32: UpdateTabShet6;
  end;
  Main1.Update;
  Form1.Update;
end;

procedure TForm1.UpdateTabShet1;
begin
  PageControl1.ActivePage := TabSheet1;
  BlokParToDisplay;
  Button1_1.Enabled := (BlokPar[$2D] and 16) > 0;
  Main1.MenuCommClick(Self);
end;

procedure TForm1.UpdateTabShet2;
begin
  PageControl1.ActivePage := TabSheet2;
  BlokParToDisplay;
  Button2_1.Enabled := (BlokPar[$2D] and 16) > 0;
  Button2_2.Enabled := (BlokPar[$2D] and 4) > 0;
  Button2_3.Enabled := (BlokPar[$2D] and 8) > 0;
  Main1.MenuCommEncr.Caption := 'Запись в режиме SDP';
  Main1.MenuCommLock.Caption := 'Защита загрузочного сектора';
  RadioGroup2.Enabled := Button2_3.Enabled;
  RadioGroup2.ItemIndex := BlokPar[$4B] - 1;
  CheckBox2_3.Enabled := Button2_3.Enabled;
  CheckBox2_3.Checked := (BlokPar[$2F] and 64) > 0;
  Main1.MenuCommClick(Self);
end;

procedure TForm1.UpdateTabShet3;
begin
  PageControl1.ActivePage := TabSheet3;
  BlokParToDisplay;
  Button3_1.Enabled := (BlokPar[$2D] and 16) > 0;
  Button3_2.Enabled := (BlokPar[$2D] and 4) > 0;
  Button3_3.Enabled := (BlokPar[$2D] and 8) > 0;
  Main1.MenuCommEncr.Caption := 'Запись шифровальной таблицы';
  Main1.MenuCommLock.Caption := 'Установка битов защиты';
  EncrpAdres := BlokPar[$60] + BlokPar[$61]*256 + BlokPar[$62]*65536;
  SizeEEBufer := 1 + BlokPar[$66] + BlokPar[$67]*256 + BlokPar[$68]*65536;
  meEncr3.Enabled := Button3_2.Enabled;
  meEncr3.Text := IntToHex(EncrpAdres, 6);
  Label4.Enabled := Button3_2.Enabled;
  Button3_21.Enabled := Button3_2.Enabled;
  Button3_22.Enabled := Button3_2.Enabled;
  CheckBox3_2.Enabled := Button3_2.Enabled;
  CheckBox3_2.Checked := (BlokPar[$2F] and 32) > 0;
  RadioGroup3.Enabled := Button3_3.Enabled;
  RadioGroup3.ItemIndex := BlokPar[$4B] - 1;
  CheckBox3_3.Enabled := Button3_3.Enabled;
  CheckBox3_3.Checked := (BlokPar[$2F] and 64) > 0;
  Main1.MenuCommClick(Self);
end;

procedure TForm1.UpdateTabShet4;
begin
  PageControl1.ActivePage := TabSheet4;
  BlokParToDisplay;
  Button4_1.Enabled := (BlokPar[$2D] and 16) > 0;
  Button4_2.Enabled := (BlokPar[$2D] and 4) > 0;
  Main1.MenuCommEncr.Caption := 'Запись EEPROM данных';
  Main1.MenuCommLock.Caption := 'Запись конфигурационного слова';
  EncrpAdres := BlokPar[$60] + BlokPar[$61]*256 + BlokPar[$62]*65536;
  SizeEEBufer := (1 + BlokPar[$66] + BlokPar[$67]*256 + BlokPar[$68]*65536) * 2;
  meEeprom4.Enabled := Button4_2.Enabled;
  meEeprom4.Text := IntToHex(EncrpAdres, 6);
  Label6.Enabled := Button4_2.Enabled;
  Button4_21.Enabled := Button4_2.Enabled;
  Button4_22.Enabled := Button4_2.Enabled;
  CheckBox4_2.Enabled := Button4_2.Enabled;
  CheckBox4_2.Checked := (BlokPar[$2F] and 32) > 0;
  WordToConfigPic;
  Main1.MenuCommClick(Self);
end;

procedure TForm1.UpdateTabShet5;
begin
  PageControl1.ActivePage := TabSheet5;
  BlokParToDisplay;
  Button5_3.Enabled := (BlokPar[$2D] and 8) > 0;
  RadioGroup5_3.Enabled := Button5_3.Enabled;
  RadioGroup5_3.ItemIndex := BlokPar[$4B] -1;
  CheckBox5_3.Enabled := Button5_3.Enabled;
  CheckBox5_3.Checked := (BlokPar[$2F] and 64) > 0;
  Main1.MenuCommClick(Self);
end;

procedure TForm1.UpdateTabShet6;
begin
  PageControl1.ActivePage := TabSheet6;
  BlokParToDisplay;
  Main1.MenuCommClick(Self);
end;



procedure TForm1.ComboBox1DropDown(Sender: TObject);
begin
  if ComboBox1.Items.Count > ChipBlok[1] then ComboBox1.Items.Delete(ChipBlok[1]);
  if SelectTypeChip(1, $0FF) = 0 then UpdateAutoTabShet1;
end;

procedure TForm1.UpdateAutoTabShet1;
begin
  if ComboBox1.Items.Count > ChipBlok[1] then ComboBox1.Items.Delete(ChipBlok[1]);
  ComboBox1.Items.Append(ChipName);
  ComboBox1.ItemIndex := ComboBox1.Items.Count - 1;
end;

procedure TForm1.ComboBox2DropDown(Sender: TObject);
begin
  if ComboBox2.Items.Count > ChipBlok[2] then ComboBox2.Items.Delete(ChipBlok[2]);
  if SelectTypeChip(2, $0FF) = 0 then UpdateAutoTabShet2;
end;

procedure TForm1.UpdateAutoTabShet2;
begin
  if ComboBox2.Items.Count > ChipBlok[2] then ComboBox2.Items.Delete(ChipBlok[2]);
  ComboBox2.Items.Append(ChipName);
  ComboBox2.ItemIndex := ComboBox2.Items.Count - 1;
end;

procedure TForm1.ComboBox3DropDown(Sender: TObject);
begin
  if ComboBox3.Items.Count > ChipBlok[3] then ComboBox3.Items.Delete(ChipBlok[3]);
  if SelectTypeChip(4, $0FF) = 0 then UpdateAutoTabShet3;
end;

procedure TForm1.UpdateAutoTabShet3;
begin
  if ComboBox3.Items.Count > ChipBlok[3] then ComboBox3.Items.Delete(ChipBlok[3]);
  ComboBox3.Items.Append(ChipName);
  ComboBox3.ItemIndex := ComboBox3.Items.Count - 1;
end;

procedure TForm1.UpdateAutoTabShet4;
var
  i: integer;
begin
  for i := 0 to (ChipBlok[4] - 1) do
    if ChipName = ComboBox4.Items[i] then ComboBox4.ItemIndex := i;
end;

procedure TForm1.UpdateAutoTabShet5;
var
  i: integer;
begin
  for i := 0 to (ChipBlok[5] - 1) do
    if ChipName = ComboBox5.Items[i] then ComboBox5.ItemIndex := i;
end;

procedure TForm1.UpdateAutoTabShet6;
var
  i: integer;
begin
  for i := 0 to (ChipBlok[6] - 1) do
    if ChipName = ComboBox6.Items[i] then ComboBox6.ItemIndex := i;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  if ComboBox1.ItemIndex <> -1 then
  begin
    if ComboBox1.Items.Count > ChipBlok[1] then ComboBox1.Items.Delete(ChipBlok[1]);
    if SelectTypeChip(1, $0FF) = 0 then UpdateAutoTabShet1
    else if SelectTypeChip(1,ComboBox1.ItemIndex)<>0 then ComboBox1.ItemIndex := -1;
  end;
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
begin
  if ComboBox2.ItemIndex <> -1 then
  begin
    if ComboBox2.Items.Count > ChipBlok[2] then ComboBox2.Items.Delete(ChipBlok[2]);
    if SelectTypeChip(2, $0FF)=0 then UpdateAutoTabShet2
    else if SelectTypeChip(2,ChipBlok[1]+ComboBox2.ItemIndex)<>0 then ComboBox2.ItemIndex := -1;
  end;
end;

procedure TForm1.ComboBox3Change(Sender: TObject);
begin
  if ComboBox3.ItemIndex <> -1 then
  begin
    if ComboBox3.Items.Count > ChipBlok[3] then ComboBox3.Items.Delete(ChipBlok[3]);
    if SelectTypeChip(4, $0FF)=0 then UpdateAutoTabShet3
    else if SelectTypeChip(4,ChipBlok[1]+ChipBlok[2]+ComboBox3.ItemIndex)<>0 then ComboBox3.ItemIndex := -1;
  end;
end;

procedure TForm1.ComboBox4Change(Sender: TObject);
begin
  if ComboBox4.ItemIndex <> -1 then
    if SelectTypeChip(8,ChipBlok[1]+ChipBlok[2]+ChipBlok[3]+ComboBox4.ItemIndex)<>0 then ComboBox4.ItemIndex := -1;
end;

procedure TForm1.ComboBox5Change(Sender: TObject);
begin
  if ComboBox5.ItemIndex <> -1 then
    if SelectTypeChip(16,ChipBlok[1]+ChipBlok[2]+ChipBlok[3]+ChipBlok[4]+ComboBox5.ItemIndex)<>0 then ComboBox5.ItemIndex := -1;
end;

procedure TForm1.ComboBox6Change(Sender: TObject);
begin
  if ComboBox6.ItemIndex <> -1 then
    if SelectTypeChip(32,ChipBlok[1]+ChipBlok[2]+ChipBlok[3]+ChipBlok[4]+ChipBlok[5]+ComboBox6.ItemIndex)<>0 then ComboBox6.ItemIndex := -1;
end;


procedure TForm1.PageControl1Change(Sender: TObject);
begin
  CheckBox1.Visible := PageControl1.ActivePage.PageIndex in [0,1,2];
  case PageControl1.ActivePage.PageIndex of
    0: begin ComboBox1Change(Sender); ComboBox1.SetFocus; end;
    1: begin ComboBox2Change(Sender); ComboBox2.SetFocus; end;
    2: begin ComboBox3Change(Sender); ComboBox3.SetFocus; end;
    3: begin
         if ProgrammerVersion = $1E then begin ComboBox4Change(Sender); ComboBox4.SetFocus; end
         else MessageBox(0, 'Для работы с PIC контроллерами необходима версия программатора не ниже V3.45',
              'Инициализация программатора',mb_IconStop or mb_TaskModal);
         TabSheet4.Enabled := ProgrammerVersion = $1E;
         Panel2.SendToBack;
         btnPIC.Caption := '>';
       end;
    4: begin ComboBox5Change(Sender); ComboBox5.SetFocus; end;
    5: begin ComboBox6Change(Sender); ComboBox6.SetFocus; end;
  end;
end;

procedure TForm1.BlokParToDisplay;
begin
  CheckBox1.Visible := PageControl1.ActivePage.PageIndex in [0,1,2];
  CheckBox1.Checked := CheckBox1.Visible and((BlokPar[$2F] and $08) > 0);
  ComBoxVpp.ItemIndex := BlokPar[$4C] - 10;       //Напряжение записи
  ComBoxVccwr.ItemIndex := BlokPar[$54] - 10;     //Напряжения питания
  ComBoxVccnom.ItemIndex := BlokPar[$53] - 10;
  ComBoxVccmin.ItemIndex := BlokPar[$51] - 10;
  ComBoxVccmax.ItemIndex := BlokPar[$52] - 10;
  ComBoxNumb.ItemIndex := BlokPar[$6C] - 1;       //Количество импульсов записи
  ComBoxNumb.Visible := not ((BlokPar[$2D] and 2) > 0);
  LbNumb.Visible := ComBoxNumb.Visible;
  if BlokPar[$4D] >= 128 then
    ComBoxPuls.ItemIndex := BlokPar[$4D] - 120    //Длительность импульса записи
  else ComBoxPuls.ItemIndex := BlokPar[$4D] - 1;
  ComBoxPuls.Visible := not ((BlokPar[$2D] and 2) > 0);
  LbPuls.Visible := ComBoxPuls.Visible;
  ComBoxPage.Visible := PageControl1.ActivePage.PageIndex = 4;
  LbPage.Visible := ComBoxPage.Visible;
  if PageControl1.ActivePage.PageIndex = 4 then
  case BlokPar[$4D] of
    0:   ComBoxPage.ItemIndex := 8;
    1:   ComBoxPage.ItemIndex := 0;
    2:   ComBoxPage.ItemIndex := 1;
    4:   ComBoxPage.ItemIndex := 2;
    8:   ComBoxPage.ItemIndex := 3;
    16:  ComBoxPage.ItemIndex := 4;
    32:  ComBoxPage.ItemIndex := 5;
    64:  ComBoxPage.ItemIndex := 6;
    128: ComBoxPage.ItemIndex := 7;
  else   ComBoxPage.ItemIndex := -1;
  end;
  MaxAdres := BlokPar[$69] + BlokPar[$6A]*256 + BlokPar[$6B]*65536;
  BuferAdres := BlokPar[$55] + BlokPar[$56]*256 + BlokPar[$57]*65536;
  BeginAdres := BlokPar[$58] + BlokPar[$59]*256 + BlokPar[$5A]*65536;
  FinalAdres := BlokPar[$5B] + BlokPar[$5C]*256 + BlokPar[$5D]*65536;
  meBufer1.Text := IntToHex(BuferAdres, 6);       //Адреса
  meBegin1.Text := IntToHex(BeginAdres, 6);
  meFinal1.Text := IntToHex(FinalAdres, 6);
  Main1.MenuOptAutoWrite.Checked := (BlokPar[$2F] and $01) > 0;    //Режим 'AUTO write'
  Main1.MenuOptClearMemory.Checked := (BlokPar[$2F] and $04) > 0;  //ClearMemory
  Main1.MenuOptSQTP.Checked := (BlokPar[$2F] and $80) > 0;         //Счетчик 'SQTP'
end;

function TForm1.DisplayToBlokPar: boolean;
begin
  if CheckBox1.Checked then BlokPar[$2F] := BlokPar[$2F] or $08
    else BlokPar[$2F] := BlokPar[$2F] and $F7;
  if Main1.MenuOptAutoWrite.Checked then BlokPar[$2F] := BlokPar[$2F] or $01
    else BlokPar[$2F] := BlokPar[$2F] and $FE;
  if Main1.MenuOptClearMemory.Checked then BlokPar[$2F] := BlokPar[$2F] or $04
    else BlokPar[$2F] := BlokPar[$2F] and $FB;
  if Main1.MenuOptSQTP.Checked then BlokPar[$2F] := BlokPar[$2F] or $80
    else BlokPar[$2F] := BlokPar[$2F] and $7F;

  Result := (ComBoxVccmin.ItemIndex<>-1) and (ComBoxVccmax.ItemIndex<>-1)
    and (ComBoxVccnom.ItemIndex<>-1) and (ComBoxVccwr.ItemIndex<>-1)
    and (ComBoxVpp.ItemIndex<>-1);
  if Result then
  begin
    BlokPar[$4C] := ComBoxVpp.ItemIndex + 10;
    BlokPar[$51] := ComBoxVccmin.ItemIndex + 10;
    BlokPar[$52] := ComBoxVccmax.ItemIndex + 10;
    BlokPar[$53] := ComBoxVccnom.ItemIndex + 10;
    BlokPar[$54] := ComBoxVccwr.ItemIndex + 10;
    if (BlokPar[$2D] and 2) = 0 then
    begin
      Result := Result and (ComBoxPuls.ItemIndex<>-1)and(ComBoxNumb.ItemIndex<>-1);
      BlokPar[$6C] := ComBoxNumb.ItemIndex + 1;
      if ComBoxPuls.ItemIndex >= 9 then BlokPar[$4D] := ComBoxPuls.ItemIndex + 120
        else BlokPar[$4D] := ComBoxPuls.ItemIndex + 1;
    end;
    if PageControl1.ActivePage.PageIndex = 4 then
      case ComBoxPage.ItemIndex of
        0: BlokPar[$4D] := 1;
        1: BlokPar[$4D] := 2;
        2: BlokPar[$4D] := 4;
        3: BlokPar[$4D] := 8;
        4: BlokPar[$4D] := 16;
        5: BlokPar[$4D] := 32;
        6: BlokPar[$4D] := 64;
        7: BlokPar[$4D] := 128;
        8: BlokPar[$4D] := 0;
      else Result := False;
      end;
  end;
  BlokPar[$55] := Lo(BuferAdres);          //Адреса микросхемы
  BlokPar[$56] := BuferAdres shr 8;
  BlokPar[$57] := BuferAdres shr 16;
  BlokPar[$58] := Lo(BeginAdres);
  BlokPar[$59] := BeginAdres shr 8;
  BlokPar[$5A] := BeginAdres shr 16;
  BlokPar[$5B] := Lo(FinalAdres);
  BlokPar[$5C] := FinalAdres shr 8;
  BlokPar[$5D] := FinalAdres shr 16;
  BlokPar[$60] := Lo(EncrpAdres);          //Encrypton -EEPROM
  BlokPar[$61] := EncrpAdres shr 8;
  BlokPar[$62] := EncrpAdres shr 16;
  if (BlokPar[$2D] and 8) > 0 then
  begin
    case PageControl1.ActivePage.PageIndex of
      1: Result := Result and (RadioGroup2.ItemIndex <> -1);
      2: Result := Result and (RadioGroup3.ItemIndex <> -1);
    end;
    case PageControl1.ActivePage.PageIndex of
      1: BlokPar[$4B] := RadioGroup2.ItemIndex + 1; //Количество бит защиты
      2: BlokPar[$4B] := RadioGroup3.ItemIndex + 1; //Количество бит защиты
      3: if Result then Result := ConfigPicToWord;
    end;
  end;
  if Result then Result := WriteBlokPar($2D, $7F)
  else MessageBox(0,'Некоторые параметры программируемой микросхемы '+#13+
    'не определены или имеют недопустимые значения.','Загрузка блока параметров',mb_IconStop or mb_TaskModal);
end;


procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  Main1.MenuCommBlankClick(Sender);
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  Main1.MenuCommSumClick(Sender);
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
  Main1.MenuCommReadClick(Sender);
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
  Main1.MenuCommProgClick(Sender);
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
begin
  Main1.MenuCommVerifyClick(Sender);
end;

procedure TForm1.Button1_1Click(Sender: TObject);
begin
  Main1.MenuCommEraseClick(Sender);
end;

procedure TForm1.Button2_2Click(Sender: TObject);
begin
  Main1.MenuCommEncrClick(Sender);
end;

procedure TForm1.Button2_3Click(Sender: TObject);
begin
  Main1.MenuCommLockClick(Sender);
end;


procedure TForm1.Button3_21Click(Sender: TObject);
var
  FName: File;
  NumRd: Integer;
begin
  Main1.OpenDialog1.Title := 'Загрузка шифровальной таблицы в программатор';
  Main1.OpenDialog1.FileName := '';
  if Main1.OpenDialog1.Execute then
  begin
    EncrFileName := Main1.OpenDialog1.FileName;
    AssignFile(FName, EncrFileName);
    Reset (FName, 1);
    BlockRead(FName, EEBuf, SizeEEBufer, NumRd);
    CloseFile(FName);
    if WriteBlokRam(EncrpAdres, SizeEEBufer, EEBuf) then
      ShowMessage('Загрузка файла шифровальной таблицы завершена.')
    else MessageBox(0,'Ошибка контрольной суммы.','Загрузка файла',mb_IconStop or mb_TaskModal);
  end;
end;

procedure TForm1.Button3_22Click(Sender: TObject);
begin
  if ReadBlokRam(EncrpAdres, SizeEEBufer, EEBuf) then
    with THexEdit.Create(Self) do
    begin
      Caption := 'Шифровальная таблица';
      SizeWorkBuf := SizeEEBufer;
      ReallocMem(pWorkBuf, SizeWorkBuf);
      MoveMemory(pWorkBuf, @EEBuf, SizeWorkBuf);
      EditPasteItemClick(Sender);
      SizeWorkBuf := 0;
      ReallocMem(pWorkBuf, SizeWorkBuf);
    end;
end;

procedure TForm1.Button4_21Click(Sender: TObject);
var
  FName: File;
  NumRd: Integer;
begin
  Main1.OpenDialog1.Title := 'Загрузка EEPROM данных в программатор';
  Main1.OpenDialog1.FileName := '';
  if Main1.OpenDialog1.Execute then
  begin
    EncrFileName := Main1.OpenDialog1.FileName;
    AssignFile(FName, EncrFileName);
    Reset (FName, 1);
    BlockRead(FName, EEBuf, SizeEEBufer, NumRd);
    CloseFile(FName);
    if WriteBlokRam(EncrpAdres, SizeEEBufer, EEBuf) then
      ShowMessage('Загрузка файла EEPROM данных завершена.')
    else MessageBox(0,'Ошибка контрольной суммы.','Загрузка файла',mb_IconStop or mb_TaskModal);
  end;
end;

procedure TForm1.Button4_22Click(Sender: TObject);
begin
  if ReadBlokRam(EncrpAdres, SizeEEBufer, EEBuf) then
    with THexEdit.Create(Self) do
    begin
      Caption := 'EEPROM память данных';
      SizeWorkBuf := SizeEEBufer;
      ReallocMem(pWorkBuf, SizeWorkBuf);
      MoveMemory(pWorkBuf, @EEBuf, SizeWorkBuf);
      EditPasteItemClick(Sender);
      SizeWorkBuf := 0;
      ReallocMem(pWorkBuf, SizeWorkBuf);
    end;
end;



{function TForm1.WordToConfigPic: boolean;
var
  PICNumber: byte;
begin
  PICNumber := BlokPar[$49] and $0F;
  if PICNumber = $0D then Result := ReadBlokRam($1FFE, $2, CfgWord)
  else Result := ReadBlokRam($400E, $2, CfgWord);
  GroupBox4_3.Enabled := Result;
  GroupBox4_4.Enabled := Result;
  btnPIC.Caption := '>';
  btnPIC.Enabled := Result and (PICNumber in [$06, $07]);
  Panel2.SendToBack;
  if not Result then Exit;
  CfgWordPic := CfgWord[2]*256 + CfgWord[1];
//-------------------------------------------------------------------
  if ComboBox4_1.Items.Count > 3 then
  begin
    ComboBox4_1.Items.Delete(6);
    ComboBox4_1.Items.Delete(5);
    ComboBox4_1.Items.Delete(4);
  end;
  if ComboBox4_4.Items.Count > 1 then
  begin
    ComboBox4_4.Items.Delete(3);
    ComboBox4_4.Items.Delete(2);
  end;
  case PICNumber of
    $0D: begin
           ComboBox4_1.Items[2] := 'INTRC';      //PIC12C5xx
           ComboBox4_1.Items[3] := 'EXTRC';
           ComboBox4_1.ItemIndex := CfgWordPic and $0003;
           if (CfgWordPic and $0004) = 0 then ComboBox4_2.ItemIndex := 0
           else ComboBox4_2.ItemIndex := 1;
         end;
    $0E: begin
           ComboBox4_1.Items[2] := 'HS';         //PIC12C67x
           ComboBox4_1.Items[3] := 'IntRC_Gp4';
           ComboBox4_1.Items.Append('IntRC_Clkout');
           ComboBox4_1.Items.Append('ExtRC_Gp4');
           ComboBox4_1.Items.Append('ExtRC_Clkout');
           case CfgWordPic and $0007 of
             0: ComboBox4_1.ItemIndex := 0;
             1: ComboBox4_1.ItemIndex := 1;
             2: ComboBox4_1.ItemIndex := 2;
             4: ComboBox4_1.ItemIndex := 3;
             5: ComboBox4_1.ItemIndex := 4;
             6: ComboBox4_1.ItemIndex := 5;
             7: ComboBox4_1.ItemIndex := 6;
           else ComboBox4_1.ItemIndex := -1;
            MessageBox(0,'Ошибка в конфигурационном слове.','Конфигурация PIC',mb_IconInformation or mb_TaskModal);
           end;
           if (CfgWordPic and $0008) = 0 then ComboBox4_2.ItemIndex := 0
           else ComboBox4_2.ItemIndex := 1;
         end;
  else   ComboBox4_1.Items[2] := 'HS';
         ComboBox4_1.Items[3] := 'RC';
         ComboBox4_1.ItemIndex := CfgWordPic and $0003;
         if (CfgWordPic and $0004) = 0 then ComboBox4_2.ItemIndex := 0
         else ComboBox4_2.ItemIndex := 1;
  end;
//-------------------------------------------------------------------
  case PICNumber of                              //PWRTE / MCLRE
  $00, $04, $08:
    begin  //PIC16C61,71,62,73,64,65,74,C84
      ComboBox4_3.Items[0] := 'Disabled';
      ComboBox4_3.Items[1] := 'Enabled';
      ComboBox4_3.Hint := 'Таймер выдержки при включении питания';
      Label4_3.Caption := 'PWRTE';
      if (CfgWordPic and $0008) = 0 then ComboBox4_3.ItemIndex := 0
      else ComboBox4_3.ItemIndex := 1;
    end;
  $01, $02, $03, $05, $09, $0A, $0B, $0E, $06, $07:
    begin  //PIC16C55x,62x,62A,63,64A,642,65A,662,71x,715,73A,74A,F83,84,12C67x,16F87x
      ComboBox4_3.Items[0] := 'Enabled';
      ComboBox4_3.Items[1] := 'Disabled';
      ComboBox4_3.Hint := 'Таймер выдержки при включении питания';
      Label4_3.Caption := 'PWRTE';
      ComboBox4_3.ItemIndex := 1;
      if (PICNumber=$0E)and((CfgWordPic and $0010)=0) then ComboBox4_3.ItemIndex := 0;
      if (PICNumber<>$0E)and((CfgWordPic and $0008)=0) then ComboBox4_3.ItemIndex := 0;
    end;
  $0D:
    begin  //PIC12C5xx
      ComboBox4_3.Items[0] := 'Internal';
      ComboBox4_3.Items[1] := 'External';
      ComboBox4_3.Hint := 'Выбор внутреннего или внешнего сигнала RESET';
      Label4_3.Caption := 'MCLRE';
      if (CfgWordPic and $0010) = 0 then ComboBox4_3.ItemIndex := 0
      else ComboBox4_3.ItemIndex := 1;
    end;
  end;
//-------------------------------------------------------------------
  case PICNumber of                              //BODEN
  $02, $03, $05, $0A, $0B, $06, $07:
    begin
      ComboBox4_5.Items[0] := 'Disabled';
      ComboBox4_5.Items[1] := 'Enabled';
      ComboBox4_5.Hint := 'Включение функции Brown-out Reset';
      Label4_5.Caption := 'BODEN';
      if (CfgWordPic and $0040) = 0 then ComboBox4_5.ItemIndex := 0
      else ComboBox4_5.ItemIndex := 1;
    end;
  $0E:
    begin  //PIC12C67x
      ComboBox4_5.Items[0] := 'Internal';
      ComboBox4_5.Items[1] := 'External';
      ComboBox4_5.Hint := 'Выбор внутреннего или внешнего сигнала RESET';
      Label4_5.Caption := 'MCLRE';
      if (CfgWordPic and $0080) = 0 then ComboBox4_5.ItemIndex := 0
      else ComboBox4_5.ItemIndex := 1;
    end;
  end;
  ComboBox4_5.Visible := PICNumber in [$02, $03, $05, $06, $07, $0A, $0B, $0E];
  Label4_5.Visible := ComboBox4_5.Visible;
//-------------------------------------------------------------------
  case PICNumber of                              //CODE PROTECT
  $00, $03, $08, $09, $0D:
    begin  //PIC16C61,71,710,711,C84,F83,84, PIC12C5xx
      ComboBox4_4.Items[0] := 'On';
      ComboBox4_4.Items[1] := 'Off';
    end;
  $01, $02, $04, $05, $0A, $0B, $0E:
    begin  //PIC16C55x,62x,62,73,64,65,74,62A,63,64A,65A,73A,74A...715,642,662,PIC12C67x
      ComboBox4_4.Items[0] := 'All protect';
      ComboBox4_4.Items[1] := 'Upper 3/4';
      ComboBox4_4.Items.Append('Upper 1/2');
      ComboBox4_4.Items.Append('Off');
    end;
  $06, $07:
    begin  //PIC16F87x
      ComboBox4_4.Items[0] := 'All protect';
      ComboBox4_4.Items[1] := 'Upper 1/2';
      ComboBox4_4.Items.Append('Upper 256');
      ComboBox4_4.Items.Append('Off');
    end;
  end;

  case PICNumber of
  $00, $08:                                      //PIC16C61,71,C84
    if (CfgWordPic and $0010) = 0 then ComboBox4_4.ItemIndex := 0
    else ComboBox4_4.ItemIndex := 1;
  $0D:                                           //PIC12C5xx
    if (CfgWordPic and $0008) = 0 then ComboBox4_4.ItemIndex := 0
    else ComboBox4_4.ItemIndex := 1;
  $01, $02, $05, $0A, $0B:                       //PIC16C55x,62x, PIC16C...
    case (CfgWordPic and $3F30) of
      0     : ComboBox4_4.ItemIndex := 0;
      $1510 : ComboBox4_4.ItemIndex := 1;
      $2A20 : ComboBox4_4.ItemIndex := 2;
      $3F30 : ComboBox4_4.ItemIndex := 3;
    else ComboBox4_4.ItemIndex := -1;
      MessageBox(0,'Ошибка в конфигурационном слове.','Конфигурация PIC',mb_IconInformation or mb_TaskModal);
    end;
  $03:                                           //PIC16C710,711
    case (CfgWordPic and $3FB0) of
      0    : ComboBox4_4.ItemIndex := 0;
      $3FB0: ComboBox4_4.ItemIndex := 1;
    else ComboBox4_4.ItemIndex := -1;
      MessageBox(0,'Ошибка в конфигурационном слове.','Конфигурация PIC',mb_IconInformation or mb_TaskModal);
    end;
  $04:                                           //PIC16C62,73,64,65,74
    case (CfgWordPic and $0030) of
      0   : ComboBox4_4.ItemIndex := 0;
      $10 : ComboBox4_4.ItemIndex := 1;
      $20 : ComboBox4_4.ItemIndex := 2;
      $30 : ComboBox4_4.ItemIndex := 3;
    end;
  $06, $07:                                      //PIC16F87x
    case (CfgWordPic and $3030) of
      0     : ComboBox4_4.ItemIndex := 0;
      $1010 : ComboBox4_4.ItemIndex := 1;
      $2020 : ComboBox4_4.ItemIndex := 2;
      $3030 : ComboBox4_4.ItemIndex := 3;
    else ComboBox4_4.ItemIndex := -1;
      MessageBox(0,'Ошибка в конфигурационном слове.','Конфигурация PIC',mb_IconInformation or mb_TaskModal);
    end;
  $09:                                           //PIC16F83,84
    case (CfgWordPic and $3FF0) of
      0    : ComboBox4_4.ItemIndex := 0;
      $3FF0: ComboBox4_4.ItemIndex := 1;
    else ComboBox4_4.ItemIndex := -1;
      MessageBox(0,'Ошибка в конфигурационном слове.','Конфигурация PIC',mb_IconInformation or mb_TaskModal);
    end;
  $0E:                                           //PIC12C67x
    case (CfgWordPic and $3F60) of
      0     : ComboBox4_4.ItemIndex := 0;
      $1520 : ComboBox4_4.ItemIndex := 1;
      $2A40 : ComboBox4_4.ItemIndex := 2;
      $3F60 : ComboBox4_4.ItemIndex := 3;
    else ComboBox4_4.ItemIndex := -1;
      MessageBox(0,'Ошибка в конфигурационном слове.','Конфигурация PIC',mb_IconInformation or mb_TaskModal);
    end;
  end;
//-------------------------------------------------------------------
  if PICNumber in [$06, $07] then                //PIC16F87x
  begin
    if (CfgWordPic and $0080) = 0 then ComboBox4_6.ItemIndex := 0
    else ComboBox4_6.ItemIndex := 1;
    if (CfgWordPic and $0100) = 0 then ComboBox4_7.ItemIndex := 0
    else ComboBox4_7.ItemIndex := 1;
    if (CfgWordPic and $0200) = 0 then ComboBox4_8.ItemIndex := 0
    else ComboBox4_8.ItemIndex := 1;
    if (CfgWordPic and $0800) = 0 then ComboBox4_9.ItemIndex := 0
    else ComboBox4_9.ItemIndex := 1;
  end;
end;
}

function TForm1.WordToConfigPic: boolean;
var
  PICNumber: byte;
begin
  PICNumber := BlokPar[$49] and $3F;
  if PICNumber in [$2D, $2C] then Result := ReadBlokRam($1FFE, $2, CfgWord)
  else Result := ReadBlokRam($400E, $2, CfgWord);
  GroupBox4_3.Enabled := Result;
  GroupBox4_4.Enabled := Result;
  btnPIC.Caption := '>';
  btnPIC.Enabled := Result and (PICNumber in [$26,$27,$2A,$2B,$33,$35,$36]);
  Panel2.SendToBack;
  if not Result then Exit;
  CfgWordPic := CfgWord[2]*256 + CfgWord[1];
//-------------------------------------------------------------------
  if ComboBox4_1.Items.Count > 3 then
  begin
    ComboBox4_1.Items.Delete(7);
    ComboBox4_1.Items.Delete(6);
    ComboBox4_1.Items.Delete(5);
    ComboBox4_1.Items.Delete(4);
  end;
  if ComboBox4_4.Items.Count > 1 then
  begin
    ComboBox4_4.Items.Delete(3);
    ComboBox4_4.Items.Delete(2);
  end;
  case PICNumber of
    $2D: begin
           ComboBox4_1.Items[2] := 'INTRC';      //PIC12C5xx
           ComboBox4_1.Items[3] := 'EXTRC';
           ComboBox4_1.ItemIndex := CfgWordPic and $0003;
           if (CfgWordPic and $0004) = 0 then ComboBox4_2.ItemIndex := 0
           else ComboBox4_2.ItemIndex := 1;
         end;
    $2E, $2C: begin
           ComboBox4_1.Items[2] := 'HS';         //PIC12C67x, PIC16C505
           ComboBox4_1.Items[3] := 'IntRC_Gp4';
           ComboBox4_1.Items.Append('IntRC_Clkout');
           ComboBox4_1.Items.Append('ExtRC_Gp4');
           ComboBox4_1.Items.Append('ExtRC_Clkout');
           case CfgWordPic and $0007 of
             0: ComboBox4_1.ItemIndex := 0;
             1: ComboBox4_1.ItemIndex := 1;
             2: ComboBox4_1.ItemIndex := 2;
             4: ComboBox4_1.ItemIndex := 3;
             5: ComboBox4_1.ItemIndex := 4;
             6: ComboBox4_1.ItemIndex := 5;
             7: ComboBox4_1.ItemIndex := 6;
           else ComboBox4_1.ItemIndex := -1;
            MessageBox(0,'Ошибка в конфигурационном слове.','Конфигурация PIC',mb_IconInformation or mb_TaskModal);
           end;
           if (CfgWordPic and $0008) = 0 then ComboBox4_2.ItemIndex := 0
           else ComboBox4_2.ItemIndex := 1;
         end;
    $34: begin   //pic16c745,765
           ComboBox4_1.Items[0] := 'HS';
           ComboBox4_1.Items[1] := 'EC';
           ComboBox4_1.Items[2] := 'H4';
           ComboBox4_1.Items[3] := 'E4';
           ComboBox4_1.ItemIndex := CfgWordPic and $0003;
           if (CfgWordPic and $0004) = 0 then ComboBox4_2.ItemIndex := 0
           else ComboBox4_2.ItemIndex := 1;
         end;
    $36: begin
           ComboBox4_1.Items[2] := 'HS';         //PIC16F62x
           ComboBox4_1.Items[3] := 'ExtClk';
           ComboBox4_1.Items.Append('IntRC');
           ComboBox4_1.Items.Append('IntRC_Clkout');
           ComboBox4_1.Items.Append('ER');
           ComboBox4_1.Items.Append('ER_Clkout');
           case CfgWordPic and $0013 of
             $00: ComboBox4_1.ItemIndex := 0;
             $01: ComboBox4_1.ItemIndex := 1;
             $02: ComboBox4_1.ItemIndex := 2;
             $03: ComboBox4_1.ItemIndex := 3;
             $10: ComboBox4_1.ItemIndex := 4;
             $11: ComboBox4_1.ItemIndex := 5;
             $12: ComboBox4_1.ItemIndex := 6;
             $13: ComboBox4_1.ItemIndex := 7;
           end;
           if (CfgWordPic and $0004) = 0 then ComboBox4_2.ItemIndex := 0
           else ComboBox4_2.ItemIndex := 1;
         end;
  else   ComboBox4_1.Items[2] := 'HS';
         ComboBox4_1.Items[3] := 'RC';
         ComboBox4_1.ItemIndex := CfgWordPic and $0003;
         if (CfgWordPic and $0004) = 0 then ComboBox4_2.ItemIndex := 0
         else ComboBox4_2.ItemIndex := 1;
  end;
//-------------------------------------------------------------------
  case PICNumber of                              //PWRTE / MCLRE
  $20, $24:
    begin  //PIC16C61,71,62,73,64,65,74,C84
      ComboBox4_3.Items[0] := 'Disabled';
      ComboBox4_3.Items[1] := 'Enabled';
      ComboBox4_3.Hint := 'Таймер выдержки при включении питания';
      Label4_3.Caption := 'PWRTE';
      if (CfgWordPic and $0008) = 0 then ComboBox4_3.ItemIndex := 0
      else ComboBox4_3.ItemIndex := 1;
    end;
  $21, $22, $23, $25, $29, $2A, $2B, $2E, $26, $27, $28, $33, $34, $35, $36:
    begin  //PIC16C55x,62x,62A,63,64A,642,65A,662,71x,715,73A,74A,F83,84,12C67x,16F87x,92x
      ComboBox4_3.Items[0] := 'Enabled';
      ComboBox4_3.Items[1] := 'Disabled';
      ComboBox4_3.Hint := 'Таймер выдержки при включении питания';
      Label4_3.Caption := 'PWRTE';
      ComboBox4_3.ItemIndex := 1;
      if (PICNumber=$0E)and((CfgWordPic and $0010)=0) then ComboBox4_3.ItemIndex := 0;
      if (PICNumber<>$0E)and((CfgWordPic and $0008)=0) then ComboBox4_3.ItemIndex := 0;
    end;
  $2D:
    begin  //PIC12C5xx
      ComboBox4_3.Items[0] := 'Internal';
      ComboBox4_3.Items[1] := 'External';
      ComboBox4_3.Hint := 'Выбор внутреннего или внешнего сигнала RESET';
      Label4_3.Caption := 'MCLRE';
      if (CfgWordPic and $0010) = 0 then ComboBox4_3.ItemIndex := 0
      else ComboBox4_3.ItemIndex := 1;
    end;
  $2C:
    begin  //PIC16C505
      ComboBox4_3.Items[0] := 'Internal';
      ComboBox4_3.Items[1] := 'External';
      ComboBox4_3.Hint := 'Выбор внутреннего или внешнего сигнала RESET';
      Label4_3.Caption := 'MCLRE';
      if (CfgWordPic and $0020) = 0 then ComboBox4_3.ItemIndex := 0
      else ComboBox4_3.ItemIndex := 1;
    end;
  end;
//-------------------------------------------------------------------
  case PICNumber of                              //BODEN
  $22, $23, $25, $2A, $2B, $26, $27, $33, $35, $36:
    begin
      ComboBox4_5.Items[0] := 'Disabled';
      ComboBox4_5.Items[1] := 'Enabled';
      ComboBox4_5.Hint := 'Включение функции Brown-out Reset';
      Label4_5.Caption := 'BODEN';
      if (CfgWordPic and $0040) = 0 then ComboBox4_5.ItemIndex := 0
      else ComboBox4_5.ItemIndex := 1;
    end;
  $2E:
    begin  //PIC12C67x
      ComboBox4_5.Items[0] := 'Internal';
      ComboBox4_5.Items[1] := 'External';
      ComboBox4_5.Hint := 'Выбор внутреннего или внешнего сигнала RESET';
      Label4_5.Caption := 'MCLRE';
      if (CfgWordPic and $0080) = 0 then ComboBox4_5.ItemIndex := 0
      else ComboBox4_5.ItemIndex := 1;
    end;
  end;
  ComboBox4_5.Visible := PICNumber in [$22,$23,$25,$26,$27,$2A,$2B,$2E,$33,$35,$36];
  Label4_5.Visible := ComboBox4_5.Visible;
//-------------------------------------------------------------------
  case PICNumber of                              //CODE PROTECT
  $20, $23, $29, $2D, $2C:
    begin  //PIC16C61,71,710,711,C84,F83,84, PIC12C5xx, 505
      ComboBox4_4.Items[0] := 'On';
      ComboBox4_4.Items[1] := 'Off';
    end;
  $21, $22, $24, $25, $2A, $2B, $2E, $28, $34, $35, $36:
    begin  //PIC16C55x,62x,62,73,64,65,74,62A,63,64A,65A,73A,74A...715,642,662,PIC12C67x,92x
      ComboBox4_4.Items[0] := 'All protect';
      ComboBox4_4.Items[1] := 'Upper 3/4';
      ComboBox4_4.Items.Append('Upper 1/2');
      ComboBox4_4.Items.Append('Off');
    end;
  $33, $26, $27:
    begin  //PIC16F87x
      ComboBox4_4.Items[0] := 'All protect';
      ComboBox4_4.Items[1] := 'Upper 1/2';
      ComboBox4_4.Items.Append('Upper 256');
      ComboBox4_4.Items.Append('Off');
    end;
  end;

  case PICNumber of
  $20:                                           //PIC16C61,71,C84
    if (CfgWordPic and $0010) = 0 then ComboBox4_4.ItemIndex := 0
    else ComboBox4_4.ItemIndex := 1;
  $2D:                                           //PIC12C5xx
    if (CfgWordPic and $0008) = 0 then ComboBox4_4.ItemIndex := 0
    else ComboBox4_4.ItemIndex := 1;
  $21, $22, $25, $2A, $2B, $28, $34:             //PIC16C55x,62x, PIC16C..., 92x
    case (CfgWordPic and $3F30) of
      0     : ComboBox4_4.ItemIndex := 0;
      $1510 : ComboBox4_4.ItemIndex := 1;
      $2A20 : ComboBox4_4.ItemIndex := 2;
      $3F30 : ComboBox4_4.ItemIndex := 3;
    else ComboBox4_4.ItemIndex := -1;
      MessageBox(0,'Ошибка в конфигурационном слове.','Конфигурация PIC',mb_IconInformation or mb_TaskModal);
    end;
  $23:                                           //PIC16C710,711
    case (CfgWordPic and $3FB0) of
      0    : ComboBox4_4.ItemIndex := 0;
      $3FB0: ComboBox4_4.ItemIndex := 1;
    else ComboBox4_4.ItemIndex := -1;
      MessageBox(0,'Ошибка в конфигурационном слове.','Конфигурация PIC',mb_IconInformation or mb_TaskModal);
    end;
  $24:                                           //PIC16C62,73,64,65,74
    case (CfgWordPic and $0030) of
      0   : ComboBox4_4.ItemIndex := 0;
      $10 : ComboBox4_4.ItemIndex := 1;
      $20 : ComboBox4_4.ItemIndex := 2;
      $30 : ComboBox4_4.ItemIndex := 3;
    end;
  $26, $27, $33:                                      //PIC16F87x
    case (CfgWordPic and $3030) of
      0     : ComboBox4_4.ItemIndex := 0;
      $1010 : ComboBox4_4.ItemIndex := 1;
      $2020 : ComboBox4_4.ItemIndex := 2;
      $3030 : ComboBox4_4.ItemIndex := 3;
    else ComboBox4_4.ItemIndex := -1;
      MessageBox(0,'Ошибка в конфигурационном слове.','Конфигурация PIC',mb_IconInformation or mb_TaskModal);
    end;
  $29:                                           //PIC16F83,84
    case (CfgWordPic and $3FF0) of
      0    : ComboBox4_4.ItemIndex := 0;
      $3FF0: ComboBox4_4.ItemIndex := 1;
    else ComboBox4_4.ItemIndex := -1;
      MessageBox(0,'Ошибка в конфигурационном слове.','Конфигурация PIC',mb_IconInformation or mb_TaskModal);
    end;
  $2C:                                           //PIC16C505
    case (CfgWordPic and $0FD0) of
      0    : ComboBox4_4.ItemIndex := 0;
      $0FD0: ComboBox4_4.ItemIndex := 1;
    else ComboBox4_4.ItemIndex := -1;
      MessageBox(0,'Ошибка в конфигурационном слове.','Конфигурация PIC',mb_IconInformation or mb_TaskModal);
    end;
  $2E:                                           //PIC12C67x
    case (CfgWordPic and $3F60) of
      0     : ComboBox4_4.ItemIndex := 0;
      $1520 : ComboBox4_4.ItemIndex := 1;
      $2A40 : ComboBox4_4.ItemIndex := 2;
      $3F60 : ComboBox4_4.ItemIndex := 3;
    else ComboBox4_4.ItemIndex := -1;
      MessageBox(0,'Ошибка в конфигурационном слове.','Конфигурация PIC',mb_IconInformation or mb_TaskModal);
    end;
  $35:                                         //PIC16c77x
    case (CfgWordPic and $3330) of
      0     : ComboBox4_4.ItemIndex := 0;
      $1110 : ComboBox4_4.ItemIndex := 1;
      $2220 : ComboBox4_4.ItemIndex := 2;
      $3330 : ComboBox4_4.ItemIndex := 3;
    else ComboBox4_4.ItemIndex := -1;
      MessageBox(0,'Ошибка в конфигурационном слове.','Конфигурация PIC',mb_IconInformation or mb_TaskModal);
    end;
  $36:                                          //PIC16F62x
    case (CfgWordPic and $3C00) of
      0     : ComboBox4_4.ItemIndex := 0;
      $1400 : ComboBox4_4.ItemIndex := 1;
      $2800 : ComboBox4_4.ItemIndex := 2;
      $3C00 : ComboBox4_4.ItemIndex := 3;
    else ComboBox4_4.ItemIndex := -1;
      MessageBox(0,'Ошибка в конфигурационном слове.','Конфигурация PIC',mb_IconInformation or mb_TaskModal);
    end;
  end;
//-------------------------------------------------------------------
  if PICNumber in [$26, $27, $2A, $2B, $33, $35, $36] then
  begin
    ComboBox4_6.Visible := True;
    Label4_6.Visible := True;
    ComboBox4_7.Visible := True;
    Label4_7.Visible := True;
    ComboBox4_8.Visible := True;
    Label4_8.Visible := True;
    ComboBox4_9.Visible := True;
    Label4_9.Visible := True;
    ComboBox4_10.Visible := True;
    Label4_10.Visible := True;
  end;
//-------------------------------------------------------------------
  if PICNumber in [$26, $27, $33] then                //PIC16F87x
  begin
    if (CfgWordPic and $0080) = 0 then ComboBox4_6.ItemIndex := 0
    else ComboBox4_6.ItemIndex := 1;
    if (CfgWordPic and $0100) = 0 then ComboBox4_7.ItemIndex := 0
    else ComboBox4_7.ItemIndex := 1;
    ComboBox4_8.Items[0] := 'Disabled';
    ComboBox4_8.Items[1] := 'Enabled';
    ComboBox4_8.Hint := 'Разрешение внутренней перезаписи памяти программ';
    Label4_8.Caption := 'WRT';
    if (CfgWordPic and $0200) = 0 then ComboBox4_8.ItemIndex := 0
    else ComboBox4_8.ItemIndex := 1;
    if (CfgWordPic and $0800) = 0 then ComboBox4_9.ItemIndex := 0
    else ComboBox4_9.ItemIndex := 1;
    ComboBox4_10.Visible := False;
    Label4_10.Visible := False;
  end;
//-------------------------------------------------------------------
  if PICNumber in [$2A, $2B] then                //PIC16C715, 642, 662
  begin
    ComboBox4_6.Visible := False;
    Label4_6.Visible := False;
    ComboBox4_7.Visible := False;
    Label4_7.Visible := False;
    ComboBox4_8.Items[0] := 'Disabled';
    ComboBox4_8.Items[1] := 'Enabled';
    ComboBox4_8.Hint := 'Разрешение контроля четности (Reset on Memory Parity Error)';
    Label4_8.Caption := 'MPEEN';
    if (CfgWordPic and $0080) = 0 then ComboBox4_8.ItemIndex := 0
    else ComboBox4_8.ItemIndex := 1;
    ComboBox4_9.Visible := False;
    Label4_9.Visible := False;
    ComboBox4_10.Visible := False;
    Label4_10.Visible := False;
  end;
//-------------------------------------------------------------------
  if PICNumber = $35 then                     //PIC16C77x
  begin
    ComboBox4_6.Visible := False;
    Label4_6.Visible := False;
    ComboBox4_7.Visible := False;
    Label4_7.Visible := False;
    ComboBox4_8.Visible := False;
    Label4_8.Visible := False;
    ComboBox4_9.Visible := False;
    Label4_9.Visible := False;
    case (CfgWordPic and $0C00) of
      0     : ComboBox4_10.ItemIndex := 0;
      $0400 : ComboBox4_10.ItemIndex := 1;
      $0800 : ComboBox4_10.ItemIndex := 2;
      $0C00 : ComboBox4_10.ItemIndex := 3;
    end;
  end;
//-------------------------------------------------------------------
  if PICNumber = $36 then                     //PIC16F62x
  begin
    if (CfgWordPic and $0080) = 0 then ComboBox4_6.ItemIndex := 0
    else ComboBox4_6.ItemIndex := 1;
    if (CfgWordPic and $0100) = 0 then ComboBox4_7.ItemIndex := 0
    else ComboBox4_7.ItemIndex := 1;
    ComboBox4_8.Items[0] := 'Internal';
    ComboBox4_8.Items[1] := 'External';
    ComboBox4_8.Hint := 'Выбор внутреннего или внешнего сигнала RESET';
    Label4_8.Caption := 'MCLRE';
    if (CfgWordPic and $0020) = 0 then ComboBox4_8.ItemIndex := 0
    else ComboBox4_8.ItemIndex := 1;
    ComboBox4_9.Visible := False;
    Label4_9.Visible := False;
    ComboBox4_10.Visible := False;
    Label4_10.Visible := False;
  end;
end;






function TForm1.UpdataPIC12C_5xx: boolean;
begin
  Result := (ComboBox4_1.ItemIndex<>-1)and(ComboBox4_2.ItemIndex<>-1);
  CfgWordPic := $3FF8;
  CfgWordPic := CfgWordPic or (ComboBox4_1.ItemIndex and $0003);        //FOSC
  CfgWordPic := CfgWordPic or ((ComboBox4_2.ItemIndex shl 2)and $0004); //WDT Enabled
  case ComboBox4_3.ItemIndex of                                         //MCLRE
    0: CfgWordPic := CfgWordPic and $3FEF;
    1: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
  case ComboBox4_4.ItemIndex of                                         //CODE PROTECT
    0: CfgWordPic := CfgWordPic and $3FF7;
    1: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
  CfgWordPic := CfgWordPic and $0FFF;     //$001F;
end;

function TForm1.UpdataPIC16C_505: boolean;
begin
  Result := True;
  case ComboBox4_1.ItemIndex of                  //FOSC
    0: CfgWordPic := $0FF8;
    1: CfgWordPic := $0FF9;
    2: CfgWordPic := $0FFA;
    3: CfgWordPic := $0FFC;
    4: CfgWordPic := $0FFD;
    5: CfgWordPic := $0FFE;
    6: CfgWordPic := $0FFF;
  else Result := False;
       CfgWordPic := $0FFF;
  end;
  case ComboBox4_2.ItemIndex of                  //WDT Enabled
    0: CfgWordPic := CfgWordPic and $0FF7;
    1: CfgWordPic := CfgWordPic and $0FFF;
  else Result := False;
  end;
  case ComboBox4_3.ItemIndex of                  //MCLRE
    0: CfgWordPic := CfgWordPic and $0FDF;
    1: CfgWordPic := CfgWordPic and $0FFF;
  else Result := False;
  end;
  case ComboBox4_4.ItemIndex of                  //CODE PROTECT
    0: CfgWordPic := CfgWordPic and $002F;
    1: CfgWordPic := CfgWordPic and $0FFF;
  else Result := False;
  end;
end;

function TForm1.UpdataPIC16C_18pinOLD: boolean;
begin
  Result := (ComboBox4_1.ItemIndex<>-1)and(ComboBox4_2.ItemIndex<>-1);
  CfgWordPic := $3FF8;
  CfgWordPic := CfgWordPic or (ComboBox4_1.ItemIndex and $0003);        //FOSC
  CfgWordPic := CfgWordPic or ((ComboBox4_2.ItemIndex shl 2)and $0004); //WDT Enabled
  case ComboBox4_3.ItemIndex of                                         //PWRTE
    0: CfgWordPic := CfgWordPic and $3FF7;
    1: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
  case ComboBox4_4.ItemIndex of                                         //CODE PROTECT
    0: CfgWordPic := CfgWordPic and $3FEF;
    1: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
end;

function TForm1.UpdataPIC16C_55x: boolean;
begin
  Result := (ComboBox4_1.ItemIndex<>-1)and(ComboBox4_2.ItemIndex<>-1);
  CfgWordPic := $3FF8;
  CfgWordPic := CfgWordPic or (ComboBox4_1.ItemIndex and $0003);        //FOSC
  CfgWordPic := CfgWordPic or ((ComboBox4_2.ItemIndex shl 2)and $0004); //WDT Enabled
  case ComboBox4_3.ItemIndex of                                         //PWRTE
    0: CfgWordPic := CfgWordPic and $3FF7;
    1: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
  case ComboBox4_4.ItemIndex of                                         //CODE PROTECT
    0: CfgWordPic := CfgWordPic and $00CF;
    1: CfgWordPic := CfgWordPic and $15DF;
    2: CfgWordPic := CfgWordPic and $2AEF;
    3: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
end;

function TForm1.UpdataPIC16C_62x: boolean;
begin
  Result := (ComboBox4_1.ItemIndex<>-1)and(ComboBox4_2.ItemIndex<>-1);
  CfgWordPic := $3FF8;
  CfgWordPic := CfgWordPic or (ComboBox4_1.ItemIndex and $0003);        //FOSC
  CfgWordPic := CfgWordPic or ((ComboBox4_2.ItemIndex shl 2)and $0004); //WDT Enabled
  case ComboBox4_3.ItemIndex of                                         //PWRTE
    0: CfgWordPic := CfgWordPic and $3FF7;
    1: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
  case ComboBox4_4.ItemIndex of                                         //CODE PROTECT
    0: CfgWordPic := CfgWordPic and $00CF;
    1: CfgWordPic := CfgWordPic and $15DF;
    2: CfgWordPic := CfgWordPic and $2AEF;
    3: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
  case ComboBox4_5.ItemIndex of                                         //BODEN
    0: CfgWordPic := CfgWordPic and $3FBF;
    1: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
end;

function TForm1.UpdataPIC16C_71x: boolean;
begin
  Result := (ComboBox4_1.ItemIndex<>-1)and(ComboBox4_2.ItemIndex<>-1);
  CfgWordPic := $3FF8;
  CfgWordPic := CfgWordPic or (ComboBox4_1.ItemIndex and $0003);        //FOSC
  CfgWordPic := CfgWordPic or ((ComboBox4_2.ItemIndex shl 2)and $0004); //WDT Enabled
  case ComboBox4_3.ItemIndex of                                         //PWRTE
    0: CfgWordPic := CfgWordPic and $3FF7;
    1: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
  case ComboBox4_4.ItemIndex of                                         //CODE PROTECT
    0: CfgWordPic := CfgWordPic and $004F;
    1: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
  case ComboBox4_5.ItemIndex of                                         //BODEN
    0: CfgWordPic := CfgWordPic and $3FBF;
    1: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
end;

function TForm1.UpdataPIC16C_xxOLD: boolean;
begin
  Result := (ComboBox4_1.ItemIndex<>-1)and(ComboBox4_2.ItemIndex<>-1);
  CfgWordPic := $3FF8;
  CfgWordPic := CfgWordPic or (ComboBox4_1.ItemIndex and $0003);        //FOSC
  CfgWordPic := CfgWordPic or ((ComboBox4_2.ItemIndex shl 2)and $0004); //WDT Enabled
  case ComboBox4_3.ItemIndex of                                         //PWRTE
    0: CfgWordPic := CfgWordPic and $3FF7;
    1: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
  case ComboBox4_4.ItemIndex of                                         //CODE PROTECT
    0: CfgWordPic := CfgWordPic and $3FCF;
    1: CfgWordPic := CfgWordPic and $3FDF;
    2: CfgWordPic := CfgWordPic and $3FEF;
    3: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
  CfgWordPic := CfgWordPic and $3FBF;
end;

function TForm1.UpdataPIC16C_xxNEW: boolean;
begin
  Result := (ComboBox4_1.ItemIndex<>-1)and(ComboBox4_2.ItemIndex<>-1);
  CfgWordPic := $3FF8;
  CfgWordPic := CfgWordPic or (ComboBox4_1.ItemIndex and $0003);        //FOSC
  CfgWordPic := CfgWordPic or ((ComboBox4_2.ItemIndex shl 2)and $0004); //WDT Enabled
  case ComboBox4_3.ItemIndex of                                         //PWRTE
    0: CfgWordPic := CfgWordPic and $3FF7;
    1: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
  case ComboBox4_4.ItemIndex of                                         //CODE PROTECT
    0: CfgWordPic := CfgWordPic and $00CF;
    1: CfgWordPic := CfgWordPic and $15DF;
    2: CfgWordPic := CfgWordPic and $2AEF;
    3: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
  case ComboBox4_5.ItemIndex of                                         //BODEN
    0: CfgWordPic := CfgWordPic and $3FBF;
    1: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
end;

function TForm1.UpdataPIC16F_xx: boolean;
begin
  Result := (ComboBox4_1.ItemIndex<>-1)and(ComboBox4_2.ItemIndex<>-1);
  CfgWordPic := $3FF8;
  CfgWordPic := CfgWordPic or (ComboBox4_1.ItemIndex and $0003);        //FOSC
  CfgWordPic := CfgWordPic or ((ComboBox4_2.ItemIndex shl 2)and $0004); //WDT Enabled
  case ComboBox4_3.ItemIndex of                                         //PWRTE
    0: CfgWordPic := CfgWordPic and $3FF7;
    1: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
  case ComboBox4_4.ItemIndex of                                         //CODE PROTECT
    0: CfgWordPic := CfgWordPic and $000F;
    1: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
end;

function TForm1.UpdataPIC16F_87x: boolean;
begin
  Result := (ComboBox4_1.ItemIndex<>-1)and(ComboBox4_2.ItemIndex<>-1);
  CfgWordPic := $3FF8;
  CfgWordPic := CfgWordPic or (ComboBox4_1.ItemIndex and $0003);        //FOSC
  CfgWordPic := CfgWordPic or ((ComboBox4_2.ItemIndex shl 2)and $0004); //WDT Enabled
  case ComboBox4_3.ItemIndex of                                         //PWRTE
    0: CfgWordPic := CfgWordPic and $3FF7;
    1: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
  case ComboBox4_4.ItemIndex of                                         //CODE PROTECT
    0: CfgWordPic := CfgWordPic and $0FCF;
    1: CfgWordPic := CfgWordPic and $1FDF;
    2: CfgWordPic := CfgWordPic and $2FEF;
    3: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
  case ComboBox4_5.ItemIndex of                                         //BODEN
    0: CfgWordPic := CfgWordPic and $3FBF;
    1: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
  case ComboBox4_6.ItemIndex of                                         //LVP
    0: CfgWordPic := CfgWordPic and $3F7F;
    1: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
  case ComboBox4_7.ItemIndex of                                         //CPD
    0: CfgWordPic := CfgWordPic and $3EFF;
    1: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
  case ComboBox4_8.ItemIndex of                                         //WRT
    0: CfgWordPic := CfgWordPic and $3DFF;
    1: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
  case ComboBox4_9.ItemIndex of                                         //DEBUG
    0: CfgWordPic := CfgWordPic and $37FF;
    1: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
end;

function TForm1.UpdataPIC12C_67x: boolean;
begin
  Result := True;
  case ComboBox4_1.ItemIndex of                  //FOSC
    0: CfgWordPic := $3FF8;
    1: CfgWordPic := $3FF9;
    2: CfgWordPic := $3FFA;
    3: CfgWordPic := $3FFC;
    4: CfgWordPic := $3FFD;
    5: CfgWordPic := $3FFE;
    6: CfgWordPic := $3FFF;
  else Result := False;
       CfgWordPic := $3FFF;
  end;
  case ComboBox4_2.ItemIndex of                  //WDT Enabled
    0: CfgWordPic := CfgWordPic and $3FF7;
    1: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
  case ComboBox4_3.ItemIndex of                  //PWRTE
    0: CfgWordPic := CfgWordPic and $3FEF;
    1: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
  case ComboBox4_4.ItemIndex of                  //CODE PROTECT
    0: CfgWordPic := CfgWordPic and $009F;
    1: CfgWordPic := CfgWordPic and $15BF;
    2: CfgWordPic := CfgWordPic and $2ADF;
    3: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
  case ComboBox4_5.ItemIndex of                  //MCLR
    0: CfgWordPic := CfgWordPic and $3F7F;
    1: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
end;

function TForm1.UpdataPIC16C_92x: boolean;
begin
  Result := (ComboBox4_1.ItemIndex<>-1)and(ComboBox4_2.ItemIndex<>-1);
  CfgWordPic := $3FF8;
  CfgWordPic := CfgWordPic or (ComboBox4_1.ItemIndex and $0003);        //FOSC
  CfgWordPic := CfgWordPic or ((ComboBox4_2.ItemIndex shl 2)and $0004); //WDT Enabled
  case ComboBox4_3.ItemIndex of                                         //PWRTE
    0: CfgWordPic := CfgWordPic and $3FF7;
    1: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
  case ComboBox4_4.ItemIndex of                                         //CODE PROTECT
    0: CfgWordPic := CfgWordPic and $00CF;
    1: CfgWordPic := CfgWordPic and $15DF;
    2: CfgWordPic := CfgWordPic and $2AEF;
    3: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
end;

function TForm1.UpdataPIC16C_77x: boolean;
begin
  Result := UpdataPIC16C_xxNEW;
  if Result then begin
    CfgWordPic := CfgWordPic or $0C00;
    case ComboBox4_4.ItemIndex of                                         //borv
      0: CfgWordPic := CfgWordPic and $33FF;
      1: CfgWordPic := CfgWordPic and $37FF;
      2: CfgWordPic := CfgWordPic and $3BFF;
      3: CfgWordPic := CfgWordPic and $3FFF;
    else Result := False;
    end;
  end;
end;

function TForm1.UpdataPIC16C_715: boolean;
begin
  Result := UpdataPIC16C_xxNEW;
  if Result then begin
    CfgWordPic := CfgWordPic or $0080;
    case ComboBox4_8.ItemIndex of                                         //parity
      0: CfgWordPic := CfgWordPic and $3F7F;
      1: CfgWordPic := CfgWordPic and $3FFF;
    else Result := False;
    end;
  end;
end;


function TForm1.UpdataPIC16F_62x: boolean;
begin
  Result := True;
  case ComboBox4_1.ItemIndex of                  //FOSC
    0: CfgWordPic := $3FEC;
    1: CfgWordPic := $3FED;
    2: CfgWordPic := $3FEE;
    3: CfgWordPic := $3FEF;
    4: CfgWordPic := $3FFC;
    5: CfgWordPic := $3FFD;
    6: CfgWordPic := $3FFE;
    7: CfgWordPic := $3FFF;
  else Result := False;
       CfgWordPic := $3FFF;
  end;
  case ComboBox4_2.ItemIndex of                  //WDT Enabled
    0: CfgWordPic := CfgWordPic and $3FFB;
    1: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
  case ComboBox4_3.ItemIndex of                                         //PWRTE
    0: CfgWordPic := CfgWordPic and $3FF7;
    1: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
  case ComboBox4_4.ItemIndex of                                         //CODE PROTECT
    0: CfgWordPic := CfgWordPic and $03FF;
    1: CfgWordPic := CfgWordPic and $17FF;
    2: CfgWordPic := CfgWordPic and $2BFF;
    3: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
  case ComboBox4_5.ItemIndex of                                         //BODEN
    0: CfgWordPic := CfgWordPic and $3FBF;
    1: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
  case ComboBox4_6.ItemIndex of                                         //LVP
    0: CfgWordPic := CfgWordPic and $3F7F;
    1: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
  case ComboBox4_7.ItemIndex of                                         //CPD
    0: CfgWordPic := CfgWordPic and $3EFF;
    1: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
  case ComboBox4_8.ItemIndex of                                         //WRT-MCLRE
    0: CfgWordPic := CfgWordPic and $3FDF;
    1: CfgWordPic := CfgWordPic and $3FFF;
  else Result := False;
  end;
end;


function TForm1.ConfigPicToWord: boolean;
begin
  case (BlokPar[$49] and $3F) of
    $20: Result := UpdataPIC16C_18pinOLD;         //PIC16C61,71,C84
    $21: Result := UpdataPIC16C_55x;              //PIC16C55x
    $22: Result := UpdataPIC16C_62x;              //PIC16C62x
    $23: Result := UpdataPIC16C_71x;              //PIC16C710,711
    $24: Result := UpdataPIC16C_xxOLD;            //PIC16C62,73,64,65,74
    $25: Result := UpdataPIC16C_xxNEW;            //PIC16C62A,63,64A,65A,73A,74A..
    $26: Result := UpdataPIC16F_87x;
    $27: Result := UpdataPIC16F_87x;
    $28: Result := UpdataPIC16C_18pinOLD;         //PIC16CC84
    $29: Result := UpdataPIC16F_xx;               //PIC16F83,84
    $2A: Result := UpdataPIC16C_715;            //PIC16C715
    $2B: Result := UpdataPIC16C_715;            //PIC16C64x,66x
    $2C: Result := UpdataPIC16C_505;              //PIC16C505
    $2D: Result := UpdataPIC12C_5xx;              //PIC12C5xx
    $2E: Result := UpdataPIC12C_67x;
    $33: Result := UpdataPIC16F_87x;
    $34: Result := UpdataPIC16C_92x;              //PIC16c92x,745,765
    $35: Result := UpdataPIC16C_77x;              //PIC16c77x
    $36: Result := UpdataPIC16F_62x;
  else Result := False;
  end;
  if Result then
  begin
    CfgWord[1] := Lo(CfgWordPic);
    CfgWord[2] := CfgWordPic shr 8;
    if (BlokPar[$49] and $3F) in [$2D, $2C] then Result := WriteBlokRam($1FFE, $2, CfgWord)
    else Result := WriteBlokRam($400E, $2, CfgWord);
  end;
end;

procedure TForm1.btnPICClick(Sender: TObject);
begin
  if btnPIC.Caption = '>' then
    begin btnPIC.Caption := '<'; Panel1.SendToBack; end
  else
    begin btnPIC.Caption := '>'; Panel2.SendToBack; ComboBox4_1.SetFocus end;
end;

procedure TForm1.UpdateConfigPIC(Sender: TObject);
begin
  if not ConfigPicToWord then
  begin
    if ComboBox4_1.Focused then ComboBox4_1.ItemIndex := -1;
    if ComboBox4_2.Focused then ComboBox4_2.ItemIndex := -1;
    if ComboBox4_3.Focused then ComboBox4_3.ItemIndex := -1;
    if ComboBox4_4.Focused then ComboBox4_4.ItemIndex := -1;
    if ComboBox4_5.Focused then ComboBox4_5.ItemIndex := -1;
    if ComboBox4_6.Focused then ComboBox4_6.ItemIndex := -1;
    if ComboBox4_7.Focused then ComboBox4_7.ItemIndex := -1;
    if ComboBox4_8.Focused then ComboBox4_8.ItemIndex := -1;
    if ComboBox4_9.Focused then ComboBox4_9.ItemIndex := -1;
    if ComboBox4_10.Focused then ComboBox4_10.ItemIndex := -1;
  end;
end;


procedure TForm1.RadioGroup5_3Click(Sender: TObject);
begin
  CheckBox1.Checked := False;
  BlokPar[$4B] := RadioGroup5_3.ItemIndex + 1; //Количество бит защиты
  if not WriteBlokPar($4B, $4B) then RadioGroup5_3.ItemIndex := -1;
end;

procedure TForm1.CheckBox5_3Click(Sender: TObject);
begin
  if CheckBox5_3.Checked then BlokPar[$2F] := BlokPar[$2F] or $40
  else BlokPar[$2F] := BlokPar[$2F] and $BF;
  if not WriteBlokPar($2F, $2F) then CheckBox5_3.State := cbGrayed;
end;


end.
