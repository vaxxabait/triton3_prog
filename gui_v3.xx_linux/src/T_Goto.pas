unit T_Goto;

{$MODE Delphi}

interface

uses LCLIntf, LCLType, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TGotoDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Label1: TLabel;
    GotoText: TEdit;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure GotoTextChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GotoDlg: TGotoDlg;

implementation

{$R *.lfm}

procedure TGotoDlg.FormKeyPress(Sender: TObject; var Key: Char);
begin
  Key := UpCase(Key);
  if not (Key in ['0'..'9', 'A'..'F', ^H]) then Key := #0;
end;

procedure TGotoDlg.FormActivate(Sender: TObject);
begin
  OkBtn.Enabled := Length(GotoText.Text) > 0;
  GotoText.SetFocus;
  GotoText.SelectAll;
end;

procedure TGotoDlg.GotoTextChange(Sender: TObject);
begin
  OkBtn.Enabled := Length(GotoText.Text) > 0;
end;

end.
