object FYandexDiskApp: TFYandexDiskApp
  Left = 0
  Top = 0
  Caption = #1071#1085#1076#1077#1082#1089' '#1044#1080#1089#1082' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1077
  ClientHeight = 442
  ClientWidth = 639
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Splitter1: TSplitter
    Left = 0
    Top = 161
    Width = 639
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 97
    ExplicitWidth = 304
  end
  object LBLog: TListBox
    Left = 0
    Top = 164
    Width = 639
    Height = 237
    Align = alClient
    ItemHeight = 15
    TabOrder = 0
    ExplicitWidth = 635
    ExplicitHeight = 236
  end
  object Panel1: TPanel
    Left = 0
    Top = 401
    Width = 639
    Height = 41
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 400
    ExplicitWidth = 635
    object btEnviar: TButton
      Left = 456
      Top = 6
      Width = 75
      Height = 25
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100
      TabOrder = 0
    end
    object btCancel: TButton
      Left = 544
      Top = 6
      Width = 75
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 1
    end
    object btRecibir: TButton
      Left = 368
      Top = 6
      Width = 75
      Height = 25
      Caption = #1055#1086#1083#1091#1095#1080#1090#1100
      TabOrder = 2
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 639
    Height = 161
    Align = alTop
    TabOrder = 2
    ExplicitWidth = 635
    object StackPanel1: TStackPanel
      Left = 1
      Top = 1
      Width = 637
      Height = 159
      Align = alClient
      ControlCollection = <
        item
          Control = edirlocal
        end
        item
          Control = BTDirAccess
        end
        item
          Control = efilterlocal
        end
        item
          Control = BTFilterAccess
        end
        item
          Control = eDiskDir
        end
        item
          Control = BTDirDisk
        end>
      HorizontalPositioning = sphpFill
      TabOrder = 0
      VerticalPositioning = spvpFill
      ExplicitWidth = 633
      object edirlocal: TEdit
        Left = 1
        Top = 1
        Width = 635
        Height = 23
        TabOrder = 0
      end
      object BTDirAccess: TButton
        Left = 1
        Top = 26
        Width = 635
        Height = 25
        Caption = #1042#1099#1073#1088#1072#1090#1100' '#1087#1072#1087#1082#1091
        TabOrder = 1
      end
      object efilterlocal: TEdit
        Left = 1
        Top = 53
        Width = 635
        Height = 23
        TabOrder = 2
      end
      object BTFilterAccess: TButton
        Left = 1
        Top = 78
        Width = 635
        Height = 20
        Caption = #1042#1099#1073#1088#1072#1090#1100' '#1092#1080#1083#1100#1090#1088
        TabOrder = 3
      end
      object eDiskDir: TEdit
        Left = 1
        Top = 100
        Width = 635
        Height = 23
        TabOrder = 4
      end
      object BTDirDisk: TButton
        Left = 1
        Top = 125
        Width = 635
        Height = 20
        Caption = #1042#1099#1073#1088#1072#1090#1100' '#1087#1072#1087#1082#1091' '#1074' '#1054#1073#1083#1072#1082#1077
        TabOrder = 5
      end
    end
  end
end
