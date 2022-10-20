unit dbImage;
{
  功能(Func)：高速数字图像处理(High speed digital image processing)
  作者(Auth)：dbyoung@sina.com
  时间(Time)：2020-10-01
  版本(Vers): v4.0
}

interface

uses Winapi.Windows, System.Classes, System.UITypes, System.SysUtils, System.StrUtils, System.Math, Vcl.Graphics, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Forms;

type
  TdbImage     = procedure(bmpHandle: HBITMAP); cdecl;
  TColorChange = (ccLight, ccContrast, ccSaturation, ccColorMode, ccTranslate, ccGamma);

const
  c_intMinMaxValue: array [0 .. 5, 0 .. 1] of Integer  = ((-255, 255), (-255, 255), (-255, 255), (0, 360), (0, 100), (0, 120));
  c_strShowTipsCHS: array [0 .. 5, 0 .. 1] of String   = (('调节亮度：', '亮度：'), ('调节对比度：', '对比度：'), ('调节饱和度：', '饱和度：'), ('调节图片色彩：', '色彩：'), ('调节透明度：', '透明：'), ('调节Gamma：', '数值：'));
  c_strShowTimeCHS: array [0 .. 5] of String           = ('调节亮度用时：%d 毫秒', '调节对比度用时：%d 毫秒', '调节饱和度用时：%d 毫秒', '调节图片色彩用时：%d 毫秒', '调节透明度用时：%d 毫秒', '调节Gamma用时：%d 毫秒');
  c_strShowTipsENG: array [0 .. 5, 0 .. 1] of String   = (('Change Bright：', 'Value：'), ('Change Contrast：', 'Value：'), ('Change Saturation：', 'Value：'), ('Change Color map：', 'Value：'), ('Change Translate：', 'Value：'), ('Change Gamma：', 'Value：'));
  c_strShowTimeENG: array [0 .. 5] of String           = ('Time of Bright：%d ms', 'Time of Contrast：%d ms', 'Time of Saturation：%d ms', 'Time of Color map：%d ms', 'Time of Translate：%d ms', 'Time of Gamma：%d ms');

procedure hBmpToBmp(hBmp: HBITMAP; var bmp: TBitmap);
procedure ShowColorChange(frmMain: TForm; cc: TColorChange; OnChangeLight, OnLightResetClick, OnLightCancelClick, OnLightOKClick: TNotifyEvent; var lblValueShow: TLabel; const intMinValue, intMaxValue: Integer; const strCaption, strTip: string);

{ 检查系统是否是中文操作系统 }
function dbImageCheckChineseUI: Boolean; cdecl; external 'dbimg.dll';

{ dbImage SDK 初始化 }
procedure dbImageInit; cdecl; external 'dbimg.dll';

{ dbImage SDK 卸载 }
procedure dbImageFree; cdecl; external 'dbimg.dll';

{ dbImage 图片加载 }
function dbImageLoad(const strFileName: PAnsiChar; var bmpHandle: HBITMAP): Boolean; cdecl; external 'dbimg.dll';

{ dbImage 图片反色 }
procedure dbImageInvert(bmpHandle: HBITMAP); cdecl; external 'dbimg.dll';

{ dbImage 图片灰度 }
procedure dbImageGray(bmpHandle: HBITMAP); cdecl; external 'dbimg.dll';

{ dbImage 图片水平镜像 }
procedure dbImageHMirror(bmpHandle: HBITMAP); cdecl; external 'dbimg.dll';

{ dbImage 图片垂直镜像 }
procedure dbImageVMirror(bmpHandle: HBITMAP); cdecl; external 'dbimg.dll';

{ dbImage 图片转置 }
procedure dbImageHVMirror(bmpHandle: HBITMAP); cdecl; external 'dbimg.dll';

{ dbImage 图片旋转 }
procedure dbImageRotate(bmpHandle: HBITMAP; var bmpResult: HBITMAP; const intAngle: Integer); cdecl; external 'dbimg.dll';

{ dbImage 图片调节亮度 }
procedure dbImageLight(bmpHandle: HBITMAP; const intLightValue: Integer); cdecl; external 'dbimg.dll';

{ dbImage 图片调节对比度 }
procedure dbImageContrast(bmpHandle: HBITMAP; const intLightValue: Integer); cdecl; external 'dbimg.dll';

{ dbImage 图片调节饱和度 }
procedure dbImageSaturation(bmpHandle: HBITMAP; const intLightValue: Integer); cdecl; external 'dbimg.dll';

{ dbImage 图片调节色彩 }
procedure dbImageColorMap(bmpHandle: HBITMAP; const intLightValue: Integer); cdecl; external 'dbimg.dll';

{ dbImage 图片调节透明度 }
procedure dbImageColorBlend(bmpHandle: HBITMAP; bmpTrans: HBITMAP; const intLightValue: Integer); cdecl; external 'dbimg.dll';

{ dbImage 图片调节Gamma }
procedure dbImageGamma(bmpHandle: HBITMAP; const intGammaValue: Integer); cdecl; external 'dbimg.dll';

{ dbImage 图片马赛克 }
procedure dbImageMosaic(bmpHandle: HBITMAP; var bmpDst: HBITMAP); cdecl; external 'dbimg.dll';

{ dbImage 图片曝光 }
procedure dbImageExposure(bmpHandle: HBITMAP); cdecl; external 'dbimg.dll';

{ dbImage 图片浮雕 }
procedure dbImageEmboss(bmpHandle: HBITMAP); cdecl; external 'dbimg.dll';

{ dbImage 图片锐化 }
procedure dbImageSharpen(bmpHandle: HBITMAP); cdecl; external 'dbimg.dll';

{ dbImage 图片模糊 }
procedure dbImageBlur(bmpHandle: HBITMAP); cdecl; external 'dbimg.dll';

{ dbImage 图片油画 }
procedure dbImageSponge(bmpHandle: HBITMAP); cdecl; external 'dbimg.dll';

{ dbImage 图片壁画 }
procedure dbImagePosterize(bmpHandle: HBITMAP); cdecl; external 'dbimg.dll';

{ dbImage 图片噪点 }
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
  btnReset.Caption := Ifthen(dbImageCheckChineseUI, '复位', 'Reset');
  btnReset.OnClick := OnLightResetClick;

  btnCancel         := TButton.Create(frmLight);
  btnCancel.Parent  := frmLight;
  btnCancel.Left    := btnReset.Left + 170;
  btnCancel.Top     := trckbrLight.Top + 40;
  btnCancel.width   := 90;
  btnCancel.height  := 30;
  btnCancel.Caption := Ifthen(dbImageCheckChineseUI, '取消', 'Cancel');
  btnCancel.OnClick := OnLightCancelClick;

  btnOK         := TButton.Create(frmLight);
  btnOK.Parent  := frmLight;
  btnOK.Left    := btnCancel.Left + 170;
  btnOK.Top     := trckbrLight.Top + 40;
  btnOK.width   := 90;
  btnOK.height  := 30;
  btnOK.Caption := Ifthen(dbImageCheckChineseUI, '确定', 'OK');
  btnOK.OnClick := OnLightOKClick;

  lblValueShow := lblValue;
  frmLight.Show;
end;

end.
