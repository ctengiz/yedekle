unit unHakkinda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TfmHakkinda = class(TForm)
    lblBaslik: TLabel;
    Memo1: TMemo;
    Panel1: TPanel;
    btnTamam: TButton;
    lblUrl: TLabel;
    procedure btnTamamClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lblUrlClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmHakkinda: TfmHakkinda;

implementation

{$R *.dfm}
uses
  FileInformation
  , ShellApi;

procedure TfmHakkinda.btnTamamClick(Sender: TObject);
begin
  Close;
end;

procedure TfmHakkinda.FormCreate(Sender: TObject);
begin
  lblBaslik.Caption := 'Yedekle '
                       + GetFileInformation(Application.ExeName, 'FileVersion')
                       + chr(13)
                       + '(c) 2004 - Çaðatay Tengiz'
                       + chr(13)
                       + 'GPL lisansý ile daðýtýlmaktadýr'
end;

procedure TfmHakkinda.lblUrlClick(Sender: TObject);
begin
  //ShellExecute(Handle, 'open', nil, PChar( lblUrl.Caption ), nil, SW_SHOWNORMAL);
  //ShellExecute(Handle, 'explore', PChar(lblUrl.Caption), nil, nil, SW_SHOWNORMAL);
  ShellExecute(Handle, 'open', PChar(lblUrl.Caption), nil, nil, SW_SHOWNORMAL);
end;

end.
