unit UYandexRepository;

interface
uses UBackUpModule, UConst, UFormVIEW, System.Classes, VCL.Forms,
  FileCtrl, Vcl.Dialogs;

const
  pathapiroot = '';

type
  TUpdaterClick = procedure(Sender: TObject) of object;

  TYandexRepository = class
  private
    FModel: TBUFiles;
    FVIEW: TFYandexDiskApp;
  public
    constructor New;
    destructor Destroy; override;
    procedure UpdateModel;
    procedure UpdateView;
    procedure ShowView;
    procedure LoadData;
    procedure SaveAction(Sender: TObject);
    procedure CancelAction(Sender: TObject);
    procedure NotifyFromModel(Sender: TObject; AEvent: String);

    procedure BTDirAccessClick(Sender: TObject);
    procedure BTFilterAccessClick(Sender: TObject);
  end;

implementation
uses System.SysUtils;

{ TYandexRepository }

constructor TYandexRepository.New;
begin
  inherited Create;

  FModel := TBUFiles.Create(application);
  FModel.OnNotifireModel:= NotifyFromModel;

  FVIEW := TFYandexDiskApp.Create(application);
  FVIEW.btEnviar.OnClick:=Self.SaveAction;
  FVIEW.btCancel.OnClick:=Self.CancelAction;
  FVIEW.BTDirAccess.OnClick:=BTDirAccessClick;
  FVIEW.BTFilterAccess.OnClick:=BTFilterAccessClick;

  LoadData;
  UpdateView;
end;

destructor TYandexRepository.Destroy;
begin
  FreeAndNil(FModel);
  FreeAndNil(FVIEW);
  inherited Destroy;
end;

procedure TYandexRepository.LoadData;
begin
  FModel.Build(DMConst.AppDirPath, DMConst.FilterDef);
end;

procedure TYandexRepository.CancelAction(Sender: TObject);
begin
  if not Assigned(FVIEW) then Exit;
  FVIEW.Close;
end;

procedure TYandexRepository.ShowView;
begin
  if not Assigned(FVIEW) then Exit;
  FVIEW.ShowModal;
end;

procedure TYandexRepository.NotifyFromModel(Sender: TObject; AEvent: String);
begin
  if not Assigned(FVIEW) then Exit;
  if not Assigned(FVIEW.LBLog) then Exit;

  FVIEW.LBLog.Items.Add('Изменения > ' + Sender.ClassName + ' события ' + AEvent);
end;

procedure TYandexRepository.SaveAction(Sender: TObject);
begin
  UpdateModel;
end;

procedure TYandexRepository.UpdateModel;
begin
  if not Assigned(FVIEW) then Exit;
  if not Assigned(FModel) then Exit;
  FModel.dirlocal := FVIEW.dirlocal;
  FModel.SetFilterStr(FVIEW.filterlocal);
end;

procedure TYandexRepository.UpdateView;
begin
  if not Assigned(FVIEW) then Exit;
  if not Assigned(FModel) then Exit;
  FVIEW.dirlocal := FModel.dirlocal;
  FVIEW.filterlocal := FModel.filterext.ToString();
end;

procedure TYandexRepository.BTDirAccessClick(Sender: TObject);
var Dir: string;
begin
  Dir:='';
  if SelectDirectory(Dir, [sdAllowCreate, sdPerformCreate, sdPrompt], SELDIRHELP) then
  begin
    FVIEW.dirlocal := Dir;
    UpdateModel;
  end;
end;

procedure TYandexRepository.BTFilterAccessClick(Sender: TObject);
 var
  NewFilter: string;
  ClickedOK: Boolean;
begin
  NewFilter := FVIEW.filterlocal;
  ClickedOK := InputQuery('Ввод фильтра', 'Фильтр(разделитель |)', NewFilter);
  if ClickedOK then
    begin
      FVIEW.filterlocal := NewFilter;
      UpdateModel;
    end;
end;

end.
