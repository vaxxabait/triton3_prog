
var
// Result:
	FPort: THandle;


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

//DCB.BaudRate := 57600;
//DCB.ByteSize := 8;
//DCB.Parity   := NOPARITY;
//DCB.StopBits := ONESTOPBIT;

//SetCommState(FPort, DCB);

//GetCommTimeouts(Fport,COMMTIMEOUTS);

//COMMTIMEOUTS.ReadIntervalTimeout := 2000;
//COMMTIMEOUTS.ReadTotalTimeoutMultiplier := 50;
//COMMTIMEOUTS.ReadTotalTimeoutConstant := 2000;
//COMMTIMEOUTS.WriteTotalTimeoutMultiplier := 0;
//COMMTIMEOUTS.WriteTotalTimeoutConstant := 0;

//SetCommTimeouts(FPort,COMMTIMEOUTS);

	TxdCom[1] := $55;
	TxdCom[2] := CodComm;
//WriteFile(FPort, TxdCom, 2, dwSent, nil);
	dwSent := FileWrite(FPort, TxdCom, 2);

//if not ReadFile(FPort,Result,1,dwSent,nil) or (Result<>CodComm) or (Result=$13) or (Result=$1F) or (Result=$1E) then FileClose(FPort);

	dwSent := FileRead(FPort,Result,1);
	if (Result<>CodComm) or (Result=$13) or (Result=$1F) or (Result=$1E) then FileClose(FPort);
end;
