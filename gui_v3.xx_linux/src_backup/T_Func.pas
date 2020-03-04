unit T_Func;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Mask;

type
  TFunctionDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    RadioGroup1: TRadioGroup;
    MaskEditFinal: TMaskEdit;
    MaskEditBegin: TMaskEdit;
    Label1: TLabel;
    Label2: TLabel;
    MaskEditMask: TMaskEdit;
    procedure MaskEditKeyPress(Sender: TObject; var Key: Char);
    procedure RadioGroup1Click(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FunctionDlg: TFunctionDlg;

implementation

{$R *.DFM}

procedure TFunctionDlg.MaskEditKeyPress(Sender: TObject; var Key: Char);
begin
  Key := UpCase(Key);
  if not (Key in ['0'..'9', 'A'..'F', ^H]) then Key := #0;
end;

procedure TFunctionDlg.RadioGroup1Click(Sender: TObject);
begin
  MaskEditMask.Enabled := not(RadioGroup1.ItemIndex = 3);
  Label2.Enabled := MaskEditMask.Enabled;
end;

procedure TFunctionDlg.OKBtnClick(Sender: TObject);
begin
  FunctionDlg.ModalResult := RadioGroup1.ItemIndex + 100;
  FunctionDlg.Hide;
end;

procedure TFunctionDlg.FormActivate(Sender: TObject);
begin
  MaskEditBegin.SetFocus;
  MaskEditBegin.SelectAll;
end;

end.
