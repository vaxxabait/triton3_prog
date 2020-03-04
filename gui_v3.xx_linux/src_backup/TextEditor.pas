unit TextEditor;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Menus, ExtCtrls;

type
  TTextEdit = class(TForm)
    Panel1: TPanel;
    MainMenu1: TMainMenu;
    EditMenu: TMenuItem;
    EditFindItem: TMenuItem;
    EditNextFindItem: TMenuItem;
    N1: TMenuItem;
    EditFont: TMenuItem;
    FontDialog: TFontDialog;
    PrintDialog1: TPrintDialog;
    RichEdit: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditFontClick(Sender: TObject);
    procedure EditFindItemClick(Sender: TObject);
    procedure EditNextFindItemClick(Sender: TObject);
    procedure RichEditPrintFile(Sender: TObject);
  private
    PathName: string;
  public
    procedure Open(const AFileName: string);
  end;

var
  TextEdit: TTextEdit;
  FindTxt: string;

implementation

uses T_Find;

{$R *.lfm}


procedure TTextEdit.Open(const AFileName: string);
begin
  PathName := AFileName;
  Caption := PathName;
  RichEdit.Lines.LoadFromFile(PathName);
end;

procedure TTextEdit.FormCreate(Sender: TObject);
begin
  PathName := 'NewFile.tmp';
  Caption := PathName;
end;

procedure TTextEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TTextEdit.EditFontClick(Sender: TObject);
begin
  if FontDialog.Execute then RichEdit.Font := FontDialog.Font;
end;

procedure TTextEdit.EditFindItemClick(Sender: TObject);
begin
  if not Assigned(FindRepDlg) then FindRepDlg := TFindRepDlg.Create(Self);
  FindRepDlg.AsciiHex.ItemIndex := 1;
  FindRepDlg.AsciiHex.Enabled := False;
  FindRepDlg.ReplaceText.Text := '';
  FindRepDlg.ReplaceText.Enabled := False;
  FindRepDlg.ShowModal;
  if FindRepDlg.ModalResult = mrCancel then Exit;
  FindTxt := UpperCase(FindRepDlg.FindText.Text);
  if not FindRepDlg.FindStart.Checked then RichEdit.SelStart := 0;
  with RichEdit do
  begin
    SelStart := FindText(FindTxt, SelStart+1, Length(Text)-SelStart, []);
    if SelStart = Length(Text) then ShowMessage('Поиск завершен. Строка не найдена!')
    else SelLength := Length(FindTxt);
  end;
end;

procedure TTextEdit.EditNextFindItemClick(Sender: TObject);
begin
  if FindTxt = '' then EditFindItemClick(Sender)
  else
  with RichEdit do
  begin
    SelStart := FindText(FindTxt, SelStart +1, Length(Text)-SelStart, []);
    if SelStart = Length(Text) then ShowMessage('Поиск завершен. Строка не найдена!')
    else SelLength := Length(FindTxt);
  end;
end;

procedure TTextEdit.RichEditPrintFile(Sender: TObject);
begin
  PrintDialog1.MinPage := 1;
  PrintDialog1.FromPage := 1;
  PrintDialog1.MaxPage := (RichEdit.Lines.Count div 64) + 1;
  PrintDialog1.ToPage := PrintDialog1.MaxPage;
  if RichEdit.SelLength > 0 then PrintDialog1.PrintRange := prSelection;
  PrintDialog1.Execute;
  if PrintDialog1.Execute then RichEdit.Print(PathName);
end;

end.
