/*
  ����(Func)����������ͼ����(High speed digital image processing)
  ����(Auth)��dbyoung@sina.com
  ʱ��(Time)��2020-10-01
  �汾(Vers): v4.0
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

	/* ���ϵͳ�Ƿ������Ĳ���ϵͳ */
	DLL_DBIMAGE BOOL dbImageCheckChineseUI();

	/* dbImage SDK ��ʼ�� */
	DLL_DBIMAGE void dbImageInit();

	/* dbImage SDK ж�� */
	DLL_DBIMAGE void dbImageFree();

	/* dbImage ͼƬ���� */
	DLL_DBIMAGE BOOL dbImageLoad(const char* strFileName, HBITMAP* bmpHandle);

	/* dbImage ͼƬ��ɫ */
	DLL_DBIMAGE void dbImageInvert(HBITMAP bmpHandle);

	/* dbImage ͼƬ�Ҷ� */
	DLL_DBIMAGE void dbImageGray(HBITMAP bmpHandle);

	/* dbImage ͼƬˮƽ���� */
	DLL_DBIMAGE void dbImageHMirror(HBITMAP bmpHandle);

	/* dbImage ͼƬ��ֱ���� */
	DLL_DBIMAGE void dbImageVMirror(HBITMAP bmpHandle);

	/* dbImage ͼƬת�� */
	DLL_DBIMAGE void dbImageHVMirror(HBITMAP bmpHandle);

	/* dbImage ͼƬ�ع� */
	DLL_DBIMAGE void dbImageExposure(HBITMAP bmpHandle);

	/* dbImage ͼƬ���� */
	DLL_DBIMAGE void dbImageEmboss(HBITMAP bmpHandle);

	/* dbImage ͼƬ�� */
	DLL_DBIMAGE void dbImageSharpen(HBITMAP bmpHandle);

	/* dbImage ͼƬģ�� */
	DLL_DBIMAGE void dbImageBlur(HBITMAP bmpHandle);

	/* dbImage ͼƬ�ͻ� */
	DLL_DBIMAGE void dbImageSponge(HBITMAP bmpHandle);

	/* dbImage ͼƬ�ڻ� */
	DLL_DBIMAGE void dbImagePosterize(HBITMAP bmpHandle);

	/* dbImage ͼƬ��� */
	DLL_DBIMAGE void dbImageNoise(HBITMAP bmpHandle);

	/* dbImage ͼƬ�������� */
	DLL_DBIMAGE void dbImageLight(HBITMAP bmpHandle, const int intLightValue);

	/* dbImage ͼƬ���ڶԱȶ� */
	DLL_DBIMAGE void dbImageContrast(HBITMAP bmpHandle, const int intLightValue);

	/* dbImage ͼƬ���ڱ��Ͷ� */
	DLL_DBIMAGE void dbImageSaturation(HBITMAP bmpHandle, const int intLightValue);

	/* dbImage ͼƬ����ɫ�� */
	DLL_DBIMAGE void dbImageColorMap(HBITMAP bmpHandle, const int intLightValue);

	/* dbImage ͼƬ����Gamma */
	DLL_DBIMAGE void dbImageGamma(HBITMAP bmpHandle, const int intGammaValue);

	/* dbImage ͼƬ����͸���� */
	DLL_DBIMAGE void dbImageColorBlend(HBITMAP bmpHandle, HBITMAP bmpTrans, const int intLightValue);

	/* dbImage ͼƬ��ת */
	DLL_DBIMAGE void dbImageRotate(HBITMAP bmpHandle, HBITMAP* bmpResult, const int intAngle);

	/* dbImage ͼƬ������ */
	DLL_DBIMAGE void dbImageMosaic(HBITMAP bmpHandle, HBITMAP* bmpDst);

#ifdef __cplusplus
}
#endif

#endif
