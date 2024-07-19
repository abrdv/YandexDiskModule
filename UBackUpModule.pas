unit UBackUpModule;

interface

uses System.Classes, System.Generics.Collections, System.IOUtils, Contnrs,
  System.SysUtils, System.Types, System.DateUtils;

type
  TNotiFier = procedure (Sender: TObject; AEvent: string) of object;

  TBUFile = class
  private
    fpathlocal: String;
    procedure SetPathLocal(Value: String);
  public
    constructor Create(Sender: TObject); overload;
    constructor Create(Sender: TObject; APath: String); overload;
    destructor Destroy; override;

    property pathlocal: String read fpathlocal write SetPathLocal;
  end;

  TFilterExt = class (TList<String>)
  private
    fdelim: String;
  public
    constructor Create;
    destructor Destroy;
    procedure SetFilter(AFilterText: String = '');
    procedure AddFilter(AFilterText: String = '');
    procedure ClearFilter;
    function ToString(): String;
    property delim: String read fdelim write fdelim;
  end;

  TBUFiles = class
  private
    fdirlocal: String;
    fiszipped: Boolean;
    ffiles: TObjectList<TBUFile>;
    FOwner: TComponent;
    ffilterext: TFilterExt;
    FOnNotifyModel: TNotiFier;
    fIncludeSubDir: boolean;

    procedure Notify(const AEvent: String);
    procedure Setdirlocal(const Value: String);

    function FilterBySize(const Path: string; const SearchRec: TSearchRec)
      : boolean;
    function FilterByDateTime(const Path: string; const SearchRec: TSearchRec)
      : boolean;
    procedure FillListFiles;

    procedure AddFile(APath: String);
    procedure Delete(Value: Integer);
    procedure SetFilterExt(const Value: TFilterExt);
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;

    procedure Build(APath: String; AFilter: String = ''; IncludeSubDir: Boolean = false); overload;
    procedure Build(APath: String; AFilter: TFilterExt; IncludeSubDir: Boolean = false); overload;

    property IncludeSubDir: boolean read fIncludeSubDir;
    property dirlocal: String read fdirlocal write Setdirlocal;
    property filterext: TFilterExt read ffilterext;
    property iszipped: Boolean read fiszipped;
    property OnNotifireModel: TNotiFier read FOnNotifyModel write FOnNotifyModel;
    procedure SetFilterStr(const Value: String);

  end;

implementation

  { TFilterExt }

procedure TFilterExt.ClearFilter;
begin
  Clear;
  Add('*');
end;


constructor TFilterExt.Create;
begin
  inherited Create;
  delim := '|';
end;

destructor TFilterExt.Destroy;
begin
  inherited Destroy;
end;

procedure TFilterExt.SetFilter(AFilterText: String);
var filtervalue: String;
begin
  Clear;
  if AFilterText.IsEmpty then
    Add('*') else
    begin
      if AFilterText.IndexOf('|')>0 then
        begin
          for filtervalue in AFilterText.Split(['|']) do
            AddFilter(filtervalue);
        end
        else
        AddFilter(AFilterText);
    end;
end;

function TFilterExt.ToString: String;
var localdelim: string;
    sResult: string;
begin
  sResult := '';
  try
  if Count=0 then Exit
    else
    begin
    localdelim:='';
    for var sitem in ToArray() do
      begin
        sResult := sResult + localdelim + sitem;
        localdelim := delim;
      end;
    end;
  finally
    Result := sResult;
  end;
end;

procedure TFilterExt.AddFilter(AFilterText: String);
begin
  if Contains('*') then
    Delete(IndexOf('*'));
  if not Contains(AFilterText) then
    Add(AFilterText);
end;

{ TBUFiles }

function TBUFiles.FilterBySize(const Path: string;
    const SearchRec: TSearchRec): boolean;
begin
  //Возвращаем true, если размер файла меньше 50 Кбайт.
  Result := SearchRec.Size < 51200;
end;

function TBUFiles.FilterByDateTime(const Path: string;
    const SearchRec: TSearchRec): boolean;
begin
  //Возвращаем true, если у файла или директории
  //дата и время последнего изменения старше 2-х лет.
  Result := SearchRec.TimeStamp < IncYear(Now, -2);
end;

procedure TBUFiles.Setdirlocal(const Value: String);
begin
  fdirlocal := Value;
  FillListFiles;
end;

procedure TBUFiles.SetFilterExt(const Value: TFilterExt);
begin
  ffilterext := Value;
end;

procedure TBUFiles.SetFilterStr(const Value: String);
begin
  ffilterext.SetFilter(Value);
  FillListFiles;
end;

procedure TBUFiles.AddFile(APath: String);
var tValue: TBUFile;
begin
  if TFile.Exists(Apath) then
    begin
      tValue := TBUFile.Create;
      tValue.pathlocal:=APath;
      ffiles.Add(tValue);
      Notify('Add ' + tValue.pathlocal);
    end;
end;

procedure TBUFiles.Build(APath, AFilter: String; IncludeSubDir: Boolean);
begin
  ffilterext.SetFilter(AFilter);
  fdirlocal := APath;
  FillListFiles;
end;

procedure TBUFiles.FillListFiles;
var sfilepath: String;
    sfilter: String;
begin
  try
    //GetFileSystemEntries
    for sfilter in filterext do
      begin
        if IncludeSubDir then
           begin
            for sfilepath in TDirectory.GetFiles(dirlocal, sfilter, TSearchOption.soAllDirectories) do
              begin
                AddFile(sfilepath);
              end;
           end else
           begin
            for sfilepath in TDirectory.GetFiles(dirlocal, sfilter, TSearchOption.soTopDirectoryOnly) do
              begin
                AddFile(sfilepath);
              end;
           end;
    end;
  except
    on e: Exception do
    begin

    end;
  end;
end;

procedure TBUFiles.Build(APath: String; AFilter: TFilterExt;
  IncludeSubDir: Boolean);
begin
  if Assigned(AFilter) then
  ffilterext := AFilter else
  ffilterext.ClearFilter;
  fdirlocal := APath;
  FillListFiles;
end;

constructor TBUFiles.Create;
begin
  inherited Create;
  ffiles := TObjectList<TBUFile>.Create(True);
  ffilterext := TFilterExt.Create;
end;

procedure TBUFiles.Delete(Value: Integer);
begin
  if (Value < 0) then exit;
  if (Value > (ffiles.Count - 1)) then exit;
  ffiles.Delete(Value);
  Notify('Delete');
end;

destructor TBUFiles.Destroy;
begin
  ffiles.Clear;
  ffiles.Free;
  ffilterext.Clear;
  ffilterext.Free;
  inherited;
end;

procedure TBUFiles.Notify(const AEvent: String);
begin
  if Assigned(FOnNotifyModel) then FOnNotifyModel(Self, aEvent);
end;

{ TBUFile }

constructor TBUFile.Create(Sender: TObject);
begin
  inherited Create;
end;

constructor TBUFile.Create(Sender: TObject; APath: String);
begin
  inherited Create;
  pathlocal := APath;
end;

destructor TBUFile.Destroy;
begin
  inherited;
end;

procedure TBUFile.SetPathLocal(Value: String);
begin
  fpathlocal:=Value;
end;

end.
