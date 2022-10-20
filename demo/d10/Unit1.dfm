object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Image SSE/AVX v4.0'
  ClientHeight = 698
  ClientWidth = 1119
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    1119
    698)
  PixelsPerInch = 96
  TextHeight = 13
  object img1: TImage
    Left = 8
    Top = 70
    Width = 1103
    Height = 620
    Anchors = [akLeft, akTop, akRight, akBottom]
    Stretch = True
    ExplicitHeight = 584
  end
  object btnInvert: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = #21453#33394
    TabOrder = 0
    OnClick = btnInvertClick
  end
  object stat1: TStatusBar
    Left = 0
    Top = 679
    Width = 1119
    Height = 19
    Panels = <
      item
        Width = 200
      end
      item
        Width = 50
      end>
  end
  object btnGray: TButton
    Left = 88
    Top = 8
    Width = 75
    Height = 25
    Caption = #28784#24230
    TabOrder = 2
    OnClick = btnGrayClick
  end
  object btnHMirror: TButton
    Left = 169
    Top = 8
    Width = 75
    Height = 25
    Caption = #27700#24179#38236#20687
    TabOrder = 3
    OnClick = btnHMirrorClick
  end
  object btnVMirror: TButton
    Left = 250
    Top = 8
    Width = 75
    Height = 25
    Caption = #22402#30452#38236#20687
    TabOrder = 4
    OnClick = btnVMirrorClick
  end
  object btnHVMirror: TButton
    Left = 331
    Top = 8
    Width = 75
    Height = 25
    Caption = #36716#32622
    TabOrder = 5
    OnClick = btnHVMirrorClick
  end
  object btnRotate: TButton
    Left = 412
    Top = 8
    Width = 75
    Height = 25
    Caption = #26059#36716
    TabOrder = 6
    OnClick = btnRotateClick
  end
  object btnBrightness: TButton
    Left = 492
    Top = 8
    Width = 75
    Height = 25
    Caption = #20142#24230
    TabOrder = 7
    OnClick = btnBrightnessClick
  end
  object btnContrast: TButton
    Tag = 1
    Left = 573
    Top = 8
    Width = 75
    Height = 25
    Caption = #23545#27604#24230
    TabOrder = 8
    OnClick = btnBrightnessClick
  end
  object btnSaturation: TButton
    Tag = 2
    Left = 654
    Top = 8
    Width = 75
    Height = 25
    Caption = #39281#21644#24230
    TabOrder = 9
    OnClick = btnBrightnessClick
  end
  object btnRestore: TButton
    Left = 1036
    Top = 8
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #24674#22797
    TabOrder = 10
    OnClick = btnRestoreClick
  end
  object btnColorMap: TButton
    Tag = 3
    Left = 735
    Top = 8
    Width = 75
    Height = 25
    Caption = #33394#24425
    TabOrder = 11
    OnClick = btnBrightnessClick
  end
  object btnBlend: TButton
    Tag = 4
    Left = 816
    Top = 8
    Width = 75
    Height = 25
    Caption = #36879#26126#24230
    TabOrder = 12
    OnClick = btnBrightnessClick
  end
  object btnMosaic: TButton
    Tag = 4
    Left = 412
    Top = 39
    Width = 75
    Height = 25
    Caption = #39532#36187#20811
    TabOrder = 13
    OnClick = btnMosaicClick
  end
  object btnExposure: TButton
    Left = 8
    Top = 39
    Width = 75
    Height = 25
    Caption = #26333#20809
    TabOrder = 14
    OnClick = btnExposureClick
  end
  object btnEmboss: TButton
    Left = 88
    Top = 39
    Width = 75
    Height = 25
    Caption = #28014#38613
    TabOrder = 15
    OnClick = btnEmbossClick
  end
  object btnSharpen: TButton
    Left = 169
    Top = 39
    Width = 75
    Height = 25
    Caption = #38160#21270
    TabOrder = 16
    OnClick = btnSharpenClick
  end
  object btnBlur: TButton
    Left = 250
    Top = 39
    Width = 75
    Height = 25
    Caption = #27169#31946
    TabOrder = 17
    OnClick = btnBlurClick
  end
  object btnSponge: TButton
    Left = 331
    Top = 39
    Width = 75
    Height = 25
    Caption = #27833#30011
    TabOrder = 18
    OnClick = btnSpongeClick
  end
  object btnGamma: TButton
    Tag = 5
    Left = 897
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Gamma'
    TabOrder = 19
    OnClick = btnBrightnessClick
  end
  object btnPosterize: TButton
    Left = 492
    Top = 39
    Width = 75
    Height = 25
    Caption = #22721#30011
    TabOrder = 20
    OnClick = btnPosterizeClick
  end
  object btnNosie: TButton
    Left = 573
    Top = 39
    Width = 75
    Height = 25
    Caption = #22122#28857
    TabOrder = 21
    OnClick = btnNosieClick
  end
end
