program Project6;

uses
  ExceptionLog,
  Forms,
  Graph in 'Graph.pas',
  termunit in 'termunit.pas',
  TransString in 'TransString.pas',
  Unit2 in 'Unit2.pas' {Help},
  Unit7 in 'Unit7.pas' {Form7};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm7, Form7);
  Application.CreateForm(THelp, Help);
  Application.Run;
end.
