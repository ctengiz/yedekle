object fmAna: TfmAna
  Left = 257
  Top = 173
  Width = 578
  Height = 408
  Caption = 'Yedekle'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pgcAna: TPageControl
    Left = 0
    Top = 0
    Width = 570
    Height = 333
    ActivePage = TabSheet4
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Dosya Se'#231'imi'
      object Splitter1: TSplitter
        Left = 249
        Top = 0
        Height = 305
        Beveled = True
      end
      object vleSecim: TValueListEditor
        Left = 252
        Top = 0
        Width = 310
        Height = 305
        Align = alClient
        Ctl3D = True
        KeyOptions = [keyEdit, keyAdd, keyDelete, keyUnique]
        ParentCtl3D = False
        TabOrder = 0
        ColWidths = (
          150
          154)
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 249
        Height = 305
        Align = alLeft
        BevelOuter = bvNone
        Caption = 'Panel1'
        TabOrder = 1
        object stvAna: TShellTreeView
          Left = 0
          Top = 0
          Width = 204
          Height = 277
          ObjectTypes = [otFolders]
          Root = 'rfDesktop'
          UseShellImages = True
          Align = alClient
          AutoRefresh = False
          Indent = 19
          ParentColor = False
          RightClickSelect = True
          ShowRoot = False
          TabOrder = 0
        end
        object Panel2: TPanel
          Left = 204
          Top = 0
          Width = 45
          Height = 277
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 1
          object btnCikar: TButton
            Left = 8
            Top = 64
            Width = 32
            Height = 25
            Caption = '<'
            TabOrder = 0
            OnClick = btnCikarClick
          end
          object btnEkle: TButton
            Left = 8
            Top = 32
            Width = 32
            Height = 25
            Caption = '>'
            TabOrder = 1
            OnClick = btnEkleClick
          end
        end
        object Panel3: TPanel
          Left = 0
          Top = 277
          Width = 249
          Height = 28
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 2
          object ckbDosyaGoster: TCheckBox
            Left = 7
            Top = 8
            Width = 97
            Height = 17
            Caption = 'Dosyalar'#305' G'#246'ster'
            TabOrder = 0
            OnClick = ckbDosyaGosterClick
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Yedekleme Ayarlar'#305
      ImageIndex = 1
      object GroupBox1: TGroupBox
        Left = 401
        Top = 0
        Width = 161
        Height = 305
        Align = alClient
        Caption = 'Yedek Alma Plan'#305
        TabOrder = 0
        object pnlGunluk: TPanel
          Left = 2
          Top = 105
          Width = 157
          Height = 152
          Align = alTop
          TabOrder = 0
          Visible = False
          object Label1: TLabel
            Left = 32
            Top = 16
            Width = 66
            Height = 13
            Caption = 'Yedek Zaman'#305
          end
          object edtYedekZamani: TMaskEdit
            Left = 104
            Top = 8
            Width = 41
            Height = 21
            EditMask = '!90:00;1;_'
            MaxLength = 5
            TabOrder = 0
            Text = '  :  '
          end
          object cklGun: TCheckListBox
            Left = 8
            Top = 40
            Width = 145
            Height = 97
            ItemHeight = 13
            Items.Strings = (
              'Pazartesi'
              'Sal'#305
              #199'ar'#351'amba'
              'Per'#351'embe'
              'Cuma'
              'Cumartesi'
              'Pazar')
            TabOrder = 1
          end
        end
        object pnlGunici: TPanel
          Left = 2
          Top = 57
          Width = 157
          Height = 48
          Align = alTop
          TabOrder = 1
          Visible = False
          object cmbSureTip: TComboBox
            Left = 48
            Top = 16
            Width = 105
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            ItemIndex = 0
            TabOrder = 0
            Text = 'Saatte bir'
            Items.Strings = (
              'Saatte bir'
              'Dakikada bir')
          end
          object edtSure: TMaskEdit
            Left = 8
            Top = 16
            Width = 33
            Height = 21
            EditMask = '99;1;_'
            MaxLength = 2
            TabOrder = 1
            Text = '  '
          end
        end
        object Panel5: TPanel
          Left = 2
          Top = 15
          Width = 157
          Height = 42
          Align = alTop
          TabOrder = 2
          object cmbZamanlamaTipi: TComboBox
            Left = 8
            Top = 12
            Width = 145
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            ItemIndex = 0
            TabOrder = 0
            Text = 'G'#252'nl'#252'k'
            OnChange = cmbZamanlamaTipiChange
            Items.Strings = (
              'G'#252'nl'#252'k'
              'G'#252'n '#304#231'erisinde')
          end
        end
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 401
        Height = 305
        Align = alLeft
        Caption = 'Sunucu Ayarlar'#305
        TabOrder = 1
        object edtSunucu: TLabeledEdit
          Left = 16
          Top = 48
          Width = 129
          Height = 21
          EditLabel.Width = 100
          EditLabel.Height = 13
          EditLabel.Caption = 'Yedekleme Sunucusu'
          TabOrder = 0
        end
        object edtKullaniciAdi: TLabeledEdit
          Left = 16
          Top = 96
          Width = 129
          Height = 21
          EditLabel.Width = 55
          EditLabel.Height = 13
          EditLabel.Caption = 'Kullan'#305'c'#305' Ad'#305
          TabOrder = 1
        end
        object edtYedeklemeDizin: TLabeledEdit
          Left = 16
          Top = 184
          Width = 265
          Height = 21
          EditLabel.Width = 78
          EditLabel.Height = 13
          EditLabel.Caption = 'Yedekleme Dizini'
          TabOrder = 3
        end
        object edtKullaniciSifre: TLabeledEdit
          Left = 16
          Top = 144
          Width = 129
          Height = 21
          EditLabel.Width = 69
          EditLabel.Height = 13
          EditLabel.Caption = 'Kullan'#305'c'#305' '#350'ifresi'
          PasswordChar = '*'
          TabOrder = 2
        end
        object edtRsyncParametre: TLabeledEdit
          Left = 16
          Top = 228
          Width = 129
          Height = 21
          EditLabel.Width = 96
          EditLabel.Height = 13
          EditLabel.Caption = 'Rsync Parametreleri'
          TabOrder = 4
          Text = '-vrtzR --progress'
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Yedekten Y'#252'kleme'
      ImageIndex = 3
      object trvListe: TTreeView
        Left = 0
        Top = 0
        Width = 562
        Height = 270
        Align = alTop
        Indent = 19
        TabOrder = 0
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 257
        Width = 562
        Height = 48
        Align = alBottom
        TabOrder = 1
        object btnGuncelle: TButton
          Left = 11
          Top = 14
          Width = 129
          Height = 25
          Caption = 'Yedek Listesini G'#252'ncelle'
          TabOrder = 0
          OnClick = btnGuncelleClick
        end
        object btnYedektenYukle: TButton
          Left = 152
          Top = 14
          Width = 129
          Height = 25
          Caption = 'Yedekten Y'#252'kle'
          TabOrder = 1
          OnClick = btnYedektenYukleClick
        end
        object edtYuklePar: TLabeledEdit
          Left = 424
          Top = 16
          Width = 121
          Height = 21
          EditLabel.Width = 104
          EditLabel.Height = 13
          EditLabel.Caption = 'Y'#252'kle Ek Parametreler'
          LabelPosition = lpLeft
          TabOrder = 2
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Loglar'
      ImageIndex = 2
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 562
        Height = 305
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 0
        WordWrap = False
      end
    end
  end
  object pnlAlt: TPanel
    Left = 0
    Top = 333
    Width = 570
    Height = 41
    Align = alBottom
    TabOrder = 1
    object btnSimdiYedekle: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = #350'imdi Yedekle'
      TabOrder = 0
      OnClick = btnSimdiYedekleClick
    end
    object btnAyarlariKaydet: TButton
      Left = 88
      Top = 8
      Width = 105
      Height = 25
      Caption = 'Ayarlar'#305' Kaydet'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnAyarlariKaydetClick
    end
    object btnHakkinda: TButton
      Left = 200
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Hakk'#305'nda'
      TabOrder = 2
      OnClick = btnHakkindaClick
    end
    object btnCikis: TButton
      Left = 488
      Top = 8
      Width = 75
      Height = 25
      Caption = #199#305'k'#305#351
      TabOrder = 3
      OnClick = btnCikisClick
    end
  end
  object timerYedekle: TTimer
    Interval = 45000
    OnTimer = timerYedekleTimer
    Left = 268
    Top = 136
  end
  object appEvent: TApplicationEvents
    OnMinimize = appEventMinimize
    Left = 268
    Top = 40
  end
  object pmAna: TPopupMenu
    Left = 264
    Top = 72
    object Gster1: TMenuItem
      Caption = '&G'#246'ster'
      OnClick = Gster1Click
    end
    object Gizle1: TMenuItem
      Caption = 'Gi&zle'
      OnClick = Gizle1Click
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object k1: TMenuItem
      Caption = #199#305'k'#305#351
      OnClick = k1Click
    end
  end
  object cmdAna: TDosCommand
    OnTerminated = cmdAnaTerminated
    InputToOutput = False
    MaxTimeAfterBeginning = 0
    MaxTimeAfterLastOutput = 0
    ShowWindow = swHIDE
    CreationFlag = fCREATE_NEW_CONSOLE
    ReturnCode = rcCRLF
    Left = 268
    Top = 104
  end
  object cmdYedekListe: TDosCommand
    OnTerminated = cmdYedekListeTerminated
    InputToOutput = False
    MaxTimeAfterBeginning = 0
    MaxTimeAfterLastOutput = 0
    ShowWindow = swHIDE
    CreationFlag = fCREATE_NEW_CONSOLE
    ReturnCode = rcCRLF
    Left = 300
    Top = 104
  end
end
