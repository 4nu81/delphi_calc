unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  THelp = class(TForm)
    HelpPanel: TPanel;
    Lblhelp: TLabel;
    Lbl: TLabel;
    Btnhelpexit: TButton;
    procedure BtnhelpexitClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Help: THelp;

implementation

{$R *.dfm}

procedure THelp.BtnhelpexitClick(Sender: TObject);
begin
  self.hide;
end;

end.
