var


implementation

uses Triton_Main1, HEdit;


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

  // Result :=(OpenComPortSearch($1C,iCOMPort)=$1C) and ReadFile(FPort,ChipBlok,8,dwSent,nil);
  Result :=(OpenComPortSearch($1C,iCOMPort)=$1C);
  dwSent := FileRead(FPort,ChipBlok,8);

  if Result then for n := 1 to 8 do
  begin
    if ChipBlok[n] > 0 then for k := 0 to ChipBlok[n] -1 do
    begin
      Sleep(2);
      TxdBuf[1] := $30;
      TxdBuf[2] := 9;
      //WriteFile(FPort, TxdBuf, 2, dwSent, nil);
      dwSent := FileWrite(FPort, TxdBuf, 2);
      //ReadFile(FPort, RxdBuf, 9, dwSent, nil);
      dwSent := FileRead(FPort, RxdBuf, 9);
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
  if not Result then // MessageBox(0,Error,'Инициализация',mb_IconStop or mb_TaskModal);
     MessageBox(0,Error,'Инициализация',mb_IconStop);
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
    //WriteFile(FPort, Buf, 5, dwSent, nil);
    dwSent := FileWrite(FPort, Buf, 5);
    Result := 12;
    if ControlCheckSumm(TxdSum) then
    begin
      Buf[0] := $2D;
      Buf[1] := $85 - $2D + 1;
      TxdSum := Buf[1];
      //ReadFile(FPort, Result, 1, dwSent, nil);
      dwSent := FileRead(FPort, Result, 1);
      if (Result = 0) and (dwSent = 1) then
      begin
        //WriteFile(FPort, Buf, 2, dwSent, nil);
        dwSent := FileWrite(FPort, Buf, 2);

        //Stat := ReadFile(FPort, Buf, TxdSum, dwSent, nil);
        dwSent := FileRead(FPort, Buf, TxdSum);
        Stat := true;

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
    //WriteFile(FPort, Buf, 2, dwSent, nil);
    dwSent := FileWrite(FPort, Buf, 2);
    TxdSum := 0;
    for k := BlokBegin to BlokEnd do TxdSum :=(TxdSum + BlokPar[k])and $FF;
    //WriteFile(FPort,BlokPar[BlokBegin],(BlokEnd-BlokBegin+1),dwSent,nil);
    dwSent := FileWrite(FPort,BlokPar[BlokBegin],(BlokEnd-BlokBegin+1));
    Result := ControlCheckSumm(TxdSum);
  end;
  FileClose(FPort); { *Converted from CloseHandle*  }
  if not Result then //MessageBox(0,'Передача блока параметров. Ошибка КС.','Загрузка данных',mb_IconStop or mb_TaskModal);
     MessageBox(0,'Передача блока параметров. Ошибка КС.','Загрузка данных',mb_IconStop);
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
    //WriteFile(FPort, Buf, 2, dwSent, nil);
    dwSent := FileWrite(FPort, Buf, 2);

    //Result := ReadFile(FPort, Buf, TxdSum, dwSent, nil);
    dwSent := FileRead(FPort, Buf, TxdSum);
    Result := true;

    TxdSum := 0;
    if Result then for k := 0 to dwSent-1 do TxdSum :=(TxdSum + Buf[k])and $FF;
    if Result then Result := ControlCheckSumm(TxdSum);
    if Result then for k := 0 to dwSent-1 do BlokPar[k+BlokBegin] := Buf[k];
  end;
  FileClose(FPort); { *Converted from CloseHandle*  }
  if not Result then //MessageBox(0,'Прием блока параметров. Ошибка КС.','Загрузка данных',mb_IconStop or mb_TaskModal);
    MessageBox(0,'Прием блока параметров. Ошибка КС.','Загрузка данных',mb_IconStop);
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
  //WriteFile(FPort, Buf, 11, dwSent, nil);
  dwSent := FileWrite(FPort, Buf, 11);
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
    dwSent := FileWrite(FPort, Buffer, BlokLength);
    Result := ControlCheckSumm(TxdSum);
  end;
  FileClose(FPort); { *Converted from CloseHandle*  }
  if not Result then //MessageBox(0,'Ошибка загрузки данных в программатор.','Загрузка данных',mb_IconStop or mb_TaskModal);
       MessageBox(0,'Ошибка загрузки данных в программатор.','Загрузка данных',mb_IconStop);
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
      //WriteFile(FPort, TxdSum, 1, dwSent, nil);
      dwSent := FileWrite(FPort, TxdSum, 1);
      //ReadFile(FPort, RxdAck, 1, dwSent, nil);
      dwSent := FileRead(FPort, RxdAck, 1);
      TxdSum := (TxdSum + RxdAck)and $FF;
      Buffer[i] := RxdAck;
      if dwSent = 0 then Break;
    end;
    Result := ControlCheckSumm(TxdSum);
  end;
  FileClose(FPort); { *Converted from CloseHandle*  }
  if not Result then //MessageBox(0,'Ошибка чтения данных из ОЗУ.','Загрузка данных',mb_IconStop or mb_TaskModal);
         MessageBox(0,'Ошибка чтения данных из ОЗУ.','Загрузка данных',mb_IconStop);
end;
