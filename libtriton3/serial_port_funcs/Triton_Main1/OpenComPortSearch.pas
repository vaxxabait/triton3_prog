
var
// Result:
	FPort: THandle;

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
