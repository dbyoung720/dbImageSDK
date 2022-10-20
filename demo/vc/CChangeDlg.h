#pragma once
#include "afxdialogex.h"

#define WM_TRACKCHANGING (WM_USER + 0x1000)

// CChangeDlg dialog

class CChangeDlg : public CDialogEx
{
	DECLARE_DYNAMIC(CChangeDlg)

public:
	CChangeDlg(CWnd* pParent = nullptr);   // standard constructor
	virtual ~CChangeDlg();

// Dialog Data
#ifdef AFX_DESIGN_TIME
	enum { IDD = IDD_DIALOG_TRACK };
#endif

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support

	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnBnClickedReset();
	afx_msg void OnBnClickedOk();
	afx_msg void OnBnClickedCancel();
	afx_msg void OnHScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar);
};
