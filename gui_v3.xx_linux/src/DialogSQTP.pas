unit DialogSQTP;

{$MODE Delphi}

interface

uses LCLIntf, LCLType, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, MaskEdit;

type
  TSQTPNumbDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Label1: TLabel;
    SQTPNumb: TMaskEdit;
    cbAutoIncr: TCheckBox;
    cbSqtpEn: TCheckBox;
    procedure SQTPNumbKeyPress(Sender: TObject; var Key: Char);
    procedure SQTPNumbEnter(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SQTPNumbDlg: TSQTPNumbDlg;

implementation

{$R *.lfm}


procedure TSQTPNumbDlg.SQTPNumbKeyPress(Sender: TObject;
  var Key: Char);
begin
  Key := UpCase(Key);
  if not (Key in ['0'..'9', 'A'..'F', ^H]) then Key := #0;
end;

procedure TSQTPNumbDlg.SQTPNumbEnter(Sender: TObject);
begin
  SQTPNumb.SelectAll;
end;

procedure TSQTPNumbDlg.FormActivate(Sender: TObject);
begin
  SQTPNumb.SetFocus;
end;

end.
