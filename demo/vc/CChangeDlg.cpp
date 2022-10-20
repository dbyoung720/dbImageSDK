// CChangeDlg.cpp : implementation file
//

#include "pch.h"
#include "vc.h"
#include "afxdialogex.h"
#include "CChangeDlg.h"

// CChangeDlg dialog

IMPLEMENT_DYNAMIC(CChangeDlg, CDialogEx)

CChangeDlg::CChangeDlg(CWnd* pParent /*=nullptr*/)
	: CDialogEx(IDD_DIALOG_TRACK, pParent)
{

}

CChangeDlg::~CChangeDlg()
{
}

void CChangeDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
}


BEGIN_MESSAGE_MAP(CChangeDlg, CDialogEx)
	ON_BN_CLICKED(ID_RESET, &CChangeDlg::OnBnClickedReset)
	ON_BN_CLICKED(IDOK, &CChangeDlg::OnBnClickedOk)
	ON_BN_CLICKED(IDCANCEL, &CChangeDlg::OnBnClickedCancel)
	ON_WM_HSCROLL()
END_MESSAGE_MAP()


// CChangeDlg message handlers


void CChangeDlg::OnBnClickedReset()
{
	// TODO: Add your control notification handler code here
}


void CChangeDlg::OnBnClickedOk()
{
	// TODO: Add your control notification handler code here
	CDialogEx::OnOK();
}


void CChangeDlg::OnBnClickedCancel()
{
	// TODO: Add your control notification handler code here
	CDialogEx::OnCancel();
}



void CChangeDlg::OnHScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar)
{
	CSliderCtrl* pSlidCtrl = (CSliderCtrl*)GetDlgItem(IDC_SLIDER1);
	CString str;
	int iValue = pSlidCtrl->GetPos();
	str.Format(_T("%d"), iValue);
	CWnd* pWnd = GetDlgItem(IDC_STATIC);
	pWnd->SetWindowText((LPCTSTR)str);
	::PostMessage(m_hWndOwner, WM_TRACKCHANGING, iValue, 0);

	CDialogEx::OnHScroll(nSBCode, nPos, pScrollBar);
}
