
// vcDlg.h : header file
//

#pragma once

typedef void (dbImageFunc)(HBITMAP);

// CvcDlg dialog
class CvcDlg : public CDialogEx
{
// Construction
public:
	CvcDlg(CWnd* pParent = nullptr);	// standard constructor
	~CvcDlg();

// Dialog Data
#ifdef AFX_DESIGN_TIME
	enum { IDD = IDD_VC_DIALOG };
#endif

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support


// Implementation
protected:
	HICON m_hIcon;
	CStatusBarCtrl m_StatusBar;

	HBITMAP m_bmpTran;
	int ChangeType = 0;
	int RotateAngle = 0;
	CBitmap bmpRotateBackup;
	CBitmap bmpBackup;

	CBitmap bmp;

	// Generated message map functions
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg LRESULT OnValueChange(WPARAM wparam, LPARAM lparam);
	DECLARE_MESSAGE_MAP()
public:
	void dbImage(dbImageFunc func);
	void DrawBitmap(CDC* pDC);
	void CommonChange(int iType, int iMinValue, int iMaxValue, int iPos);

	afx_msg void OnBnClickedButtonInvert();
	afx_msg void OnBnClickedButtonGray();
	afx_msg void OnBnClickedButtonRestore();
	afx_msg void OnBnClickedButtonHmirror();
	afx_msg void OnBnClickedButtonVmirror();
	afx_msg void OnBnClickedButtonHvmirror();
	afx_msg void OnBnClickedButtonRotate();
	afx_msg void OnBnClickedButtonExposure();
	afx_msg void OnBnClickedButtonEmboss();
	afx_msg void OnBnClickedButtonSharpen();
	afx_msg void OnBnClickedButtonBlur();
	afx_msg void OnBnClickedButtonSponge();
	afx_msg void OnBnClickedButtonPosterize();
	afx_msg void OnBnClickedButtonNoise();
	afx_msg void OnBnClickedButtonLight();
	afx_msg void OnBnClickedButtonContrast();
	afx_msg void OnBnClickedButtonSaturation();
	afx_msg void OnBnClickedButtonColormap();
	afx_msg void OnBnClickedButtonBlend();
	afx_msg void OnBnClickedButtonGamma();
	afx_msg void OnBnClickedButtonMosaic();
};
