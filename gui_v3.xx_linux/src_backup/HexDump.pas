unit HexDump;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

const
  MAXDIGITS = 16;

{ THexDump }

type
  THexStr = array[0..2] of Char;
  THexStrArray = array[0..MAXDIGITS-1] of THexStr;
  TWordStr = array[0..4] of Char;
  TWordStrArray = array[0..MAXDIGITS-1] of TWordStr;

  THexDump = class(TCustomControl)
  private
    FHByte: Boolean;
    FDragg: Boolean;
    FAddress: Pointer;
    FDataSize: Integer;
    FStart: Integer;
    FLength: Integer;
    FDragBeg: Integer;
    FDragFin: Integer;
    FTopLine: Integer;
    FVisibleLines: Integer;
    FLineCount: Integer;
    FBytesPerLine: Integer;
    FItemHeight: Integer;
    FItemWidth: Integer;
    FHexData: THexStrArray;
    FWordData: TWordStrArray;

    FLineAddr: array[0..15] of char;
    procedure CalcPaintParams;
    procedure SetTopLine(Value: Integer);
    procedure SetCursorPos(Value: Integer);
    procedure SetAddress(Value: Pointer);
    procedure SetDataSize(Value: Integer);
    procedure SetFStart(Value: Integer);
    procedure SetFLength(Value: Integer);
    function LineAddr(Index: Integer): PChar;
    function LineData(Index: Integer): PChar;
    function LineChars(Index: Integer): PChar;
    function ScrollIntoView: Boolean;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMEnter(var Message: TCMGotFocus); message CM_ENTER;
    procedure CMExit(var Message: TCMLostFocus); message CM_EXIT;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
  protected
    procedure Paint; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure DoStartDrag(var DragObject: TDragObject); override;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean); override;
    procedure DoEndDrag(Target: TObject; X, Y: Integer); override;
  public
    FModify: Boolean;
    FInsert: Boolean;
    FModHex: Boolean;
    FormatData: integer;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Address: Pointer read FAddress write SetAddress;
    property DataSize: Integer read FDataSize write SetDataSize;
    property SelStart: Integer read FStart write SetFStart;
    property SelLength: Integer read FLength write SetFLength;
    function GetCheckSum: Word;
    procedure InsertBlock(Buffer: pointer; Count: integer; TmpInsert: boolean);
    procedure DeleteBlock;
    procedure CopyBlock(Buffer: pointer; Count: integer);
    procedure FillBlock(Value: Integer);
    procedure MaskBlock(Value, Mask: Integer);
    procedure FindBlock(FindBuf, ReplBuf: PChar; Next: Boolean; Mode: integer);
  published
    property Font;
  end;

function CreateHexDump(AOwner: TWinControl): THexDump;

implementation

{ Form Methods }

function CreateHexDump(AOwner: TWinControl): THexDump;
begin
  Result := THexDump.Create(AOwner);
  with Result do begin
    Parent := AOwner;
    Font.Name := 'Courier New';
    Align := alClient;
    FStart := 0;
    FLength := 0;
    FModify := False;
    FInsert := False;
    FModHex := True;
    FHByte := True;
  end;
end;


{ THexDump }

constructor THexDump.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Color := clWhite;
  Width := 300;
  Height := 200;
  FormatData := 0;
  FillChar(FHexData, SizeOf(FHexData), #9);
  FillChar(FWordData, SizeOf(FWordData), #9);
end;

destructor THexDump.Destroy;
begin
  inherited Destroy;
end;


{ VCL Command Messages }

procedure THexDump.CMFontChanged(var Message: TMessage);
begin
  inherited;
  Canvas.Font := Self.Font;
  FItemHeight := Canvas.TextHeight('A');
  FItemWidth := Canvas.TextWidth('D');
  CalcPaintParams;
end;

procedure THexDump.CMEnter;
begin
  inherited;
{  InvalidateLineMarker; }
end;

procedure THexDump.CMExit;
begin
  inherited;
{  InvalidateLineMarker; }
end;


{ Windows Messages }

procedure THexDump.WMSize(var Message: TWMSize);
begin
  inherited;
  CalcPaintParams;
end;

procedure THexDump.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS;
end;

procedure THexDump.WMVScroll(var Message: TWMVScroll);
var
  NewTopLine: Integer;
begin
  inherited;
  NewTopLine := FTopLine;
  case Message.ScrollCode of
    SB_LINEDOWN: Inc(NewTopLine);
    SB_LINEUP:   Dec(NewTopLine);
    SB_PAGEDOWN: Inc(NewTopLine, FVisibleLines - 1);
    SB_PAGEUP:   Dec(NewTopLine, FVisibleLines - 1);
    SB_THUMBPOSITION, SB_THUMBTRACK: NewTopLine := Message.Pos;
  end;
  if NewTopLine < 0 then NewTopLine := 0;
  if NewTopLine >= FLineCount then NewTopLine := FLineCount - 1;
  SetTopLine(NewTopLine);
end;


{ Painting Related }

procedure THexDump.CalcPaintParams;
begin
  if FItemHeight < 1 then Exit;
  FVisibleLines := (ClientHeight div FItemHeight) + 1;
  FBytesPerLine := ((ClientWidth div FItemWidth) - 12) div 4;
  if FBytesPerLine < 1 then FBytesPerLine := 1
  else if FBytesPerLine > MAXDIGITS then FBytesPerLine := MAXDIGITS;
  FLineCount := (DataSize div FBytesPerLine);
  if Boolean(DataSize mod FBytesPerLine) then Inc(FLineCount);
  SetScrollRange(Handle, SB_VERT, 0, FLineCount - 1, True);
end;

function THexDump.ScrollIntoView: Boolean;
begin
  Result := True;
  if (FStart div FBytesPerLine) < FTopLine then begin
    SetTopLine(FStart div FBytesPerLine);
    Result := False;
  end else if (FStart div FBytesPerLine) >= FTopLine + FVisibleLines - 1 then
  begin
    SetTopLine((FStart div FBytesPerLine) - FVisibleLines + 2);
    Result := False;
  end;
end;

procedure THexDump.SetTopLine(Value: Integer);
var
  LinesMoved: Integer;
  R: TRect;
begin
  if Value <> FTopLine then begin
    if Value < 0 then Value := 0;
    if Value >= FLineCount then Value := FLineCount - 1;
    LinesMoved := FTopLine - Value;
    FTopLine := Value;
    SetScrollPos(Handle, SB_VERT, FTopLine, True);
    if Abs(LinesMoved) = 1 then begin
      if LinesMoved = -1 then begin
        R := Bounds(1, 0, ClientWidth, (FVisibleLines -2) * FItemHeight);
        ScrollWindow(Handle, 0, LinesMoved * FItemHeight, @R, nil);
        R.Top := ClientHeight - FItemHeight * 2;
        R.Bottom := ClientHeight;
      end else begin
        R := Bounds(1, 0, ClientWidth, ClientHeight - FItemHeight);
        OffsetRect(R, 0, FItemHeight);
        ScrollWindow(Handle, 0, LinesMoved * FItemHeight, @R, nil);
        R.Top := 0;
        R.Bottom := FItemHeight;
      end;
      InvalidateRect(Handle, @R, False);
    end else Invalidate;
  end;
end;

procedure THexDump.Paint;
var
  R, RF: TRect;
  AddressWidth, TabStop, ByteCnt, I: Integer;
  BegSel, FinSel, BegPix, BegLen: Integer;
begin
  inherited Paint;
  AddressWidth := (FItemWidth * 10) + 4;
  R := Bounds(1, 0, ClientWidth, FItemHeight);
  TabStop := FItemWidth * 3;
  ByteCnt := FBytesPerLine;
  if FLength > 0 then BegSel := FStart else BegSel := FStart + FLength;
  if FLength > 0 then FinSel := FStart + FLength else FinSel := FStart;
  if FDragg then begin BegSel := FDragBeg; FinSel := FDragFin; end;
  SetBkMode(Canvas.Handle, TRANSPARENT);
  for I := 0 to FVisibleLines - 1 do begin
    R.Left := 4;
    if I + FTopLine < FLineCount then begin
      R.Right := AddressWidth;
      ExtTextOut(Canvas.Handle, R.Left, R.Top, ETO_CLIPPED, @R, LineAddr(I+FTopLine), 9, nil);
      R.Left := R.Right;
      if (I+FTopLine = FLineCount-1) and ((FDataSize mod FBytesPerLine) > 0) then
        ByteCnt := FDataSize mod FBytesPerLine;
      if (BegSel div FBytesPerLine <= I+FTopLine)and(I+FTopLine <= FinSel div FBytesPerLine)and(FLength<>0) then
      begin
        if BegSel div FBytesPerLine = I+FTopLine then BegPix := (BegSel mod FBytesPerLine) * FItemWidth
        else BegPix := 0;
        if FinSel div FBytesPerLine = I+FTopLine then BegLen := (FinSel mod FBytesPerLine) * FItemWidth
        else if FinSel div FBytesPerLine > I+FTopLine then BegLen := ByteCnt * FItemWidth
             else BegLen := 0;
        RF := R;
        RF.Left := RF.Left + (BegPix * 3);
        RF.Right := RF.Right + (BegLen * 3);
        if FModHex then FillRect(Canvas.Handle, RF, COLOR_HIGHLIGHTTEXT)
          else FillRect(Canvas.Handle, RF, COLOR_GRAYTEXT);
        RF := R;
        RF.Left := RF.Left + BegPix + (FBytesPerLine * TabStop) + FItemWidth;
        RF.Right := RF.Right + BegLen + (FBytesPerLine * TabStop) + FItemWidth;
        if FModHex then FillRect(Canvas.Handle, RF, COLOR_GRAYTEXT)
          else FillRect(Canvas.Handle, RF, COLOR_HIGHLIGHTTEXT);
      end;
      R.Right := ClientWidth;
      TabbedTextOut(Canvas.Handle, R.Left, R.Top, LineData(I+FTopLine), (ByteCnt*3)-1, 1, TabStop, R.Left);
      R.Left := AddressWidth + (FItemWidth * (FBytesPerLine * 3 + 1));
      ExtTextOut(Canvas.Handle, R.Left, R.Top, ETO_CLIPPED, @R, LineChars(I+FTopLine), ByteCnt, nil);
    end else ExtTextOut(Canvas.Handle, R.Left, R.Top, ETO_OPAQUE or ETO_CLIPPED, @R, nil, 0, nil);
    OffsetRect(R, 0, FItemHeight);
  end;
  SetCursorPos(FStart);
end;

function THexDump.LineAddr(Index: Integer): PChar;
begin
  Result := StrFmt(FLineAddr, '%p:', [Pointer(Index*FBytesPerLine)]);
end;

function THexDump.LineData(Index: Integer): PChar;

  procedure SetData(P: PChar);
  const
    HexDigits : array[0..15] of Char = '0123456789ABCDEF';
  var
    I: Integer;
    B: Byte;
  begin
    I := 0;
    repeat
      try
        B := Byte(P[I]);
        FWordData[I div 2][2] := HexDigits[B SHR $04];
        FWordData[I div 2][3] := HexDigits[B AND $0F];
        B := Byte(P[I +1]);
        FWordData[I div 2][0] := HexDigits[B SHR $04];
        FWordData[I div 2][1] := HexDigits[B AND $0F];
      except
      end;
      Inc(I, 2);
    until I >= FBytesPerLine;

    for I := 0 to FBytesPerLine-1 do
    begin
      try
        B := Byte(P[I]);
        FHexData[I][0] := HexDigits[B SHR $04];
        FHexData[I][1] := HexDigits[B AND $0F];
      except
        FHexData[I][0] := '?';
        FHexData[I][1] := '?';
      end;
    end;
  end;

begin
  SetData(PChar(FAddress) + Index*FBytesPerLine);
  case FormatData of
    1: Result := FWordData[0];
  else Result := FHexData[0];
  end;
end;

function THexDump.LineChars(Index: Integer): PChar;
begin
  Result := PChar(FAddress) + Index*FBytesPerLine;
end;


{ Property Set/Get Routines }

procedure THexDump.SetAddress(Value: Pointer);
begin
  FAddress := Value;
  Invalidate;
end;

procedure THexDump.SetDataSize(Value: Integer);
begin
  FDataSize := Value;
  CalcPaintParams;
  Invalidate;
end;

procedure THexDump.SetFStart(Value: Integer);
begin
  if Value < 1 then Value := 0 else if Value > FDataSize then Value := FDataSize;
  SetCursorPos(FStart);
  SetCursorPos(Value);
  ScrollIntoView;
end;

procedure THexDump.SetFLength(Value: Integer);
begin
  if (FStart + Value) > FDataSize then Value := FDataSize - FStart
  else if 0 > (FStart + Value) then Value := 0 - FStart;
  FLength := Value;
  Invalidate;
  SendMessage(Application.MainForm.Handle, WM_CHILDACTIVATE, 0, 0);
end;


{ Event Overrides }

procedure THexDump.KeyDown(var Key: Word; Shift: TShiftState);
var
  BegAdr, FinAdr: integer;
  R: TRect;
begin
  BegAdr := FStart;
  FinAdr := FLength;
  case Key of
    VK_RIGHT: begin FinAdr := 0; Inc(BegAdr); end;
    VK_DOWN:  begin FinAdr := 0; Inc(BegAdr, FBytesPerLine); end;
    VK_NEXT:  begin FinAdr := 0; Inc(BegAdr, FBytesPerLine * FVisibleLines); end;
    VK_END:   if (ssCtrl in Shift) then begin FinAdr := 0; BegAdr := FDataSize; end
              else if (ssShift in Shift) then
                    begin FinAdr := 0; Inc(BegAdr, FBytesPerLine-(FStart mod FBytesPerLine)); end
                   else
                    begin FinAdr := 0; Inc(BegAdr, FBytesPerLine-(FStart mod FBytesPerLine)-1); end;
    VK_LEFT:  begin FinAdr := 0; Dec(BegAdr); end;
    VK_UP:    begin FinAdr := 0; Dec(BegAdr, FBytesPerLine); end;
    VK_PRIOR: begin FinAdr := 0; Dec(BegAdr, FBytesPerLine * FVisibleLines); end;
    VK_HOME:  if (ssCtrl in Shift) then begin FinAdr := 0; BegAdr := 0; end
              else begin FinAdr := 0; Dec(BegAdr, (FStart mod FBytesPerLine)); end;
    VK_TAB:   FModHex := not FModHex;
    VK_INSERT:begin SetCursorPos(FStart); FInsert := not FInsert; SetCursorPos(FStart); end;
  end;
  if BegAdr < 1 then BegAdr := 0 else if BegAdr > FDataSize then BegAdr := FDataSize;
  if (ssShift in Shift) and (FinAdr = 0) then FinAdr := FLength + FStart - BegAdr;
  if (BegAdr <> FStart) or (FinAdr <> FLength) then begin
    if (FLength <> 0) and (FinAdr = 0) then Invalidate;
    if Abs(FinAdr) > FDataSize then FLength := FDataSize else FLength := FinAdr;
    if FLength <> 0 then begin
      if FStart < BegAdr then
        R := Bounds(1, ((FStart div FBytesPerLine)-FTopLine)*FItemHeight,
         ClientWidth, ((BegAdr-FStart) div FBytesPerLine +1)*FItemHeight)
      else
        R := Bounds(1, ((BegAdr div FBytesPerLine)-FTopLine)*FItemHeight,
         ClientWidth, ((FStart-BegAdr)div FBytesPerLine +2)*FItemHeight);
      InvalidateRect(Handle, @R, True);
    end;
    SetCursorPos(FStart);
    FHByte := True;
    SetCursorPos(BegAdr);
    ScrollIntoView;
    SendMessage(Application.MainForm.Handle, WM_CHILDACTIVATE, 0, 0);
  end;
end;

procedure THexDump.KeyPress(var Key: Char);
var
  Digit: byte;
  R: TRect;
begin
  if FModHex then begin
    Key :=UpCase(Key);
    if not (Key in ['0'..'9','A'..'F']) then Key := #0;
  end;
  if (Key = #0) or (Key = #08) then Exit;    //Backspace
  if FLength <> 0 then DeleteBlock;
  if FInsert or (FStart = FDataSize) then begin
    if not FModHex then InsertBlock(@Key, 1, False)
    else begin
      Digit := ord(Key) - ord('0');
      if Digit > 10 then Dec(Digit, 7);
      Key := Chr(Digit * 16);
      if FHByte then InsertBlock(@Key, 1, False)
      else begin
        Digit := Digit + (Byte(PChar(FAddress)[FStart]) and $F0);
        PChar(FAddress)[FStart] := Chr(Digit);
      end;
      FHByte := not FHByte;
    end;
  end else begin
    if not FModHex then PChar(FAddress)[FStart] := Key
    else begin
      Digit := ord(Key) - ord('0');
      if Digit > 10 then Dec(Digit, 7);
      if FHByte then Digit := Digit*16 + (Byte(PChar(FAddress)[FStart]) and $0F)
      else Digit := Digit + (Byte(PChar(FAddress)[FStart]) and $F0);
      FHByte := not FHByte;
      PChar(FAddress)[FStart] := Chr(Digit);
    end;
  end;
  R := Bounds(1,((FStart div FBytesPerLine)-FTopLine)*FItemHeight,ClientWidth,FItemHeight);
  InvalidateRect(Handle, @R, True);
  SetCursorPos(FStart);
  if FHByte then Inc(FStart);
  SetCursorPos(FStart);
  ScrollIntoView;
  FModify := True;
  SendMessage(Application.MainForm.Handle, WM_CHILDACTIVATE, 0, 0);
end;

procedure THexDump.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if not Focused then SetFocus;
  if (Button = mbLeft) and (Cursor = crIBeam) then begin
    FModHex := X-4 < (FBytesPerLine * 3 + 10) * FItemWidth;
    if FModHex then
      FStart := (FTopLine+(Y div FItemHeight))*FBytesPerLine +(((X-4) div FItemWidth -10) div 3)
    else
      FStart := (FTopLine+(Y div FItemHeight))*FBytesPerLine +((X div FItemWidth)-(FBytesPerLine *3 +11));
    if FStart > FDataSize then FStart := FDataSize;
    FLength := 0;
    FHByte := True;
    Invalidate;
  end;
  if Button = mbLeft then BeginDrag(False);
  SendMessage(Application.MainForm.Handle, WM_CHILDACTIVATE, 0, 0);
end;

procedure THexDump.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  CursPos, BegSel, FinSel: integer;
begin
  if X < FItemWidth * 10 then begin Cursor := crArrow; Exit; end;
  if FLength > 0 then BegSel := FStart else BegSel := FStart + FLength;
  if FLength > 0 then FinSel := FStart + FLength else FinSel := FStart;
  Cursor := crIBeam;
  CursPos := -1;
  if FModHex and (X <(FBytesPerLine*3 +10)*FItemWidth) then
    CursPos :=(FTopLine+(Y div FItemHeight))*FBytesPerLine+((((X-4) div FItemWidth)-10) div 3);
  if (FModHex = False) and (X >(FBytesPerLine*3 +11)*FItemWidth) then
    CursPos :=(FTopLine+(Y div FItemHeight))*FBytesPerLine +(((X-4) div FItemWidth)-(FBytesPerLine *3 +11));
  if (BegSel <= CursPos) and (CursPos < FinSel) then Cursor := crArrow;
end;

procedure THexDump.DoStartDrag(var DragObject: TDragObject);
begin
  if (FLength <> 0) and (Cursor = crArrow) then begin
    if FLength > 0 then FDragBeg := FStart else FDragBeg := FStart + FLength;
    if FLength > 0 then FDragFin := FStart + FLength else FDragFin := FStart;
    DragCursor := crDrag;
    FDragg := True;
  end else begin
    DragCursor := crIBeam;
    FDragg := False;
  end;
end;

procedure THexDump.DragOver(Source: TObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean);
var
  R: TRect;
  CursPos: integer;
  NewMode: boolean;
begin
  if X < FItemWidth * 10 then Exit;
  if (Y < FItemHeight) and (FTopLine > 0) then SetTopLine(FTopLine -1);
  if Y > ((FVisibleLines -2) * FItemHeight) then SetTopLine(FTopLine +1);
  NewMode := FModHex;
  if FDragg then NewMode := X - 4 < (FBytesPerLine * 3 + 10) * FItemWidth;
  CursPos := FStart;
  if NewMode and (X <(FBytesPerLine*3 +10)*FItemWidth) then
    CursPos :=(FTopLine+(Y div FItemHeight))*FBytesPerLine+(((X div FItemWidth)-9) div 3);
  if (NewMode = False) and (X >(FBytesPerLine*3 +11)*FItemWidth) then
    CursPos :=(FTopLine+(Y div FItemHeight))*FBytesPerLine +((X div FItemWidth)-(FBytesPerLine *3 +11));
  if CursPos < 1 then CursPos := 0 else if CursPos > FDataSize then CursPos := FDataSize;
  if (not FDragg) and (FStart <> CursPos) then begin
    FLength := FLength + FStart - CursPos;
    if FStart < CursPos then
      R := Bounds(1, ((FStart div FBytesPerLine)-FTopLine)*FItemHeight,
       ClientWidth, ((CursPos-FStart) div FBytesPerLine +1)*FItemHeight)
    else
      R := Bounds(1, (Y div FItemHeight)*FItemHeight, ClientWidth,
       ((FStart-CursPos)div FBytesPerLine +2)*FItemHeight);
    FStart := CursPos;
    InvalidateRect(Handle, @R, True);
  end;
  if FDragg and (FStart <> CursPos) then begin
    SetCursorPos(FStart);
    FModHex := NewMode;
    SetCursorPos(CursPos);
  end;
end;

procedure THexDump.DoEndDrag(Target: TObject; X, Y: Integer);
var
  DragBuf: pointer;
  DragSize: integer;
begin
  if FDragg then begin
    if ((FStart < FDragBeg) or (FDragFin < FStart)) then begin
      DragSize := FDragFin - FDragBeg;
      GetMem(DragBuf, DragSize);
      MoveMemory(DragBuf, @PChar(FAddress)[FDragBeg], DragSize);
      if FDragFin < FStart then begin
        MoveMemory(@PChar(FAddress)[FDragBeg], @PChar(FAddress)[FDragFin], FStart - FDragFin);
        FStart := FStart - DragSize;
      end;
      if FStart < FDragBeg then
        MoveMemory(@PChar(FAddress)[FStart+DragSize], @PChar(FAddress)[FStart], FDragBeg - FStart);
      MoveMemory(@PChar(FAddress)[FStart], DragBuf, DragSize);
      FLength := Abs(FLength);
      FreeMem(DragBuf, DragSize);
      FModify := True;
    end else FLength := 0;
    Invalidate;
  end;
  FDragg := False;
  SendMessage(Application.MainForm.Handle, WM_CHILDACTIVATE, 0, 0);
end;

procedure THexDump.SetCursorPos(Value: Integer);
var
  R: TRect;
  CurWidth: Integer;
begin
  if FInsert or(FLength <> 0) then CurWidth := 1 else CurWidth := FItemWidth;
  R.Top := ((Value div FBytesPerLine) - FTopLine) * FItemHeight;
  if FModHex then R.Left := 4 +(10 + 3*(Value mod FBytesPerLine))*FItemWidth
  else R.Left := 4 +(11 + 3*FBytesPerLine+(Value mod FBytesPerLine))*FItemWidth;
  if FHByte then PatBlt(Canvas.Handle, R.Left, R.Top, CurWidth, FItemHeight, DSTINVERT)
  else PatBlt(Canvas.Handle, R.Left+FItemWidth, R.Top, CurWidth, FItemHeight, DSTINVERT);
  FStart := Value;
end;



function THexDump.GetCheckSum: Word;
var
  BegSel, FinSel, i: Integer;
begin
  Result := 0;
  if FLength > 0 then BegSel := FStart else BegSel := FStart + FLength;
  if FLength > 0 then FinSel := FStart + FLength else FinSel := FStart;
  if FLength = 0 then begin BegSel := 0; FinSel := FDataSize; end;
  for i := BegSel to FinSel -1 do Result := (Result + Byte(PChar(FAddress)[i]))and $FFFF;
end;

procedure THexDump.InsertBlock(Buffer: pointer; Count: integer; TmpInsert: boolean);
var
  SizeBuf, ByteToMove: Integer;
begin
  if (Buffer <> nil) and (Count <> 0) then begin
    if FLength <> 0 then DeleteBlock;
    ByteToMove := FDataSize - FStart;
    SizeBuf := FDataSize;
    if FInsert or TmpInsert then SizeBuf := FDataSize + Count
    else if (FStart + Count) > FDataSize then SizeBuf := FStart + Count;
    if SizeBuf > FDataSize then begin
      FDataSize := SizeBuf;
      CalcPaintParams;
      ReallocMem(FAddress, FDataSize);
    end;
    if FInsert or TmpInsert then
      MoveMemory(@PChar(FAddress)[FStart+Count], @PChar(FAddress)[FStart], ByteToMove);
    MoveMemory(@PChar(FAddress)[FStart], Buffer, Count);
    FModify := True;
    Invalidate;
    SendMessage(Application.MainForm.Handle, WM_CHILDACTIVATE, 0, 0);
  end;
end;

procedure THexDump.DeleteBlock;
var
  ByteToMove: Integer;
begin
  if FLength = 0 then FLength := 1;
  if FLength > 0 then begin
    ByteToMove := FDataSize - FStart - FLength;
    MoveMemory(@PChar(FAddress)[FStart], @PChar(FAddress)[FStart+FLength], ByteToMove);
  end else begin
    ByteToMove := FDataSize - FStart;
    MoveMemory(@PChar(FAddress)[FStart+FLength], @PChar(FAddress)[FStart], ByteToMove);
    FStart := FStart + FLength;
  end;
  if (FDataSize - Abs(FLength)) < 1 then FDataSize := 1 else FDataSize := FDataSize - Abs(FLength);
  FLength := 0;
  ReallocMem(FAddress, FDataSize);
  CalcPaintParams;
  FModify := True;
  Invalidate;
  SendMessage(Application.MainForm.Handle, WM_CHILDACTIVATE, 0, 0);
end;

procedure THexDump.CopyBlock(Buffer: pointer; Count: integer);
begin
  if (Buffer <> nil) and (Count > 0) then
    if FLength > 0 then MoveMemory(Buffer, @PChar(FAddress)[FStart], Count)
    else MoveMemory(Buffer, @PChar(FAddress)[FStart+FLength], Count);
  SendMessage(Application.MainForm.Handle, WM_CHILDACTIVATE, 0, 0);
end;

procedure THexDump.FillBlock(Value: Integer);
begin
  if FLength <> 0 then begin
    if FLength > 0 then FillMemory(@PChar(FAddress)[FStart], Abs(FLength), Value)
    else FillMemory(@PChar(FAddress)[FStart+FLength], Abs(FLength),Value);
    FModify := True;
    Invalidate;
    SendMessage(Application.MainForm.Handle, WM_CHILDACTIVATE, 0, 0);
  end;
end;

procedure THexDump.MaskBlock(Value, Mask: Integer);
var
  BegSel, FinSel, I: Integer;
begin
  if FLength <> 0 then begin
    if FLength > 0 then BegSel := FStart else BegSel := FStart + FLength;
    if FLength > 0 then FinSel := FStart + FLength else FinSel := FStart;
    for i := BegSel to FinSel -1 do
    case Mask of
      0: PChar(FAddress)[I] := Chr(Byte(PChar(FAddress)[I]) and Value);
      1: PChar(FAddress)[I] := Chr(Byte(PChar(FAddress)[I]) or Value);
      2: PChar(FAddress)[I] := Chr(Byte(PChar(FAddress)[I]) xor Value);
      3: PChar(FAddress)[I] := Chr(not Byte(PChar(FAddress)[I]));
      4: PChar(FAddress)[I] := Chr(not Byte(PChar(FAddress)[I]) and Value);
      5: PChar(FAddress)[I] := Chr(not Byte(PChar(FAddress)[I]) or Value);
      6: PChar(FAddress)[I] := Chr(not Byte(PChar(FAddress)[I]) xor Value);
    end;
    FModify := True;
    Invalidate;
    SendMessage(Application.MainForm.Handle, WM_CHILDACTIVATE, 0, 0);
  end;
end;

procedure THexDump.FindBlock(FindBuf, ReplBuf: PChar; Next: Boolean; Mode: integer);
var
  BegSel, I, K, Count, RCount: Integer;
begin
  Count := Length(FindBuF);
  RCount := 0;
  if Next then BegSel := FStart + 1 else BegSel := 0;
  if Count > 0 then begin
    I := BegSel;
    repeat
      if Byte(PChar(FAddress)[I]) = Byte(FindBuf[0]) then begin
        K := 0;
        while Byte(PChar(FAddress)[I+K])= Byte(FindBuf[K]) do begin
          Inc(K);
          if K = Count then begin
            FStart := I;
            FLength := Count;
            SetTopLine(FStart div FBytesPerLine - 2);
            case Mode of
              0: begin Invalidate; Exit; end;
              1: begin InsertBlock(ReplBuf, Length(ReplBuf), True); FLength := Length(ReplBuf); Exit end;
              2: begin InsertBlock(ReplBuf, Length(ReplBuf), True); Inc(RCount); end;
            end;
          end;
        end;
      end;
      Inc(I);
    until I >= FDataSize;
    if (Mode=2)and(RCount >0) then ShowMessage('Поиск завершен. Произведено '+IntToStr(RCount)+' замен.')
    else ShowMessage('Поиск завершен. Данные не найдены.');
  end;
  SendMessage(Application.MainForm.Handle, WM_CHILDACTIVATE, 0, 0);
end;

end.
