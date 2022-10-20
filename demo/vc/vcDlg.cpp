
// vcDlg.cpp : implementation file
//

#include "pch.h"
#include "framework.h"
#include "vc.h"
#include "vcDlg.h"
#include "afxdialogex.h"
#include "dbImage.h"
#include "CChangeDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CAboutDlg dialog used for App About

class CAboutDlg : public CDialogEx
{
public:
	CAboutDlg();

// Dialog Data
#ifdef AFX_DESIGN_TIME
	enum { IDD = IDD_ABOUTBOX };
#endif

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support

// Implementation
protected:
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialogEx(IDD_ABOUTBOX)
{
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialogEx)
END_MESSAGE_MAP()


// CvcDlg dialog

CvcDlg::~CvcDlg()
{
	dbImageFree();
}

CvcDlg::CvcDlg(CWnd* pParent /*=nullptr*/)
	: CDialogEx(IDD_VC_DIALOG, pParent)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CvcDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CvcDlg, CDialogEx)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_MESSAGE(WM_TRACKCHANGING, OnValueChange)
	ON_BN_CLICKED(IDC_BUTTON_INVERT, &CvcDlg::OnBnClickedButtonInvert)
	ON_BN_CLICKED(IDC_BUTTON_GRAY, &CvcDlg::OnBnClickedButtonGray)
	ON_BN_CLICKED(IDC_BUTTON_RESTORE, &CvcDlg::OnBnClickedButtonRestore)
	ON_BN_CLICKED(IDC_BUTTON_HMIRROR, &CvcDlg::OnBnClickedButtonHmirror)
	ON_BN_CLICKED(IDC_BUTTON_VMIRROR, &CvcDlg::OnBnClickedButtonVmirror)
	ON_BN_CLICKED(IDC_BUTTON_HVMIRROR, &CvcDlg::OnBnClickedButtonHvmirror)
	ON_BN_CLICKED(IDC_BUTTON_ROTATE, &CvcDlg::OnBnClickedButtonRotate)
	ON_BN_CLICKED(IDC_BUTTON_EXPOSURE, &CvcDlg::OnBnClickedButtonExposure)
	ON_BN_CLICKED(IDC_BUTTON_EMBOSS, &CvcDlg::OnBnClickedButtonEmboss)
	ON_BN_CLICKED(IDC_BUTTON_SHARPEN, &CvcDlg::OnBnClickedButtonSharpen)
	ON_BN_CLICKED(IDC_BUTTON_BLUR, &CvcDlg::OnBnClickedButtonBlur)
	ON_BN_CLICKED(IDC_BUTTON_SPONGE, &CvcDlg::OnBnClickedButtonSponge)
	ON_BN_CLICKED(IDC_BUTTON_POSTERIZE, &CvcDlg::OnBnClickedButtonPosterize)
	ON_BN_CLICKED(IDC_BUTTON_NOISE, &CvcDlg::OnBnClickedButtonNoise)
	ON_BN_CLICKED(IDC_BUTTON_LIGHT, &CvcDlg::OnBnClickedButtonLight)
	ON_BN_CLICKED(IDC_BUTTON_CONTRAST, &CvcDlg::OnBnClickedButtonContrast)
	ON_BN_CLICKED(IDC_BUTTON_SATURATION, &CvcDlg::OnBnClickedButtonSaturation)
	ON_BN_CLICKED(IDC_BUTTON_COLORMAP, &CvcDlg::OnBnClickedButtonColormap)
	ON_BN_CLICKED(IDC_BUTTON_BLEND, &CvcDlg::OnBnClickedButtonBlend)
	ON_BN_CLICKED(IDC_BUTTON_GAMMA, &CvcDlg::OnBnClickedButtonGamma)
	ON_BN_CLICKED(IDC_BUTTON_MOSAIC, &CvcDlg::OnBnClickedButtonMosaic)
END_MESSAGE_MAP()


// CvcDlg message handlers

BOOL CvcDlg::OnInitDialog()
{
	CDialogEx::OnInitDialog();

	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != nullptr)
	{
		BOOL bNameValid;
		CString strAboutMenu;
		bNameValid = strAboutMenu.LoadString(IDS_ABOUTBOX);
		ASSERT(bNameValid);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon

	m_StatusBar.Create(WS_CHILD | WS_VISIBLE | SBT_OWNERDRAW, CRect(0, 0, 0, 0), this, 0);
	int strPartDim[2] = { 400, -1 }; 
	m_StatusBar.SetParts(2, strPartDim);

	dbImageInit();
	OnBnClickedButtonRestore();

	return TRUE;  // return TRUE  unless you set the focus to a control
}

void CvcDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialogEx::OnSysCommand(nID, lParam);
	}
}

void CvcDlg::OnPaint()
{
	if (IsIconic())
	{
		CPaintDC dc(this); // device context for painting

		SendMessage(WM_ICONERASEBKGND, reinterpret_cast<WPARAM>(dc.GetSafeHdc()), 0);

		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CPaintDC dc(this);
		DrawBitmap(GetDlgItem(IDC_STATIC)->GetDC());

		CDialogEx::OnPaint();
	}
}

// The system calls this function to obtain the cursor to display while the user drags
//  the minimized window.
HCURSOR CvcDlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}

void CvcDlg::DrawBitmap(CDC* pDC)
{
	CDC mdc;
	BITMAP bm;
	CRect rct;
	GetDlgItem(IDC_STATIC)->GetClientRect(&rct);

	bmp.GetBitmap(&bm);               
	mdc.CreateCompatibleDC(pDC);      
	mdc.SelectObject(&bmp);           
	pDC->SetStretchBltMode(HALFTONE); 
	pDC->StretchBlt(0, 0, rct.Width(), rct.Height(), &mdc, 0, 0, bm.bmWidth, bm.bmHeight, SRCCOPY);
}

void CopyCBitmapFromSrc(CBitmap* pBitmapDest, CBitmap* pBitmapSrc)
{
	CDC dcMemSrc;
	CDC dcMemDest;
	BITMAP bmpSrc;

	dcMemSrc.CreateCompatibleDC(NULL);
	dcMemSrc.SelectObject(pBitmapSrc);
	pBitmapSrc->GetBitmap(&bmpSrc);

	dcMemDest.CreateCompatibleDC(NULL);
	pBitmapDest->CreateCompatibleBitmap(&dcMemSrc, bmpSrc.bmWidth, bmpSrc.bmHeight);
	dcMemDest.SelectObject(pBitmapDest);

	dcMemDest.BitBlt(0, 0, bmpSrc.bmWidthBytes, bmpSrc.bmHeight, &dcMemSrc, 0, 0, SRCCOPY);

	dcMemSrc.DeleteDC();
	dcMemDest.DeleteDC();
}

void CvcDlg::OnBnClickedButtonRestore()
{
	CStopWatch time;
	CString cstr;

	time.start();
	HBITMAP bmpHandle;
	dbImageLoad("test.jpg", &bmpHandle);
	bmp.Attach(bmpHandle);
	time.stop();
	cstr.Format(_T("%.2f"), time.getElapsedTime());
	m_StatusBar.SetText(L"Time: " + cstr + "ms", 0, 0);

	DrawBitmap(GetDlgItem(IDC_STATIC)->GetDC());

	dbImageLoad("tran.jpg", &m_bmpTran);
	CopyCBitmapFromSrc(&bmpRotateBackup, &bmp);
	CopyCBitmapFromSrc(&bmpBackup, &bmp);
}

void CvcDlg::dbImage(dbImageFunc func)
{
	CStopWatch time;
	CString cstr;

	time.start();
	func((HBITMAP)bmp.GetSafeHandle());
	time.stop();
	cstr.Format(_T("%.2f"), time.getElapsedTime());
	m_StatusBar.SetText(L"Time: "+ cstr + "ms", 0, 0);

	DrawBitmap(GetDlgItem(IDC_STATIC)->GetDC());
}
void CvcDlg::OnBnClickedButtonInvert()
{
	dbImage(dbImageInvert);
}

void CvcDlg::OnBnClickedButtonGray()
{
	dbImage(dbImageGray);
}

void CvcDlg::OnBnClickedButtonHmirror()
{
	dbImage(dbImageHMirror);
}

void CvcDlg::OnBnClickedButtonVmirror()
{
	dbImage(dbImageVMirror);
}

void CvcDlg::OnBnClickedButtonHvmirror()
{
	dbImage(dbImageHVMirror);
}

void CvcDlg::OnBnClickedButtonExposure()
{
	dbImage(dbImageExposure);
}

void CvcDlg::OnBnClickedButtonEmboss()
{
	dbImage(dbImageEmboss);
}

void CvcDlg::OnBnClickedButtonSharpen()
{
	dbImage(dbImageSharpen);
}

void CvcDlg::OnBnClickedButtonBlur()
{
	dbImage(dbImageBlur);
}

void CvcDlg::OnBnClickedButtonSponge()
{
	dbImage(dbImageSponge);
}

void CvcDlg::OnBnClickedButtonPosterize()
{
	dbImage(dbImagePosterize);
}

void CvcDlg::OnBnClickedButtonNoise()
{
	dbImage(dbImageNoise);
}

void CvcDlg::OnBnClickedButtonRotate()
{
	CStopWatch time;
	CString cstr;
	time.start();

	RotateAngle++;
	HBITMAP hbmpdst = 0;
	dbImageRotate((HBITMAP)bmpRotateBackup.GetSafeHandle(), &hbmpdst, RotateAngle);
	time.stop();
	cstr.Format(_T("%.2f"), time.getElapsedTime());
	m_StatusBar.SetText(L"Time: " + cstr + "ms", 0, 0);

	bmp.Attach(hbmpdst);
	DrawBitmap(GetDlgItem(IDC_STATIC)->GetDC());
}

void CvcDlg::OnBnClickedButtonMosaic()
{
	CStopWatch time;
	CString cstr;
	time.start();

	HBITMAP hbmpdst = 0;
	dbImageMosaic((HBITMAP)bmpRotateBackup.GetSafeHandle(), &hbmpdst);
	time.stop();
	cstr.Format(_T("%.2f"), time.getElapsedTime());
	m_StatusBar.SetText(L"Time: " + cstr + "ms", 0, 0);

	bmp.Attach(hbmpdst);
	DrawBitmap(GetDlgItem(IDC_STATIC)->GetDC());
}

LRESULT CvcDlg::OnValueChange(WPARAM wparam, LPARAM lparam)
{
	CStopWatch time;
	CString cstr;

	CBitmap temp;
	CopyCBitmapFromSrc(&temp, &bmpBackup);

	time.start();
	if (ChangeType == 0)
		dbImageLight((HBITMAP)temp.GetSafeHandle(), (int)wparam);
	else if (ChangeType == 1)
		dbImageContrast((HBITMAP)temp.GetSafeHandle(), (int)wparam);
	else if (ChangeType == 2)
		dbImageSaturation((HBITMAP)temp.GetSafeHandle(), (int)wparam);
	else if (ChangeType == 3)
		dbImageColorMap((HBITMAP)temp.GetSafeHandle(), (int)wparam);
	else if (ChangeType == 4)
		dbImageColorBlend((HBITMAP)temp.GetSafeHandle(), m_bmpTran, (int)wparam);
	else if (ChangeType == 5)
		dbImageGamma((HBITMAP)temp.GetSafeHandle(), (int)wparam);
	time.stop();
	cstr.Format(_T("%.2f"), time.getElapsedTime());
	m_StatusBar.SetText(L"Time: " + cstr + "ms", 0, 0);

	bmp.Detach();
	bmp.Attach((HBITMAP)temp.GetSafeHandle());
	DrawBitmap(GetDlgItem(IDC_STATIC)->GetDC());

	return 0;
}

void CvcDlg::OnBnClickedButtonLight()
{
	CommonChange(0, -255, 255, 0);
}


void CvcDlg::OnBnClickedButtonContrast()
{
	CommonChange(1, -255, 255, 0);
}


void CvcDlg::OnBnClickedButtonSaturation()
{
	CommonChange(2, 0, 510, 255);
}

void CvcDlg::OnBnClickedButtonColormap()
{
	CommonChange(3, 0, 360, 0);
}

void CvcDlg::OnBnClickedButtonBlend()
{
	CommonChange(4, 0, 100, 0);
}

void CvcDlg::OnBnClickedButtonGamma()
{
	CommonChange(5, 100, 220, 100);
}

void CvcDlg::CommonChange(int iType, int iMinValue, int iMaxValue, int iPos)
{
	CString strValue;
	CString str = CString(cChangeType[iType]);
	USES_CONVERSION;

	ChangeType = iType;
	CChangeDlg* pDlg = new CChangeDlg;
	pDlg->Create(IDD_DIALOG_TRACK, this);
	pDlg->SetWindowText(A2CW(W2A(str)));
	pDlg->SetWindowPos(0, 0, 0, 0, 0, SWP_NOMOVE | SWP_NOSIZE);
	str.ReleaseBuffer();

	CSliderCtrl* csc = (CSliderCtrl*)pDlg->GetDlgItem(IDC_SLIDER1);
	csc->SetRange(iMinValue, iMaxValue, 1);
	csc->SetPos(iPos);
	strValue.Format(_T("%d"), iPos);
	CWnd* pWnd = (CWnd*)pDlg->GetDlgItem(IDC_STATIC);
	pWnd->SetWindowText((LPCTSTR)strValue);

	pDlg->m_hWndOwner = m_hWnd;
	pDlg->ShowWindow(SW_SHOW);
}

