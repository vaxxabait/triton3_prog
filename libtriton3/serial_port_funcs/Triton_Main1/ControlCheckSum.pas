
var

// Result:
	FPort: THandle;

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
