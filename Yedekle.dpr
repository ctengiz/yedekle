program Yedekle;

uses
  Forms,
  unAna in 'unAna.pas' {fmAna},
  unHakkinda in 'unHakkinda.pas' {fmHakkinda};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Yedekle';
  Application.ShowMainForm := False;
  Application.CreateForm(TfmAna, fmAna);
  Application.Run;
end.
