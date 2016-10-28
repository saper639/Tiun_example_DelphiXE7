object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 528
  ClientWidth = 780
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 780
    Height = 145
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object btConnect: TSpeedButton
      Left = 24
      Top = 91
      Width = 89
      Height = 30
      Caption = 'Connect'
      OnClick = btConnectClick
    end
    object btDisconnect: TSpeedButton
      Left = 179
      Top = 91
      Width = 89
      Height = 30
      Caption = 'Disconnect'
      OnClick = btDisconnectClick
    end
    object btSendCmd: TSpeedButton
      Left = 464
      Top = 91
      Width = 65
      Height = 30
      Caption = 'Send'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = btSendCmdClick
    end
    object Label1: TLabel
      Left = 341
      Top = 13
      Width = 47
      Height = 13
      Caption = 'Command'
    end
    object cbCommand: TComboBox
      Left = 341
      Top = 32
      Width = 188
      Height = 21
      TabOrder = 0
      Text = 'cbCommand'
      OnChange = cbCommandChange
    end
    object edHost: TLabeledEdit
      Left = 24
      Top = 32
      Width = 121
      Height = 21
      EditLabel.Width = 22
      EditLabel.Height = 13
      EditLabel.Caption = 'Host'
      TabOrder = 1
    end
    object edPort: TLabeledEdit
      Left = 179
      Top = 32
      Width = 89
      Height = 21
      EditLabel.Width = 20
      EditLabel.Height = 13
      EditLabel.Caption = 'Port'
      TabOrder = 2
    end
    object TimePicker: TDateTimePicker
      Left = 664
      Top = 32
      Width = 74
      Height = 21
      Date = 42669.710789456020000000
      Time = 42669.710789456020000000
      Kind = dtkTime
      TabOrder = 3
    end
    object DatePicker: TDateTimePicker
      Left = 560
      Top = 32
      Width = 89
      Height = 21
      Date = 42669.714731273150000000
      Time = 42669.714731273150000000
      TabOrder = 4
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 145
    Width = 780
    Height = 319
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Memo1: TMemo
      Left = 0
      Top = 0
      Width = 780
      Height = 319
      Align = alClient
      TabOrder = 0
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 464
    Width = 780
    Height = 64
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      780
      64)
    object btClearLog: TSpeedButton
      Left = 24
      Top = 18
      Width = 89
      Height = 30
      Anchors = [akLeft, akBottom]
      Caption = 'Clear'
      OnClick = btClearLogClick
    end
    object btExit: TSpeedButton
      Left = 675
      Top = 19
      Width = 89
      Height = 30
      Anchors = [akRight, akBottom]
      Caption = 'Exit'
      OnClick = btExitClick
      ExplicitLeft = 575
    end
  end
end
