unit AboutBox;

{$MODE Delphi}

interface

uses LCLIntf, LCLType, Forms, Buttons, Classes, Controls, StdCtrls, ExtCtrls,
  Graphics;

type
  TAboutBox1 = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    ProductName1: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    Comments: TLabel;
    OKButton: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure Label2Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox1: TAboutBox1;

implementation


{$R *.lfm}

procedure TAboutBox1.Label2Click(Sender: TObject);
begin
  OpenURL('http://www.trt.ru'); { *Converted from ShellExecute*  }
end;

procedure TAboutBox1.Label4Click(Sender: TObject);
begin
   OpenDocument('mailto:petrov@trt.ru'); { *Converted from ShellExecute*  }
end;


end.

