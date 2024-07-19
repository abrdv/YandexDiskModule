unit UFormVIEW;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, System.IOUtils, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, FileCtrl, Vcl.WinXPanels,
  UConst
  //JvBaseDlg, JvSelectDirectory, cxShellBrowserDialog,  cxShellDlgs, cxClasses
  //cxShellCommon, JvBaseDlg, cxShellBrowserDialog, JvBrowseFolder, JvBaseDlg,
  ;
const
  SELDIRHELP = 1000;
  WM_TEXTMSG = WM_USER + 601;
type
  {
  //dialog message
  TFilterMessage =  record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    WParam: Integer;
    LParam: String;
    Result: LRESULT;
  end;
  }
  TFYandexDiskApp = class(TForm)
    LBLog: TListBox;
    Panel1: TPanel;
    Panel2: TPanel;
    Splitter1: TSplitter;
    btEnviar: TButton;
    btCancel: TButton;
    btRecibir: TButton;
    StackPanel1: TStackPanel;
    edirlocal: TEdit;
    BTDirAccess: TButton;
    efilterlocal: TEdit;
    BTFilterAccess: TButton;
    eDiskDir: TEdit;
    BTDirDisk: TButton;
  private
    fdirlocal: string;
    ffilterlocal: string;
    procedure SetDirLocal(const Value: string);
    procedure SetFilterLocal(const Value: string);
    function GetDirLocal: string;
    function GetFilterLocal: string;
  public
    property dirlocal: string read GetDirLocal write SetDirLocal;
    property filterlocal: string read GetFilterLocal write SetFilterLocal;

  end;

var
  FYandexDiskApp: TFYandexDiskApp;
implementation

{$R *.dfm}

function TFYandexDiskApp.GetDirLocal: string;
begin
  Result:=edirlocal.Text;
end;

function TFYandexDiskApp.GetFilterLocal: string;
begin
  Result:=efilterlocal.Text;
end;

procedure TFYandexDiskApp.SetDirLocal(const Value: string);
begin
  if Value <> fdirlocal then
  begin
    edirlocal.Text := Value;
  end;
end;

procedure TFYandexDiskApp.SetFilterLocal(const Value: string);
begin
  if Value <> ffilterlocal then
  begin
    efilterlocal.Text := Value;
  end;

end;

end.
