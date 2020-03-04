unit T_SelDlg;

{$MODE Delphi}

interface

uses LCLIntf, LCLType, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, MaskEdit;

type
  TSelectDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    RadioGroup1: TRadioGroup;
    MaskEditFinal: TMaskEdit;
    MaskEditBegin: TMaskEdit;
    procedure MaskEditKeyPress(Sender: TObject; var Key: Char);
    procedure MaskEditClick(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SelectDlg: TSelectDlg;

implementation

{$R *.lfm}

procedure TSelectDlg.MaskEditKeyPress(Sender: TObject; var Key: Char);
begin
  Key := UpCase(Key);
  if not (Key in ['0'..'9', 'A'..'F', ^H]) then Key := #0;
  RadioGroup1.ItemIndex := 3;
end;

procedure TSelectDlg.MaskEditClick(Sender: TObject);
begin
  RadioGroup1.ItemIndex := 3;
end;

procedure TSelectDlg.RadioGroup1Click(Sender: TObject);
begin
  if RadioGroup1.ItemIndex <> 3 then
  begin
    MaskEditBegin.Text := '';
    MaskEditFinal.Text := '';
  end;
end;

procedure TSelectDlg.OKBtnClick(Sender: TObject);
begin
  case RadioGroup1.ItemIndex of
    0: SelectDlg.ModalResult := mrAll;
    1: SelectDlg.ModalResult := mrYes;
    2: SelectDlg.ModalResult := mrNo;
    3: SelectDlg.ModalResult := mrOk;
  end;
  SelectDlg.Hide;
end;

end.
