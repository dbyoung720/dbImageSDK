unit dbImage;
{
  ����(Func)����������ͼ����(High speed digital image processing)
  ����(Auth)��dbyoung@sina.com
  ʱ��(Time)��2020-10-01
  �汾(Vers): v4.0
}

interface

uses Winapi.Windows, System.Classes, System.UITypes, System.SysUtils, System.StrUtils, System.Math, Vcl.Graphics, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Forms;

type
  TdbImage     = procedure(bmpHandle: HBITMAP); cdecl;
  TColorChange = (ccLight, ccContrast, ccSaturation, ccColorMode, ccTranslate, ccGamma);

const
  c_intMinMaxValue: array [0 .. 5, 0 .. 1] of Integer  = ((-255, 255), (-255, 255), (-255, 255), (0, 360), (0, 100), (0, 120));
  c_strShowTipsCHS: array [0 .. 5, 0 .. 1] of String   = (('�������ȣ�', '���ȣ�'), ('���ڶԱȶȣ�', '�Աȶȣ�'), ('���ڱ��Ͷȣ�', '���Ͷȣ�'), ('����ͼƬɫ�ʣ�', 'ɫ�ʣ�'), ('����͸���ȣ�', '͸����'), ('����Gamma��', '��ֵ��'));
  c_strShowTimeCHS: array [0 .. 5] of String           = ('����������ʱ��%d ����', '���ڶԱȶ���ʱ��%d ����', '���ڱ��Ͷ���ʱ��%d ����', '����ͼƬɫ����ʱ��%d ����', '����͸������ʱ��%d ����', '����Gamma��ʱ��%d ����');
  c_strShowTipsENG: array [0 .. 5, 0 .. 1] of String   = (('Change Bright��', 'Value��'), ('Change Contrast��', 'Value��'), ('Change Saturation��', 'Value��'), ('Change Color map��', 'Value��'), ('Change Translate��', 'Value��'), ('Change Gamma��', 'Value��'));
  c_strShowTimeENG: array [0 .. 5] of String           = ('Time of Bright��%d ms', 'Time of Contrast��%d ms', 'Time of Saturation��%d ms', 'Time of Color map��%d ms', 'Time of Translate��%d ms', 'Time of Gamma��%d ms');

procedure hBmpToBmp(hBmp: HBITMAP; var bmp: TBitmap);
procedure ShowColorChange(frmMain: TForm; cc: TColorChange; OnChangeLight, OnLightResetClick, OnLightCancelClick, OnLightOKClick: TNotifyEvent; var lblValueShow: TLabel; const intMinValue, intMaxValue: Integer; const strCaption, strTip: string);

{ ���ϵͳ�Ƿ������Ĳ���ϵͳ }
function dbImageCheckChineseUI: Boolean; cdecl; external 'dbimg.dll';

{ dbImage SDK ��ʼ�� }
procedure dbImageInit; cdecl; external 'dbimg.dll';

{ dbImage SDK ж�� }
procedure dbImageFree; cdecl; external 'dbimg.dll';

{ dbImage ͼƬ���� }
function dbImageLoad(const strFileName: PAnsiChar; var bmpHandle: HBITMAP): Boolean; cdecl; external 'dbimg.dll';

{ dbImage ͼƬ��ɫ }
procedure dbImageInvert(bmpHandle: HBITMAP); cdecl; external 'dbimg.dll';

{ dbImage ͼƬ�Ҷ� }
procedure dbImageGray(bmpHandle: HBITMAP); cdecl; external 'dbimg.dll';

{ dbImage ͼƬˮƽ���� }
procedure dbImageHMirror(bmpHandle: HBITMAP); cdecl; external 'dbimg.dll';

{ dbImage ͼƬ��ֱ���� }
procedure dbImageVMirror(bmpHandle: HBITMAP); cdecl; external 'dbimg.dll';

{ dbImage ͼƬת�� }
procedure dbImageHVMirror(bmpHandle: HBITMAP); cdecl; external 'dbimg.dll';

{ dbImage ͼƬ��ת }
procedure dbImageRotate(bmpHandle: HBITMAP; var bmpResult: HBITMAP; const intAngle: Integer); cdecl; external 'dbimg.dll';

{ dbImage ͼƬ�������� }
procedure dbImageLight(bmpHandle: HBITMAP; const intLightValue: Integer); cdecl; external 'dbimg.dll';

{ dbImage ͼƬ���ڶԱȶ� }
procedure dbImageContrast(bmpHandle: HBITMAP; const intLightValue: Integer); cdecl; external 'dbimg.dll';

{ dbImage ͼƬ���ڱ��Ͷ� }
procedure dbImageSaturation(bmpHandle: HBITMAP; const intLightValue: Integer); cdecl; external 'dbimg.dll';

{ dbImage ͼƬ����ɫ�� }
procedure dbImageColorMap(bmpHandle: HBITMAP; const intLightValue: Integer); cdecl; external 'dbimg.dll';

{ dbImage ͼƬ����͸���� }
procedure dbImageColorBlend(bmpHandle: HBITMAP; bmpTrans: HBITMAP; const intLightValue: Integer); cdecl; external 'dbimg.dll';

{ dbImage ͼƬ����Gamma }
procedure dbImageGamma(bmpHandle: HBITMAP; const intGammaValue: Integer); cdecl; external 'dbimg.dll';

{ dbImage ͼƬ������ }
procedure dbImageMosaic(bmpHandle: HBITMAP; var bmpDst: HBITMAP); cdecl; external 'dbimg.dll';

{ dbImage ͼƬ�ع� }
procedure dbImageExposure(bmpHandle: HBITMAP); cdecl; external 'dbimg.dll';

{ dbImage ͼƬ���� }
procedure dbImageEmboss(bmpHandle: HBITMAP); cdecl; external 'dbimg.dll';

{ dbImage ͼƬ�� }
procedure dbImageSharpen(bmpHandle: HBITMAP); cdecl; external 'dbimg.dll';

{ dbImage ͼƬģ�� }
procedure dbImageBlur(bmpHandle: HBITMAP); cdecl; external 'dbimg.dll';

{ dbImage ͼƬ�ͻ� }
procedure dbImageSponge(bmpHandle: HBITMAP); cdecl; external 'dbimg.dll';

{ dbImage ͼƬ�ڻ� }
procedure dbImagePosterize(bmpHandle: HBITMAP); cdecl; external 'dbimg.dll';

{ dbImage ͼƬ��� }
procedure dbImageNoise(bmpHandle: HBITMAP); cdecl; external 'dbimg.dll';

implementation

procedure hBmpToBmp(hBmp: HBITMAP; var bmp: TBitmap);
var
  obmp: Bitmap;
begin
  bmp.PixelFormat := pf32bit;
  GetObject(hBmp, SizeOf(obmp), @obmp);
  bmp.width  := obmp.bmWidth;
  bmp.height := obmp.bmHeight;
  bmp.Handle := hBmp;
end;

procedure ShowColorChange(frmMain: TForm; cc: TColorChange; OnChangeLight, OnLightResetClick, OnLightCancelClick, OnLightOKClick: TNotifyEvent; var lblValueShow: TLabel; const intMinValue, intMaxValue: Integer; const strCaption, strTip: string);
var
  frmLight                  : TForm;
  trckbrLight               : TTrackBar;
  lblTip, lblValue          : TLabel;
  btnReset, btnCancel, btnOK: TButton;
begin
  frmLight             := TForm.Create(nil);
  frmLight.BorderStyle := bsSingle;
  frmLight.Position    := poDesigned;
  frmLight.BorderIcons := frmLight.BorderIcons - [biMaximize, biMinimize];
  frmLight.width       := 600;
  frmLight.height      := 140;
  frmLight.Caption     := strCaption;
  frmLight.Left        := frmMain.Left + frmMain.width - frmLight.width - 10;
  frmLight.Top         := frmMain.Top + 55;
  frmLight.OnClose     := frmMain.OnClose;

  trckbrLight             := TTrackBar.Create(frmLight);
  trckbrLight.Parent      := frmLight;
  trckbrLight.width       := 440;
  trckbrLight.Left        := 70;
  trckbrLight.Top         := 20;
  trckbrLight.Min         := intMinValue;
  trckbrLight.Max         := intMaxValue;
  trckbrLight.LineSize    := 10;
  trckbrLight.PageSize    := 10;
  trckbrLight.Frequency   := 10;
  trckbrLight.ThumbLength := 20;
  trckbrLight.Tag         := Integer(cc);
  trckbrLight.OnChange    := OnChangeLight;

  lblTip            := TLabel.Create(frmLight);
  lblTip.Parent     := frmLight;
  lblTip.Left       := 8;
  lblTip.Top        := 16;
  lblTip.Caption    := strTip;
  lblTip.Font.Color := clRed;
  lblTip.Font.size  := 14;
  lblTip.Font.Style := lblTip.Font.Style + [fsBold];

  lblValue            := TLabel.Create(frmLight);
  lblValue.Parent     := frmLight;
  lblValue.Left       := trckbrLight.Left + trckbrLight.width + 20;
  lblValue.Top        := 16;
  lblValue.Caption    := '0';
  lblValue.Font.Color := clRed;
  lblValue.Font.size  := 14;
  lblValue.Font.Style := lblValue.Font.Style + [fsBold];

  btnReset         := TButton.Create(frmLight);
  btnReset.Parent  := frmLight;
  btnReset.Left    := trckbrLight.Left + 5;
  btnReset.Top     := trckbrLight.Top + 40;
  btnReset.width   := 90;
  btnReset.height  := 30;
  btnReset.Caption := Ifthen(dbImageCheckChineseUI, '��λ', 'Reset');
  btnReset.OnClick := OnLightResetClick;

  btnCancel         := TButton.Create(frmLight);
  btnCancel.Parent  := frmLight;
  btnCancel.Left    := btnReset.Left + 170;
  btnCancel.Top     := trckbrLight.Top + 40;
  btnCancel.width   := 90;
  btnCancel.height  := 30;
  btnCancel.Caption := Ifthen(dbImageCheckChineseUI, 'ȡ��', 'Cancel');
  btnCancel.OnClick := OnLightCancelClick;

  btnOK         := TButton.Create(frmLight);
  btnOK.Parent  := frmLight;
  btnOK.Left    := btnCancel.Left + 170;
  btnOK.Top     := trckbrLight.Top + 40;
  btnOK.width   := 90;
  btnOK.height  := 30;
  btnOK.Caption := Ifthen(dbImageCheckChineseUI, 'ȷ��', 'OK');
  btnOK.OnClick := OnLightOKClick;

  lblValueShow := lblValue;
  frmLight.Show;
end;

end.
