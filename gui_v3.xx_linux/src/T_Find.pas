unit T_Find;

{$MODE Delphi}

interface

uses LCLIntf, LCLType, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TFindRepDlg = class(TForm)
    FindButton: TButton;
    CancelButton: TButton;
    Label1: TLabel;
    Label2: TLabel;
    FindText: TEdit;
    ReplaceText: TEdit;
    ReplaceButton: TButton;
    ReplaceAllButton: TButton;
    AsciiHex: TRadioGroup;
    GroupBox1: TGroupBox;
    FindStart: TCheckBox;
    Matchcase: TCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure FindTextChange(Sender: TObject);
    procedure ReplaceTextChange(Sender: TObject);
    procedure FindTextKeyPress(Sender: TObject; var Key: Char);
    procedure AsciiHexClick(Sender: TObject);
    procedure FindTextEnter(Sender: TObject);
    procedure ReplaceTextEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FindRepDlg: TFindRepDlg;

implementation

{$R *.lfm}

procedure TFindRepDlg.FormActivate(Sender: TObject);
begin
  FindButton.Enabled := Length(FindText.Text) > 0;
  ReplaceButton.Enabled :=(Length(ReplaceText.Text)>0)and(Length(FindText.Text)>0);
  ReplaceAllButton.Enabled := ReplaceButton.Enabled;
  Matchcase.Enabled := AsciiHex.ItemIndex = 0;
  FindText.SetFocus;
end;

procedure TFindRepDlg.FindTextChange(Sender: TObject);
begin
  FindButton.Enabled := Length(FindText.Text) > 0;
{  if (AsciiHex.ItemIndex = 1) and ((Length(FindText.Text)+1) mod 3 = 0) then
  begin
    FindText.Text := FindText.Text + ' ';
    FindText.SelStart := Length(FindText.Text);
  end;}
end;

procedure TFindRepDlg.ReplaceTextChange(Sender: TObject);
begin
  ReplaceButton.Enabled :=(Length(ReplaceText.Text)>0)and(Length(FindText.Text)>0);
  ReplaceAllButton.Enabled := ReplaceButton.Enabled;
{  if (AsciiHex.ItemIndex = 1) and ((Length(ReplaceText.Text)+1) mod 3 = 0) then
  begin
    ReplaceText.Text := ReplaceText.Text + ' ';
    ReplaceText.SelStart := Length(ReplaceText.Text);
  end;}
end;

procedure TFindRepDlg.FindTextKeyPress(Sender: TObject; var Key: Char);
begin
  if AsciiHex.ItemIndex = 1 then
  begin
    Key := UpCase(Key);
    if not (Key in ['0'..'9', 'A'..'F', ^H]) then Key := #0;
  end;
end;

procedure TFindRepDlg.AsciiHexClick(Sender: TObject);
begin
  Matchcase.Enabled := AsciiHex.ItemIndex = 0;
end;

procedure TFindRepDlg.FindTextEnter(Sender: TObject);
begin
  FindText.SelectAll;
end;

procedure TFindRepDlg.ReplaceTextEnter(Sender: TObject);
begin
  ReplaceText.SelectAll;
end;

end.
