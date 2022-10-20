unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.StrUtils, System.Variants, System.Classes, System.Diagnostics, System.UITypes, System.Threading,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.ComCtrls, dbImage;

type
  TForm1 = class(TForm)
    btnInvert: TButton;
    img1: TImage;
    stat1: TStatusBar;
    btnGray: TButton;
    btnHMirror: TButton;
    btnVMirror: TButton;
    btnHVMirror: TButton;
    btnRotate: TButton;
    btnBrightness: TButton;
    btnContrast: TButton;
    btnSaturation: TButton;
    btnRestore: TButton;
    btnColorMap: TButton;
    btnBlend: TButton;
    btnMosaic: TButton;
    btnExposure: TButton;
    btnEmboss: TButton;
    btnSharpen: TButton;
    btnBlur: TButton;
    btnSponge: TButton;
    btnGamma: TButton;
    btnPosterize: TButton;
    btnNosie: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnGrayClick(Sender: TObject);
    procedure btnRestoreClick(Sender: TObject);
    procedure btnHMirrorClick(Sender: TObject);
    procedure btnInvertClick(Sender: TObject);
    procedure btnVMirrorClick(Sender: TObject);
    procedure btnHVMirrorClick(Sender: TObject);
    procedure btnRotateClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnBrightnessClick(Sender: TObject);
    procedure btnMosaicClick(Sender: TObject);
    procedure btnExposureClick(Sender: TObject);
    procedure btnEmbossClick(Sender: TObject);
    procedure btnSharpenClick(Sender: TObject);
    procedure btnBlurClick(Sender: TObject);
    procedure btnSpongeClick(Sender: TObject);
    procedure btnPosterizeClick(Sender: TObject);
    procedure btnNosieClick(Sender: TObject);
  private
    FintRotateAngle  : Integer;
    FbmpBackup       : TBitmap;
    FbmpRotateBackup : TBitmap;
    FbmpTrans        : TBitmap;
    FTrackColorChange: TTrackBar;
    FlblLightValue   : TLabel;
    FButtonSelected  : TButton;
    procedure ShowLanguage;
    procedure LoadImage;
    procedure dbImage(T: TdbImage; Sender: TObject);
    procedure OnColorChange(Sender: TObject);
    procedure OnResetClick(Sender: TObject);
    procedure OnCancelClick(Sender: TObject);
    procedure OnOKClick(Sender: TObject);
    procedure BackupBmp;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.ShowLanguage;
begin
  if not dbImageCheckChineseUI then
  begin
    btnRestore.Caption    := 'Restore';
    btnInvert.Caption     := 'Invert';
    btnGray.Caption       := 'Gray';
    btnHMirror.Caption    := 'hMirror';
    btnVMirror.Caption    := 'vMirror';
    btnHVMirror.Caption   := 'hvMirror';
    btnRotate.Caption     := 'Rotate';
    btnBrightness.Caption := 'Bright';
    btnContrast.Caption   := 'Contrast';
    btnSaturation.Caption := 'Saturation';
    btnColorMap.Caption   := 'ColorMap';
    btnBlend.Caption      := 'Blend';
    btnExposure.Caption   := 'Exposure';
    btnEmboss.Caption     := 'Emboss';
    btnSharpen.Caption    := 'Sharpen';
    btnBlur.Caption       := 'Blur';
    btnSponge.Caption     := 'Sponge';
    btnMosaic.Caption     := 'Mosaic';
    btnPosterize.Caption  := 'Posterize';
    btnNosie.Caption      := 'Nosie';
  end;
end;

procedure TForm1.BackupBmp;
begin
  if FbmpRotateBackup <> nil then
    FbmpRotateBackup.Free;

  FintRotateAngle              := 0;
  FbmpRotateBackup             := TBitmap.Create;
  FbmpRotateBackup.PixelFormat := pf32bit;
  FbmpRotateBackup.width       := img1.Picture.Bitmap.width;
  FbmpRotateBackup.height      := img1.Picture.Bitmap.height;
  FbmpRotateBackup.Canvas.Draw(0, 0, img1.Picture.Bitmap);

  if FbmpBackup <> nil then
    FbmpBackup.Free;

  FbmpBackup             := TBitmap.Create;
  FbmpBackup.PixelFormat := pf32bit;
  FbmpBackup.width       := img1.Picture.Bitmap.width;
  FbmpBackup.height      := img1.Picture.Bitmap.height;
  FbmpBackup.Canvas.Draw(0, 0, img1.Picture.Bitmap);
end;

procedure TForm1.LoadImage;
var
  bmpHandle: HBITMAP;
  bmp      : TBitmap;
  bLoad    : Boolean;
begin
  with TStopwatch.StartNew do
  begin
    bLoad := dbImageLoad(PAnsiChar(AnsiString(ExtractFilePath(ParamStr(0)) + 'test.jpg')), bmpHandle);
    if not bLoad then
      Exit;

    bmp := TBitmap.Create;
    hBmpToBmp(bmpHandle, bmp);
    img1.Picture.Bitmap.Assign(bmp);
    bmp.Free;
    stat1.Panels[0].Text := Ifthen(not dbImageCheckChineseUI, Format('Time for decode picture：%d ms', [ElapsedMilliseconds]), Format('解码图片用时：%d 毫秒', [ElapsedMilliseconds]));
  end;

  if bLoad then
    BackupBmp;
end;

procedure TForm1.btnRestoreClick(Sender: TObject);
begin
  LoadImage;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  bmpHandle: HBITMAP;
begin
  dbImageInit;
  ShowLanguage;
  LoadImage;

  if not dbImageLoad(PAnsiChar(AnsiString(ExtractFilePath(ParamStr(0)) + 'tran.jpg')), bmpHandle) then
    Exit;

  FbmpTrans := TBitmap.Create;
  hBmpToBmp(bmpHandle, FbmpTrans);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  if FbmpRotateBackup <> nil then
    FbmpRotateBackup.Free;

  if FbmpBackup <> nil then
    FbmpBackup.Free;

  FbmpTrans.Free;
  dbImageFree;
end;

procedure TForm1.dbImage(T: TdbImage; Sender: TObject);
begin
  with TStopwatch.StartNew do
  begin
    T(img1.Picture.Bitmap.Handle);
    stat1.Panels[0].Text := Ifthen(not dbImageCheckChineseUI, Format('Time of picture %s：%d ms', [TButton(Sender).Caption, ElapsedMilliseconds]), Format('图片%s用时：%d 毫秒', [TButton(Sender).Caption, ElapsedMilliseconds]));
  end;
  img1.Invalidate;
end;

procedure TForm1.btnInvertClick(Sender: TObject);
begin
  dbImage(dbImageInvert, Sender);
end;

procedure TForm1.btnGrayClick(Sender: TObject);
begin
  dbImage(dbImageGray, Sender);
end;

procedure TForm1.btnHMirrorClick(Sender: TObject);
begin
  dbImage(dbImageHMirror, Sender);
end;

procedure TForm1.btnVMirrorClick(Sender: TObject);
begin
  dbImage(dbImageVMirror, Sender);
end;

procedure TForm1.btnEmbossClick(Sender: TObject);
begin
  dbImage(dbImageEmboss, Sender);
end;

procedure TForm1.btnExposureClick(Sender: TObject);
begin
  dbImage(dbImageExposure, Sender);
end;

procedure TForm1.btnHVMirrorClick(Sender: TObject);
begin
  dbImage(dbImageHVMirror, Sender);
end;

procedure TForm1.btnRotateClick(Sender: TObject);
var
  bmpResult: HBITMAP;
  bmpdst   : TBitmap;
begin
  with TStopwatch.StartNew do
  begin
    Inc(FintRotateAngle);
    dbImageRotate(FbmpRotateBackup.Handle, bmpResult, FintRotateAngle);
    stat1.Panels[0].Text := Ifthen(not dbImageCheckChineseUI, Format('Time of picture %s：%d ms', [TButton(Sender).Caption, ElapsedMilliseconds]), Format('图片%s用时：%d 毫秒', [TButton(Sender).Caption, ElapsedMilliseconds]));

    bmpdst := TBitmap.Create;
    try
      hBmpToBmp(bmpResult, bmpdst);
      img1.Picture.Bitmap.Assign(bmpdst);
    finally
      bmpdst.Free;
    end;
  end;
  img1.Invalidate;
end;

procedure TForm1.btnSharpenClick(Sender: TObject);
begin
  dbImage(dbImageSharpen, Sender);
end;

procedure TForm1.btnSpongeClick(Sender: TObject);
begin
  dbImage(dbImageSponge, Sender);
end;

procedure TForm1.btnBlurClick(Sender: TObject);
begin
  dbImage(dbImageBlur, Sender);
end;

procedure TForm1.btnBrightnessClick(Sender: TObject);
var
  intTag   : Integer;
  strTemp01: String;
  strTemp02: String;
begin
  FButtonSelected := TButton(Sender);
  intTag          := TButton(Sender).Tag;
  strTemp01       := Ifthen(dbImageCheckChineseUI, c_strShowTipsCHS[intTag, 0], c_strShowTipsENG[intTag, 0]);
  strTemp02       := Ifthen(dbImageCheckChineseUI, c_strShowTipsCHS[intTag, 1], c_strShowTipsENG[intTag, 1]);
  ShowColorChange(Form1, TColorChange(intTag), OnColorChange, OnResetClick, OnCancelClick, OnOKClick, FlblLightValue, c_intMinMaxValue[intTag, 0], c_intMinMaxValue[intTag, 1], strTemp01, strTemp02);
end;

procedure TForm1.OnCancelClick(Sender: TObject);
begin
  img1.Picture.Bitmap.Canvas.Draw(0, 0, FbmpBackup);
  TForm(TButton(Sender).Parent).Close;
end;

procedure TForm1.OnColorChange(Sender: TObject);
var
  bmpTemp : TBitmap;
  ccChange: TColorChange;
begin
  FTrackColorChange      := TTrackBar(Sender);
  ccChange               := TColorChange(FTrackColorChange.Tag);
  FlblLightValue.Caption := InttoStr(FTrackColorChange.Position);

  bmpTemp := TBitmap.Create;
  try
    bmpTemp.PixelFormat := pf32bit;
    bmpTemp.width       := FbmpBackup.width;
    bmpTemp.height      := FbmpBackup.height;
    bmpTemp.Canvas.Draw(0, 0, FbmpBackup);

    with TStopwatch.StartNew do
    begin
      if ccChange = ccLight then
        dbImageLight(bmpTemp.Handle, FTrackColorChange.Position)                        // 调节亮度
      else if ccChange = ccContrast then                                                //
        dbImageContrast(bmpTemp.Handle, FTrackColorChange.Position)                     // 调节对比度
      else if ccChange = ccSaturation then                                              //
        dbImageSaturation(bmpTemp.Handle, FTrackColorChange.Position + 255)             // 调节饱和度
      else if ccChange = ccColorMode then                                               //
        dbImageColorMap(bmpTemp.Handle, FTrackColorChange.Position)                     // 调节色彩
      else if ccChange = ccTranslate then                                               //
        dbImageColorBlend(bmpTemp.Handle, FbmpTrans.Handle, FTrackColorChange.Position) // 调节透明度
      else if ccChange = ccGamma then                                                   //
        dbImageGamma(bmpTemp.Handle, FTrackColorChange.Position + 100);                 // 调节Gamma

      stat1.Panels[0].Text := Ifthen(not dbImageCheckChineseUI, Format('Time of picture %s：%d ms', [FButtonSelected.Caption, ElapsedMilliseconds]), Format('图片%s用时：%d 毫秒', [FButtonSelected.Caption, ElapsedMilliseconds]));
    end;
    img1.Picture.Bitmap.Assign(bmpTemp);
  finally
    bmpTemp.Free;
  end;
end;

procedure TForm1.OnOKClick(Sender: TObject);
begin
  BackupBmp;
  TForm(TButton(Sender).Parent).Close;
end;

procedure TForm1.OnResetClick(Sender: TObject);
begin
  if FTrackColorChange <> nil then
    FTrackColorChange.Position := 0;
end;

procedure TForm1.btnMosaicClick(Sender: TObject);
var
  bmpHandle   : HBITMAP;
  bmpDstHandle: HBITMAP;
  bmp         : TBitmap;
begin
  with TStopwatch.StartNew do
  begin
    bmpHandle := img1.Picture.Bitmap.Handle;
    dbImageMosaic(bmpHandle, bmpDstHandle);
    stat1.Panels[0].Text := Ifthen(not dbImageCheckChineseUI, Format('Time of picture %s：%d ms', [TButton(Sender).Caption, ElapsedMilliseconds]), Format('图片%s用时：%d 毫秒', [TButton(Sender).Caption, ElapsedMilliseconds]));
    bmp                  := TBitmap.Create;
    hBmpToBmp(bmpDstHandle, bmp);
    img1.Picture.Bitmap.Assign(bmp);
    bmp.Free;
  end;
end;

procedure TForm1.btnNosieClick(Sender: TObject);
begin
  dbImage(dbImageNoise, Sender);
end;

procedure TForm1.btnPosterizeClick(Sender: TObject);
begin
  dbImage(dbImagePosterize, Sender);
end;

end.
