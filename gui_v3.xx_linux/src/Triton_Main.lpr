program Triton_Main;

{$MODE Delphi}

uses
  Forms,
  LCLIntf, LCLType, LMessages, Interfaces,
  Triton_Main1 in 'Triton_Main1.pas' {Main1},
  DialogProcess in 'DialogProcess.pas' {DialogProcess1},
  DialogError in 'DialogError.pas' {DialogError1},
  AboutBox in 'AboutBox.pas' {AboutBox1},
  Triton_prog in 'Triton_prog.pas' {Form1},
  HEdit in '..\HexEdit\HEdit.pas' {HexEdit},
  TextEditor in 'TextEditor.pas' {TextEdit},
  DialogSQTP in 'DialogSQTP.pas' {SQTPNumbDlg};

{$R *.res}

var
  hwndOpen: HWND;
begin
  //hwndOpen := FindWindow(nil, 'Программатор ТРИТОН');
  //if hwndOpen <> 0 then SetForegroundWindow(hwndOpen)
  //else
  begin
  Application.Initialize;
  Application.Title := 'Программатор ТРИТОН';
  Application.CreateForm(TMain1, Main1);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDialogProcess1, DialogProcess1);
  Application.CreateForm(TDialogError1, DialogError1);
  Application.Run;
  end;
end.