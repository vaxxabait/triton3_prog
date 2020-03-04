unit DialogError;

{$MODE Delphi}

interface

uses LCLIntf, LCLType, Classes, Forms, Controls, StdCtrls, SysUtils,
  Buttons, ExtCtrls;


type
  TDialogError1 = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    RetryBtn: TButton;
    AbortBtn: TButton;
    IgnoreBtn: TButton;
    Label1: TLabel;
    lbChipName: TLabel;
    ErrorType: TLabel;
    Error: TLabel;
    ErrorText: TLabel;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DialogError1: TDialogError1;

implementation

uses Triton_Main1, DialogProcess;

{$R *.lfm}


procedure TDialogError1.FormActivate(Sender: TObject);
var
  dwSent: DWord;
begin
  Caption := DialogProcess1.Caption;
  lbChipName.Caption := DialogProcess1.lbChipName.Caption;
  ErrorText.Caption := '';
  if CodCommand in [5, 6, 7] then
  begin
    RetryBtn.Caption := 'Повторить';
    IgnoreBtn.Caption := 'Пропустить';
  end
  else
  begin
    RetryBtn.Caption := 'Пропустить';
    IgnoreBtn.Caption := 'Пропустить все';
  end;
  case CodCommand of
    4: ErrorType.Caption := 'Микросхема не стирается!';
    5: ErrorType.Caption := 'Ошибка записи!';
    7: ErrorType.Caption := 'Ошибка записи микросхемы!';
    8: ErrorType.Caption := 'Микросхема не чистая!';
    10: ErrorType.Caption := 'Чтение микросхемы';
    11: ErrorType.Caption := 'Ошибка сравнения';
  end;
  if ModeError8 then
  begin
    dwSent := FileRead(FPort, BlokPar, 5);
    Error.Caption := 'Ошибка по адресу:  ';
    Error.Caption := Error.Caption + IntToHex(BlokPar[0]*65536+BlokPar[1]*256+BlokPar[2], 6);
    Error.Caption := Error.Caption + '  ';
    Error.Caption := Error.Caption + IntToHex(BlokPar[3], 2);
    Error.Caption := Error.Caption + '  ';
    Error.Caption := Error.Caption + IntToHex(BlokPar[4], 2);
    if (BlokPar[3] and BlokPar[4])<>BlokPar[4] then
      ErrorText.Caption := 'Дальнейшая запись не возможна.';
  end
  else
  begin
    dwSent := FileRead(FPort, BlokPar, 7);
    Error.Caption := 'Ошибка по адресу:  ';
    Error.Caption := Error.Caption + IntToHex(BlokPar[0]*65536+BlokPar[1]*256+BlokPar[2], 6);
    Error.Caption := Error.Caption + '  ';
    Error.Caption := Error.Caption + IntToHex(BlokPar[3]*256+BlokPar[4], 4);
    Error.Caption := Error.Caption + '  ';
    Error.Caption := Error.Caption + IntToHex(BlokPar[5]*256+BlokPar[6], 4);
    if ((BlokPar[3] and BlokPar[5])<>BlokPar[5]) or ((BlokPar[4] and BlokPar[6])<>BlokPar[6]) then
      ErrorText.Caption := 'Дальнейшая запись не возможна.';
  end;
end;

end.
