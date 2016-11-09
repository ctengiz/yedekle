{

http://www.tengiz.net/projeler/yedekle/

Sürüm geçmiþi

0.0.2 : 02.08.07 - M. Yaþar Onur'un tespit ettiði hata ve çözümü uygulandý
0.0.1 : 15.12.04 - Ýlk sürüm

}

unit unAna;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ShellCtrls, Grids, ValEdit, ExtCtrls,
  CheckLst, Mask, AppEvnts,

  ShellApi, Menus, DosCommand;

const
 WM_ICONTRAY = WM_USER + 1;  

type
  TfmAna = class(TForm)
    pgcAna: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    vleSecim: TValueListEditor;
    Splitter1: TSplitter;
    Panel1: TPanel;
    stvAna: TShellTreeView;
    Panel2: TPanel;
    btnCikar: TButton;
    btnEkle: TButton;
    Panel3: TPanel;
    ckbDosyaGoster: TCheckBox;
    pnlAlt: TPanel;
    btnSimdiYedekle: TButton;
    btnAyarlariKaydet: TButton;
    GroupBox1: TGroupBox;
    pnlGunluk: TPanel;
    edtYedekZamani: TMaskEdit;
    Label1: TLabel;
    cklGun: TCheckListBox;
    GroupBox2: TGroupBox;
    edtSunucu: TLabeledEdit;
    edtKullaniciAdi: TLabeledEdit;
    edtYedeklemeDizin: TLabeledEdit;
    edtKullaniciSifre: TLabeledEdit;
    edtRsyncParametre: TLabeledEdit;
    timerYedekle: TTimer;
    Memo1: TMemo;
    appEvent: TApplicationEvents;
    pmAna: TPopupMenu;
    Gster1: TMenuItem;
    Gizle1: TMenuItem;
    N5: TMenuItem;
    k1: TMenuItem;
    cmdAna: TDosCommand;
    pnlGunici: TPanel;
    cmbSureTip: TComboBox;
    edtSure: TMaskEdit;
    Panel5: TPanel;
    cmbZamanlamaTipi: TComboBox;
    TabSheet4: TTabSheet;
    btnHakkinda: TButton;
    btnCikis: TButton;
    cmdYedekListe: TDosCommand;
    trvListe: TTreeView;
    GroupBox3: TGroupBox;
    btnGuncelle: TButton;
    btnYedektenYukle: TButton;
    edtYuklePar: TLabeledEdit;
    procedure ckbDosyaGosterClick(Sender: TObject);
    procedure btnEkleClick(Sender: TObject);
    procedure btnCikarClick(Sender: TObject);
    procedure cmbZamanlamaTipiChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSimdiYedekleClick(Sender: TObject);
    procedure btnAyarlariKaydetClick(Sender: TObject);
    procedure timerYedekleTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure appEventMinimize(Sender: TObject);
    procedure Gster1Click(Sender: TObject);
    procedure Gizle1Click(Sender: TObject);
    procedure k1Click(Sender: TObject);
    procedure cmdAnaTerminated(Sender: TObject; ExitCode: Cardinal);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCikisClick(Sender: TObject);
    procedure btnHakkindaClick(Sender: TObject);
    procedure btnGuncelleClick(Sender: TObject);
    procedure cmdYedekListeTerminated(Sender: TObject; ExitCode: Cardinal);
    procedure btnYedektenYukleClick(Sender: TObject);
  private
    { Private declarations }
    TrayIconData: TNotifyIconData;
    AFmtSet : TFormatSettings;
    YedekAliyor : Boolean;
    YedekIcinBekle : Boolean;
    DosyaListe : TStringList;

    procedure Yedekle;
    procedure AyarlariYukle;
    procedure AyarlariKaydet;
    procedure Cik;
    procedure YedekListeHazirla;
  public
    { Public declarations }
    procedure TrayMessage(var Msg: TMessage); message WM_ICONTRAY;
  end;

var
  fmAna: TfmAna;

implementation

{$R *.dfm}

uses
  IniFiles
  , unHakkinda
  , StrUtils;

procedure TfmAna.FormCreate(Sender: TObject);
begin
  pgcAna.ActivePageIndex := 0;

  //Ayarlarý oku
  pnlGunluk.Visible := False;
  pnlGunici.Visible := False;

  pnlGunluk.Align := alClient;
  pnlGunici.Align := alClient;

  pnlGunluk.Visible := True;
  AyarlariYukle;


  {Formu Taskbar'dan Sakla}
  {ShowWindow(Application.Handle, SW_HIDE);
  SetWindowLong(Application.Handle, GWL_EXSTYLE,
    GetWindowLong(Application.Handle, GWL_EXSTYLE)
    or WS_EX_TOOLWINDOW );
  ShowWindow(Application.Handle, SW_SHOW);}

  {Tray Icon Yap}
  with TrayIconData do
  begin
    cbSize := SizeOf(TrayIconData);
    Wnd := Handle;
    uID := 0;
    uFlags := NIF_MESSAGE + NIF_ICON + NIF_TIP;
    uCallbackMessage := WM_ICONTRAY;
    hIcon := Application.Icon.Handle;
    StrPCopy(szTip, Application.Title);
  end;

  Shell_NotifyIcon(NIM_ADD, @TrayIconData);

  //Zaman Karsilastirma Icýn
  GetLocaleFormatSettings(GetUserDefaultLCID, AFmtSet);
  AFmtSet.LongTimeFormat := 'hh:mm';

  YedekAliyor := False;
  YedekIcinBekle := False;

  DosyaListe := TStringList.Create;
end;

procedure TfmAna.TrayMessage(var Msg: TMessage);
var
  p : TPoint;
begin
  case Msg.lParam of
    WM_LBUTTONDOWN: begin
      if fmAna.Visible then
        fmAna.Hide
      else begin
        fmAna.show;
        application.BringToFront;
      end;
    end;
    WM_RBUTTONDOWN: begin
      SetForegroundWindow(Handle);
      GetCursorPos(p);
      pmAna.Popup(p.x, p.y);
      PostMessage(Handle, WM_NULL, 0, 0);
    end;
    WM_LBUTTONDBLCLK: begin
      fmAna.Show;
      application.BringToFront;
    end;
  end;
end;

procedure TfmAna.appEventMinimize(Sender: TObject);
begin
  //application.ShowMainForm := False;
  application.Restore;
  //application.
  Hide;
  appEvent.CancelDispatch;
  //application.Minimize;
end;

procedure TfmAna.FormHide(Sender: TObject);
begin
  {Formu Taskbar'dan Sakla}
  ShowWindow(Application.Handle, SW_HIDE);
  {SetWindowLong(Application.Handle, GWL_EXSTYLE,
    GetWindowLong(Application.Handle, GWL_EXSTYLE)
    or WS_EX_TOOLWINDOW );
  ShowWindow(Application.Handle, SW_SHOW);   }
end;

procedure TfmAna.FormShow(Sender: TObject);
begin
  {Formu Taskbar'da Göster}
  ShowWindow(Application.Handle,SW_SHOW);
  {ShowWindow(Application.Handle, SW_HIDE);
  SetWindowLong(Application.Handle, GWL_EXSTYLE,
    GetWindowLong(Application.Handle, GWL_EXSTYLE));
  ShowWindow(Application.Handle, SW_SHOW);}
end;


procedure TfmAna.Gster1Click(Sender: TObject);
begin
  fmAna.Show;
  Application.BringToFront;
end;

procedure TfmAna.Gizle1Click(Sender: TObject);
begin
  fmAna.Hide;
end;

procedure TfmAna.k1Click(Sender: TObject);
begin
  Cik;
end;

procedure TfmAna.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caNone;
  //Action := caHide;
  Hide;
end;

procedure TfmAna.ckbDosyaGosterClick(Sender: TObject);
begin
  if ckbDosyaGoster.Checked then
    stvAna.ObjectTypes := stvAna.ObjectTypes + [otNonFolders]
  else
    stvAna.ObjectTypes := stvAna.ObjectTypes - [otNonFolders];
end;

procedure TfmAna.btnEkleClick(Sender: TObject);
begin
  vleSecim.InsertRow(StvAna.SelectedFolder.DisplayName, stvAna.SelectedFolder.PathName, True);
end;

procedure TfmAna.btnCikarClick(Sender: TObject);
begin
  vleSecim.DeleteRow(vleSecim.Row);
end;

procedure TfmAna.cmbZamanlamaTipiChange(Sender: TObject);
begin
  pnlGunluk.Visible := False;
  pnlGunIci.Visible := False;
  case cmbZamanlamaTipi.ItemIndex of
    0 : pnlGunluk.Visible := True;
    1 : pnlGunici.Visible := True;
  end;
end;

procedure TfmAna.btnSimdiYedekleClick(Sender: TObject);
begin
  Yedekle;
end;

procedure TfmAna.btnAyarlariKaydetClick(Sender: TObject);
begin
  AyarlariKaydet;
end;

procedure TfmAna.timerYedekleTimer(Sender: TObject);
var
  Gun : Integer;
  Zmn : String;
  Arl : Integer;
  Dak : Integer;
begin
  case cmbZamanlamaTipi.ItemIndex of
    0 : begin //Günlük
      Gun := DayOfWeek(Date);
      //Delphi'ye gore 1-Pazar, 2-Pzts... checklist'e göre : 0-pzts dolayýsýyla bu çevrimi yapalým
      Gun := Gun - 2;
      if Gun = -1 then Gun := 6;
      if cklGun.Checked[Gun] then begin
        //showmessage(TimeToStr(Time, AFmtSet));
        Zmn := TimeToStr(Time, AFmtSet);
        if (Zmn = edtYedekZamani.Text) and (not(YedekAliyor)) then begin
          YedekAliyor := True;
          yedekle;
        end else
          YedekAliyor := False;
      end else
        YedekAliyor := False;
    end;
    1 : begin //Gün içerisinde
      if cmbSureTip.ItemIndex = 0 then
        Arl := 60 //Saatte bir
      else
        Arl := 1; //Dakikada bir

      Arl := Arl * StrToInt(edtSure.Text); //milisecond;
      Dak := DateTimeToTimeStamp(Now).Time div 60000;

      if (Dak mod Arl) = 0 then yedekle;

    end;
  end;
end;

procedure TfmAna.AyarlariKaydet;
var
  ini : TIniFile;
  i : integer;
begin
  Ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.INI'));
  with Ini do begin
    //Dizinleri Yazalým
    EraseSection('DIZIN');

    if vleSecim.RowCount > 1 then
      for i := 1 to vleSecim.RowCount - 1 do
        if vleSecim.Keys[i] <> '' then
          WriteString('DIZIN', vleSecim.Keys[i], vleSecim.Values[vleSecim.Keys[i]]);

    //Sunucu ayarlarý
    WriteString('SUNUCU AYARLARI', 'Sunucu', edtSunucu.Text);
    WriteString('SUNUCU AYARLARI', 'Kullanýcý', edtKullaniciAdi.Text);
    WriteString('SUNUCU AYARLARI', 'Kullanýcý Þifre', edtKullaniciSifre.Text);
    WriteString('SUNUCU AYARLARI', 'Yedekleme Dizin', edtYedeklemeDizin.Text);
    WriteString('SUNUCU AYARLARI', 'Rsync Parametreleri', edtRsyncParametre.Text);
    WriteString('SUNUCU AYARLARI', 'Yükleme Parametreleri', edtYuklePar.Text);

    //Yadekleme Zamaný Ayarlarý
    WriteInteger('YEDEKLEME ZAMANI', 'Zamanlama Tipi', cmbZamanlamaTipi.ItemIndex);
    WriteInteger('YEDEKLEME ZAMANI', 'Sure Tip', cmbSureTip.ItemIndex);
    WriteString('YEDEKLEME ZAMANI', 'Sure', edtSure.Text);
    WriteString('YEDEKLEME ZAMANI', 'Yedek Zamani', edtYedekZamani.Text);

    for i := 0 to 6 do
      WriteBool('YEDEKLEME ZAMANI', cklGun.Items[i] + '-' + IntToStr(i), cklGun.Checked[i]);

    UpdateFile;
  end;

  FreeAndNil(Ini);
end;

procedure TfmAna.AyarlariYukle;
var
  ini : TIniFile;
  DizinStr : TSTringList;
  i : integer;
begin
  DizinStr := TStringList.Create;

  Ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.INI'));

  with Ini do begin
    //Dizinleri Okuyalým
    ReadSectionValues('DIZIN', DizinStr);
    for i := 0 to DizinStr.Count - 1 do
      vleSecim.InsertRow(DizinStr.Names[i], DizinStr.Values[DizinStr.Names[i]], True);

    //Sunucu ayarlarý
    edtSunucu.Text := ReadString('SUNUCU AYARLARI', 'Sunucu', '192.168.100.15');
    edtKullaniciAdi.Text := ReadString('SUNUCU AYARLARI', 'Kullanýcý', '');
    edtKullaniciSifre.Text := ReadString('SUNUCU AYARLARI', 'Kullanýcý Þifre', '');
    edtYedeklemeDizin.Text := ReadString('SUNUCU AYARLARI', 'Yedekleme Dizin', '');
    edtRsyncParametre.Text := ReadString('SUNUCU AYARLARI', 'Rsync Parametreleri', '-vrtR --delete --progress');
    edtYuklePar.Text := ReadString('SUNUCU AYARLARI', 'Yükleme Parametreleri', '-vrtR --progress');

    cmbZamanlamaTipi.ItemIndex := ReadInteger('YEDEKLEME ZAMANI', 'Zamanlama Tipi', 0);
    cmbSureTip.ItemIndex := ReadInteger('YEDEKLEME ZAMANI', 'Sure Tip', 0);
    edtSure.Text := ReadString('YEDEKLEME ZAMANI', 'Sure', '');
    edtYedekZamani.Text := ReadString('YEDEKLEME ZAMANI', 'Yedek Zamani', '');

    for i := 0 to 6 do
      cklGun.Checked[i] := ReadBool('YEDEKLEME ZAMANI', cklGun.Items[i] + '-' + IntToStr(i), False);
  end;
  cmbZamanlamaTipiChange(Self);

  FreeAndNil(DizinStr);
  FreeAndNil(Ini);
end;

procedure TfmAna.Yedekle;
var
  i : integer;
  orjDizin : string;
  rsnDizin : string;
  poscolon : Integer;
  hdfDizin : String;
  rsyncCmd : String;

  //F: TextFile;
begin
  if YedekIcinBekle then begin
    MessageDlg('Aktif dosya aktarýmý var', mtError, [mbOk], 0);
    exit;
  end;

  pgcAna.ActivePageIndex := pgcAna.PageCount - 1;
  memo1.Lines.Clear;

  for i := 1 to vleSecim.RowCount - 1 do begin
    orjDizin := vleSecim.Cells[1, i];

    //: iþaretinin yerini bulalým
    poscolon := pos(':', orjdizin);
    if poscolon = 0 then
      raise exception.Create('Yedekleme için geçersiz dizin seçimi !');

    //Sürücü adýný rsync ve cygwin için ayarlayalým
    rsnDizin := '/cygdrive/'
                + copy(orjDizin, 1, 1)                        //Sürücü adý
                + copy(orjDizin, 3, length(OrjDizin) - 2);  //Dizin Yapýsý

    //Ters bölü iþaretlerini bölüye çevirelim
    rsnDizin := StringReplace(rsnDizin, '\', '/', [rfReplaceAll]);

    //Boþluklarý escape karakteri ile geçelim
    //rsnDizin := StringReplace(rsnDizin, ' ', '\ ', [rfReplaceAll]);

    rsnDizin := '"' + rsnDizin + '"';

    hdfDizin := edtKullaniciAdi.Text
                + '@'
                + edtSunucu.Text
                + '::'
                + edtKullaniciAdi.Text
                + '/';
    if edtYedeklemeDizin.Text <> '' then
      hdfDizin := hdfDizin + edtYedeklemeDizin.Text + '/';

    rsyncCmd := 'rsync.exe '
                + edtRsyncParametre.Text
                + ' ' + rsnDizin + ' ' + hdfDizin;
    memo1.Lines.Add(rsyncCmd);

    //Rsync'i çalýþtýralým
    YedekIcinBekle := True;
    cmdAna.CommandLine := rsyncCmd;
    cmdAna.OutputLines := memo1.Lines;
    cmdAna.Execute;
    cmdAna.SendLine(edtKullaniciSifre.Text, True);

    while YedekIcinBekle do
      Application.ProcessMessages;
  end;
  //Logu yazalým
  DateSeparator := '_';
  ShortDateFormat := 'yy/mm/dd';
  memo1.Lines.SaveToFile('yedek_' + DateToStr(Date) + '.log');
end;

procedure TfmAna.cmdAnaTerminated(Sender: TObject; ExitCode: Cardinal);
begin
  YedekIcinBekle := False;
end;

procedure TfmAna.btnCikisClick(Sender: TObject);
begin
  Cik;
end;

procedure TfmAna.Cik;
begin
  DosyaListe.Free;
  AyarlariKaydet;
  Shell_NotifyIcon(NIM_DELETE, @TrayIconData);
  Application.ProcessMessages;
  Application.Terminate;
end;

procedure TfmAna.btnHakkindaClick(Sender: TObject);
var
  fmHak : TfmHakkinda;
begin
  fmHak := TfmHakkinda.Create(Self);
  fmHak.ShowModal;
  FreeAndNil(fmHak);
end;

procedure TfmAna.btnGuncelleClick(Sender: TObject);
var
  rsyncCmd : String;
  hdfDizin : String;
begin
  if YedekIcinBekle then begin
    MessageDlg('Aktif dosya aktarýmý var', mtError, [mbOk], 0);
    exit;
  end;


  hdfDizin := edtKullaniciAdi.Text
              + '@'
              + edtSunucu.Text
              + '::'
              + edtKullaniciAdi.Text
              + '/';

  rsyncCmd := 'rsync.exe -r'
              //+ edtRsyncParametre.Text
              //+ ' '
              //+ rsnDizin
              + ' '
              + hdfDizin;


  DosyaListe.Clear;
  YedekIcinBekle := True;
  cmdYedekListe.CommandLine := rsyncCmd;
  cmdYedekListe.OutputLines := DosyaListe;
  cmdYedekListe.Execute;
  cmdYedekListe.SendLine(edtKullaniciSifre.Text, True);
end;

procedure TfmAna.cmdYedekListeTerminated(Sender: TObject;
  ExitCode: Cardinal);
begin
  YedekIcinBekle := False;
  YedekListeHazirla;
end;

procedure TfmAna.YedekListeHazirla;
var
  i : integer;
  baslik : String;
  kalan_str : String;
  dizin_str : String;
  baslik_pos : Integer;
  dizin_pos : Integer;
  seviye_gun : Integer;
  ANode : TTreeNode;
begin
  trvListe.Items.Clear;

  ANode := Nil;
  for i := 1 to DosyaListe.Count - 1 do begin

    baslik_pos := 1;
    dizin_str := DosyaListe.Strings[i];
    dizin_pos := pos('cygdrive', dizin_str);

    if dizin_pos > 0 then begin
      dizin_str := copy(dizin_str, dizin_pos, length(dizin_str) - dizin_pos + 1);
      kalan_str := dizin_str;

      seviye_gun := 0;
      while pos('/', kalan_str) > 0 do begin
        baslik_pos := Pos('/', kalan_str);
        kalan_str := copy(kalan_str, baslik_pos + 1, length(kalan_str) - baslik_pos + 1);
        inc(seviye_gun);
      end;

      if ANode <> Nil then begin
        if seviye_gun = ANode.Level then
          ANode := Anode.Parent
        else begin
          if seviye_gun < ANode.Level then begin
            while ANode.Level >= seviye_gun do
              ANode := ANode.Parent;
          end;
        end;
      end;

      ANode := trvliste.Items.AddChild(ANode, kalan_str);
    end;
  end;
end;

procedure TfmAna.btnYedektenYukleClick(Sender: TObject);
var
  Kaynak : String;
  ANode : TTreeNode;
  rsyncCmd : String;
begin
  if YedekIcinBekle then begin
    MessageDlg('Aktif dosya aktarýmý var', mtError, [mbOk], 0);
    exit;
  end;

  if trvListe.Selected = nil then
    raise exception.Create('Seçim yok!');

  ANode := trvListe.Selected;

  Kaynak := ANode.Text;
  While ANode.Parent <> nil do begin
    ANode := ANode.Parent;
    Kaynak := ANode.Text + '/' + Kaynak;
  end;

  //showmessage(Kaynak);
  Kaynak := StringReplace(Kaynak, ' ', '\ ', [rfReplaceAll]);

  Kaynak := edtKullaniciAdi.Text
            + '@'
            + edtSunucu.Text
            + '::'
            + edtKullaniciAdi.Text
            + '/'
            + Kaynak;


  //M. Yaþar Onur tarafýndan tespit edilen ve düzeltilen problem
  rsyncCmd := 'rsync.exe -rvR --progress'
              + ' '
              + edtYuklePar.Text
              + ' '
              + '"' + Kaynak + '"'
              + ' '
              + '/';


  YedekIcinBekle := True;
  memo1.lines.clear;
  memo1.lines.Add(rsyncCmd);
  pgcAna.ActivePageIndex := pgcAna.PageCount - 1;
  cmdAna.CommandLine := rsyncCmd;
  cmdAna.OutputLines := memo1.Lines;
  cmdAna.Execute;
  cmdAna.SendLine(edtKullaniciSifre.Text, True);
end;

end.
