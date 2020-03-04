unit HEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls, ExtCtrls, StdCtrls, HexDump;

const
  MAXDIGITS = 16;

type
  TMyArray = array[0..0] of byte;

  THexEdit = class(TForm)
    FontDialog: TFontDialog;
    PrintDialog1: TPrintDialog;
    MainMenu1: TMainMenu;
    EditMenu: TMenuItem;
    EditUndoItem: TMenuItem;
    N7: TMenuItem;
    EditDelItem: TMenuItem;
    EditCutItem: TMenuItem;
    EditCopyItem: TMenuItem;
    EditPasteItem: TMenuItem;
    EditSelectItem: TMenuItem;
    EditFuncItem: TMenuItem;
    N8: TMenuItem;
    EditFindItem: TMenuItem;
    EditNextFindItem: TMenuItem;
    EditNextReplaceItem: TMenuItem;
    N9: TMenuItem;
    EditGotoItem: TMenuItem;
    N1: TMenuItem;
    EditFont: TMenuItem;
    N2: TMenuItem;
    PopupMenu1: TPopupMenu;
    PopGoto: TMenuItem;
    N10: TMenuItem;
    PopFind: TMenuItem;
    N14: TMenuItem;
    PopSel: TMenuItem;
    N16: TMenuItem;
    PopPaste: TMenuItem;
    PopCopy: TMenuItem;
    PopCut: TMenuItem;
    PopDel: TMenuItem;
    N22: TMenuItem;
    PopUndo: TMenuItem;
    Panel1: TPanel;
    function GetModify: Boolean;
    procedure SetModify(Value: boolean);
    procedure SetDataForm(Value: Integer);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditorPrintFile(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure EditMenuClick(Sender: TObject);
    procedure EditUndoItemClick(Sender: TObject);
    procedure EditDelItemClick(Sender: TObject);
    procedure EditCutItemClick(Sender: TObject);
    procedure EditCopyItemClick(Sender: TObject);
    procedure EditPasteItemClick(Sender: TObject);
    procedure EditFuncItemClick(Sender: TObject);
    procedure EditSelectItemClick(Sender: TObject);
    procedure EditFindItemClick(Sender: TObject);
    procedure EditNextFindItemClick(Sender: TObject);
    procedure EditNextReplaceItemClick(Sender: TObject);
    procedure EditGotoItemClick(Sender: TObject);
    procedure EditFontClick(Sender: TObject);
  private
    HexDump: THexDump;
    FName: file;
    PathName: string;
    pMainBuf: ^TMyArray;
    SizeMainBuf: Integer;
  public
    property Modified: Boolean read GetModify write SetModify;
    property DataForm: Integer write SetDataForm;
    procedure Open(const AFileName: string);
    procedure Save(const AFileName: string);
    procedure SaveTmp(const AFileName: string);
    function DumpCheckSum: string;
    function DumpGetAddress(BegAdr: Integer): pointer;
    function DumpGetAllSize: integer;
    function DumpGetSelStart: integer;
    function DumpGetSelLength: integer;
    function BaseStrToInt(const S: string): Longint;
    function IntToBaseStr(Value: Longint): string;
  end;

  function ConvertString(SourceStr: string):string ;

var
  HexEdit: THexEdit;
  pWorkBuf: ^TMyArray;
  SizeWorkBuf: Integer = 0;
  FindData: string;
  ReplData: string;

implementation

uses T_SelDlg, T_Find, T_Goto, T_Func;

{$R *.DFM}


procedure THexEdit.Open(const AFileName: string);
var
  NumRd: integer;
begin
  AssignFile(FName, AFileName);
  Reset(FName, 1);
  SizeMainBuf := FileSize(FName);
  if SizeMainBuf > 0 then begin
    ReallocMem(pMainBuf, SizeMainBuf);
    if pMainBuf <> nil then BlockRead(FName, pMainBuf^, SizeMainBuf, NumRd);
    if SizeMainBuf <> NumRd then begin
      SizeMainBuf := NumRd;
      ReallocMem(pMainBuf, SizeMainBuf);
    end;
  end;
  CloseFile(FName);
  PathName := AFileName;
  Caption := PathName;
  HexDump.Address := pMainBuf;
  HexDump.DataSize := SizeMainBuf;
end;

procedure THexEdit.Save(const AFileName: string);
begin
  if (AFileName <> PathName) and (AFileName <> '') then PathName := AFileName;
  Caption := PathName;
  SaveTmp(PathName);
  Modified := False;
end;

procedure THexEdit.SaveTmp(const AFileName: string);
var
  NumRd: DWord;
begin
  AssignFile(FName, AFileName);
  Rewrite(FName, 1);
  pMainBuf := HexDump.Address;
  SizeMainBuf := HexDump.DataSize;
  if (pMainBuf <>nil)and(SizeMainBuf >0) then BlockWrite(FName, pMainBuf^, SizeMainBuf, NumRd);
  CloseFile(FName);
end;

function THexEdit.DumpCheckSum: string;
begin
  Result := IntToHex(HexDump.GetCheckSum, 4);
end;

function THexEdit.DumpGetAddress(BegAdr: Integer): pointer;
begin
  if BegAdr < 1 then BegAdr := 0
  else if BegAdr >(HexDump.DataSize -1) then BegAdr := HexDump.DataSize -1;
  Result := @PChar(HexDump.Address)[BegAdr];
end;

function THexEdit.DumpGetAllSize: integer;
begin
  Result := HexDump.DataSize;
end;

function THexEdit.GetModify: Boolean;
begin
  Result := HexDump.FModify;
end;

procedure THexEdit.SetModify(Value: boolean);
begin
  HexDump.FModify := Value;
end;

function THexEdit.DumpGetSelStart: integer;
begin
  Result := HexDump.SelStart;
end;

function THexEdit.DumpGetSelLength: integer;
begin
  Result := HexDump.SelLength;
end;

procedure THexEdit.SetDataForm(Value: integer);
begin
//  HexDump.FormatData := Value;
end;





procedure THexEdit.FormActivate(Sender: TObject);
begin
  HexDump.SetFocus;
  Invalidate;
end;

procedure THexEdit.FormCreate(Sender: TObject);
begin
  PathName := 'NewFile.tmp';
  Caption := PathName;
  HexDump := CreateHexDump(TWinControl(Panel1));
  SizeMainBuf := 1;
  ReallocMem(pMainBuf, SizeMainBuf);
  pMainBuf^[0] := $FF;
  HexDump.Address := pMainBuf;
  HexDump.DataSize := SizeMainBuf;
end;

procedure THexEdit.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Modified then
  case MessageDlg(Format('Сохранить изменения в файле %s?', [PathName]), mtConfirmation,
    [mbYes, mbNo, mbCancel], 0) of
    idYes: Save(PathName);
    idNo:  if ExtractFileExt(PathName)= '.TMP' then DeleteFile(PathName);
    idCancel: CanClose := False;
  end;
end;

procedure THexEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  pMainBuf := HexDump.Address;
  ReallocMem(pMainBuf, 0);
  ReallocMem(pWorkBuf, 0);
  Action := caFree;
end;

function THexEdit.BaseStrToInt(const S: string): Longint;
//function BaseStrToInt(const S: string; Base: integer{2,8,10,16}): Longint;
var
  Digit, I: Byte;
begin
  Result := 0;
  for I := 1 to Length(S) do begin
    Digit := ord(S[I]) - ord('0');
    if Digit > 10 then Dec(Digit, 7);
    Result := Result * 16 + Digit;   //Result := Result * Base + Digit;
  end;
end;

function THexEdit.IntToBaseStr(Value: Longint): string;
var
  Ch: Char;
begin
  Result := '';
  repeat
    Ch := '0';
    Inc(Ch, Value mod 16);   //Inc(Ch, Value mod Base[NumBase]);
    if Ch > '9' then Inc(Ch, 7);
    Insert(Ch, Result, 1);
    Value := Value div 16;   //Value :=Value div Base[NumBase];
  until Value = 0;
end;

procedure THexEdit.PopupMenu1Popup(Sender: TObject);
begin
  PopUndo.Enabled := False;
  PopCut.Enabled := HexDump.SelLength <> 0;
  PopCopy.Enabled := HexDump.SelLength <> 0;
  PopPaste.Enabled := pWorkBuf <> nil;
end;

procedure THexEdit.EditMenuClick(Sender: TObject);
begin
  EditCutItem.Enabled := HexDump.SelLength <> 0;
  EditCopyItem.Enabled := HexDump.SelLength <> 0;
  EditPasteItem.Enabled := pWorkBuf <> nil;
end;

procedure THexEdit.EditUndoItemClick(Sender: TObject);
begin
//  Undo;
end;

procedure THexEdit.EditDelItemClick(Sender: TObject);
begin
  HexDump.DeleteBlock;
end;

procedure THexEdit.EditCutItemClick(Sender: TObject);
begin
  EditCopyItemClick(Sender);
  HexDump.DeleteBlock;
end;

procedure THexEdit.EditCopyItemClick(Sender: TObject);
begin
  SizeWorkBuf := Abs(HexDump.SelLength);
  ReallocMem(pWorkBuf, SizeWorkBuf);
  HexDump.CopyBlock(pWorkBuf, SizeWorkBuf);
end;

procedure THexEdit.EditPasteItemClick(Sender: TObject);
begin
  HexDump.InsertBlock(pWorkBuf, SizeWorkBuf, False);
end;

procedure THexEdit.EditFuncItemClick(Sender: TObject);
var
  BegAdr, FinAdr: integer;
  WorkByte: byte;
begin
  if not Assigned(FunctionDlg) then FunctionDlg := TFunctionDlg.Create(Self);
  with FunctionDlg do begin
    MaskEditBegin.Text := '';
    MaskEditFinal.Text := '';
    if HexDump.SelLength > 0 then begin
      MaskEditBegin.Text := IntToHex(HexDump.SelStart, 6);
      MaskEditFinal.Text := IntToHex(HexDump.SelStart+HexDump.SelLength -1, 6);
    end;
    if HexDump.SelLength < 0 then begin
      MaskEditBegin.Text := IntToHex(HexDump.SelStart+HexDump.SelLength, 6);
      MaskEditFinal.Text := IntToHex(HexDump.SelStart -1, 6);
    end;
    if ShowModal = mrCancel then Exit;
    WorkByte := BaseStrToInt(MaskEditMask.Text);
    BegAdr := BaseStrToInt(MaskEditBegin.Text);
    FinAdr := BaseStrToInt(MaskEditFinal.Text);
    if BegAdr < FinAdr then HexDump.SelStart := BegAdr
    else HexDump.SelStart := FinAdr;
    if BegAdr < FinAdr then HexDump.SelLength := FinAdr - BegAdr + 1
    else HexDump.SelLength := BegAdr - FinAdr + 1;
    if ModalResult = 107 then HexDump.FillBlock(WorkByte)
    else HexDump.MaskBlock(WorkByte, ModalResult-100);
  end;
end;

procedure THexEdit.EditSelectItemClick(Sender: TObject);
var
  BegAdr, FinAdr: integer;
begin
  if not Assigned(SelectDlg) then SelectDlg := TSelectDlg.Create(Self);
  SelectDlg.RadioGroup1.Items[0] :='Весь ф&айл  ( 0...'+IntToHex(HexDump.DataSize-1, 6)+' )';
  with HexDump do
  case SelectDlg.ShowModal of
    mrAll: begin
             SelStart := 0;
             SelLength := DataSize;
           end;
    mrYes: begin
             SelStart := 0;
             SelLength := DataSize div 2;
           end;
    mrNo:  begin
             SelStart := DataSize div 2;
             SelLength := DataSize - (DataSize div 2);
           end;
    mrOk:  begin
             BegAdr := BaseStrToInt(SelectDlg.MaskEditBegin.Text);
             FinAdr := BaseStrToInt(SelectDlg.MaskEditFinal.Text);
             if BegAdr < FinAdr then SelStart := BegAdr
             else SelStart := FinAdr;
             if BegAdr < FinAdr then SelLength := FinAdr - BegAdr + 1
             else SelLength := BegAdr - FinAdr + 1;
           end;
  end;
end;

function ConvertString(SourceStr: string):string ;
var
  S: string;
  Digit, I: byte;
begin
  Result := '';
  S := UpperCase(SourceStr);
  I := 1;
  if Length(S) > 0 then
  repeat
    Digit := ord(S[I]) - ord('0');
    if Digit > 10 then Dec(Digit, 7);
    Result := Result + Chr(Digit);
    Inc(I);
    Digit := ord(S[I]) - ord('0');
    if Digit > 10 then Dec(Digit, 7);
    Result[(I+1) div 2] := Chr(Byte(Result[(I+1) div 2]) * 16 + Digit);
    Inc(I);
{    Result[(I+2) div 3] := Chr(Byte(Result[(I+2) div 3]) * 16 + Digit);
    Inc(I, 2);}
  until I >= Length(S);
end;

procedure THexEdit.EditFindItemClick(Sender: TObject);
begin
  if not Assigned(FindRepDlg) then FindRepDlg := TFindRepDlg.Create(Self);
  if HexDump.FModHex then FindRepDlg.AsciiHex.ItemIndex := 1
  else FindRepDlg.AsciiHex.ItemIndex := 0;
  FindRepDlg.AsciiHex.Enabled := True;
  FindRepDlg.ReplaceText.Enabled := True;
  FindRepDlg.ShowModal;
  if FindRepDlg.ModalResult = mrCancel then Exit;
  HexDump.FModHex := FindRepDlg.AsciiHex.ItemIndex = 1;
  if FindRepDlg.AsciiHex.ItemIndex = 0 then
    if FindRepDlg.Matchcase.Checked then FindData := FindRepDlg.FindText.Text
    else FindData := UpperCase(FindRepDlg.FindText.Text)
  else FindData := ConvertString(FindRepDlg.FindText.Text);
  if FindRepDlg.AsciiHex.ItemIndex = 0 then ReplData := FindRepDlg.ReplaceText.Text
  else ReplData := ConvertString(FindRepDlg.ReplaceText.Text);
  case FindRepDlg.ModalResult of
    mrOk:  HexDump.FindBlock(PChar(FindData), nil, FindRepDlg.FindStart.Checked, 0);
    mrYes: HexDump.FindBlock(PChar(FindData), PChar(ReplData), FindRepDlg.FindStart.Checked, 1);
    mrYesToAll: HexDump.FindBlock(PChar(FindData), PChar(ReplData), FindRepDlg.FindStart.Checked, 2);
  end;
end;

procedure THexEdit.EditNextFindItemClick(Sender: TObject);
begin
  if FindData = '' then EditFindItemClick(Sender)
  else HexDump.FindBlock(PChar(FindData), nil, True, 0);
end;

procedure THexEdit.EditNextReplaceItemClick(Sender: TObject);
begin
  if ReplData = '' then EditFindItemClick(Sender)
  else HexDump.FindBlock(PChar(FindData), PChar(ReplData), True, 1);
end;

procedure THexEdit.EditGotoItemClick(Sender: TObject);
begin
  if not Assigned(GotoDlg) then GotoDlg := TGotoDlg.Create(Self);
  if GotoDlg.ShowModal = mrOK then begin
    HexDump.SelStart := BaseStrToInt(GotoDlg.GotoText.Text);;
    HexDump.SelLength := 0;
  end;
end;

procedure THexEdit.EditFontClick(Sender: TObject);
begin
  if FontDialog.Execute then HexDump.Font := FontDialog.Font;
end;

procedure THexEdit.EditorPrintFile(Sender: TObject);
begin
{  PrintDialog1.MinPage := 1;
  PrintDialog1.FromPage := 1;
  PrintDialog1.MaxPage := (Editor.LineCount div 64) + 1;
  PrintDialog1.ToPage := PrintDialog1.MaxPage;
  if Editor.SelLength > 0 then PrintDialog1.PrintRange := prSelection;
  PrintDialog1.Execute;
  if PrintDialog1.Execute then Editor.Print(PathName);
}
end;

end.
