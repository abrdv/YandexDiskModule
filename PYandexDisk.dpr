// JCL_DEBUG_EXPERT_INSERTJDBG OFF
// JCL_DEBUG_EXPERT_DELETEMAPFILE OFF
program PYandexDisk;

uses
  Vcl.Forms,
  UFormVIEW in 'UFormVIEW.pas' {FYandexDiskApp},
  UYandexRepository in 'UYandexRepository.pas',
  UBackUpModule in 'UBackUpModule.pas',
  uYandexThreadSpeech in 'uYandexThreadSpeech.pas',
  BASS in 'BASS.pas',
  BASSOPUS in 'BASSOPUS.pas',
  UConst in 'UConst.pas' {DMConst: TDataModule},
  UGui in 'UGui.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFYandexDiskApp, FYandexDiskApp);
  Application.CreateForm(TDMConst, DMConst);
  Application.Run;
end.
