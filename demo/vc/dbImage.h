/*
  功能(Func)：高速数字图像处理(High speed digital image processing)
  作者(Auth)：dbyoung@sina.com
  时间(Time)：2020-10-01
  版本(Vers): v4.0
*/

#ifndef _DLL_DBIMAGE_H_
#define _DLL_DBIMAGE_H_

#include <Windows.h>

#define DLL_DBIMAGE __declspec(dllexport)

class CStopWatch
{
	public:
			CStopWatch();
			void start();
			void stop();
			double getElapsedTime(); 
	private:
			LARGE_INTEGER m_start;
			LARGE_INTEGER m_stop;
			LARGE_INTEGER m_frequency;
};

CStopWatch::CStopWatch()
{
    m_start.QuadPart = 0;
    m_stop.QuadPart = 0;
    QueryPerformanceFrequency(&m_frequency);
}

void CStopWatch::start()
{
    QueryPerformanceCounter(&m_start);
}

void CStopWatch::stop()
{
    QueryPerformanceCounter(&m_stop);
}

double CStopWatch::getElapsedTime()
{
    LARGE_INTEGER time;
    time.QuadPart = m_stop.QuadPart - m_start.QuadPart;
    return (double) 1000 * time.QuadPart / (double)m_frequency.QuadPart;
}

#ifdef __cplusplus
extern "C" {
#endif

	const char* cChangeType[6] = { "Change Brightness : ", "Change Contrast : ", "Change Saturation : ", "Change Color Map: ", "Change Blend: ", "Change Gamma : " };

	/* 检查系统是否是中文操作系统 */
	DLL_DBIMAGE BOOL dbImageCheckChineseUI();

	/* dbImage SDK 初始化 */
	DLL_DBIMAGE void dbImageInit();

	/* dbImage SDK 卸载 */
	DLL_DBIMAGE void dbImageFree();

	/* dbImage 图片加载 */
	DLL_DBIMAGE BOOL dbImageLoad(const char* strFileName, HBITMAP* bmpHandle);

	/* dbImage 图片反色 */
	DLL_DBIMAGE void dbImageInvert(HBITMAP bmpHandle);

	/* dbImage 图片灰度 */
	DLL_DBIMAGE void dbImageGray(HBITMAP bmpHandle);

	/* dbImage 图片水平镜像 */
	DLL_DBIMAGE void dbImageHMirror(HBITMAP bmpHandle);

	/* dbImage 图片垂直镜像 */
	DLL_DBIMAGE void dbImageVMirror(HBITMAP bmpHandle);

	/* dbImage 图片转置 */
	DLL_DBIMAGE void dbImageHVMirror(HBITMAP bmpHandle);

	/* dbImage 图片曝光 */
	DLL_DBIMAGE void dbImageExposure(HBITMAP bmpHandle);

	/* dbImage 图片浮雕 */
	DLL_DBIMAGE void dbImageEmboss(HBITMAP bmpHandle);

	/* dbImage 图片锐化 */
	DLL_DBIMAGE void dbImageSharpen(HBITMAP bmpHandle);

	/* dbImage 图片模糊 */
	DLL_DBIMAGE void dbImageBlur(HBITMAP bmpHandle);

	/* dbImage 图片油画 */
	DLL_DBIMAGE void dbImageSponge(HBITMAP bmpHandle);

	/* dbImage 图片壁画 */
	DLL_DBIMAGE void dbImagePosterize(HBITMAP bmpHandle);

	/* dbImage 图片噪点 */
	DLL_DBIMAGE void dbImageNoise(HBITMAP bmpHandle);

	/* dbImage 图片调节亮度 */
	DLL_DBIMAGE void dbImageLight(HBITMAP bmpHandle, const int intLightValue);

	/* dbImage 图片调节对比度 */
	DLL_DBIMAGE void dbImageContrast(HBITMAP bmpHandle, const int intLightValue);

	/* dbImage 图片调节饱和度 */
	DLL_DBIMAGE void dbImageSaturation(HBITMAP bmpHandle, const int intLightValue);

	/* dbImage 图片调节色彩 */
	DLL_DBIMAGE void dbImageColorMap(HBITMAP bmpHandle, const int intLightValue);

	/* dbImage 图片调节Gamma */
	DLL_DBIMAGE void dbImageGamma(HBITMAP bmpHandle, const int intGammaValue);

	/* dbImage 图片调节透明度 */
	DLL_DBIMAGE void dbImageColorBlend(HBITMAP bmpHandle, HBITMAP bmpTrans, const int intLightValue);

	/* dbImage 图片旋转 */
	DLL_DBIMAGE void dbImageRotate(HBITMAP bmpHandle, HBITMAP* bmpResult, const int intAngle);

	/* dbImage 图片马赛克 */
	DLL_DBIMAGE void dbImageMosaic(HBITMAP bmpHandle, HBITMAP* bmpDst);

#ifdef __cplusplus
}
#endif

#endif
