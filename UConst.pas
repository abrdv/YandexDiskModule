unit UConst;

interface

uses
  System.SysUtils, System.Classes, System.IOUtils;

type
  TDMConst = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private
    fAppDirPath: String;
    fFilterDef: String;
    procedure SetAppDirPath(Value: string);
    procedure SetFilterDef(const Value: String);
  public
    property AppDirPath: String read fAppDirPath write SetAppDirPath;
    property FilterDef: String read fFilterDef write SetFilterDef;
  end;

var
  DMConst: TDMConst;
implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMConst.DataModuleCreate(Sender: TObject);
begin
  AppDirPath:=ExtractFilePath(ParamStr(0));
  FilterDef := '*.pas|*.dpr|*.dfm|*.dcu|*.exe';
end;

procedure TDMConst.SetAppDirPath(Value: string);
begin
  fAppDirPath:=ExtractFilePath(ParamStr(0));
end;

procedure TDMConst.SetFilterDef(const Value: String);
begin
  fFilterDef := '*.pas|*.dpr|*.dfm|*.dcu|*.exe';
end;

end.
