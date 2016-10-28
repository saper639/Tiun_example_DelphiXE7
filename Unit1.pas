unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, IniFiles, Vcl.ComCtrls,
  System.DateUtils;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    btConnect: TSpeedButton;
    btDisconnect: TSpeedButton;
    btSendCmd: TSpeedButton;
    Label1: TLabel;
    cbCommand: TComboBox;
    edHost: TLabeledEdit;
    edPort: TLabeledEdit;
    Panel2: TPanel;
    Memo1: TMemo;
    Panel3: TPanel;
    btClearLog: TSpeedButton;
    btExit: TSpeedButton;
    TimePicker: TDateTimePicker;
    DatePicker: TDateTimePicker;
    procedure FormCreate(Sender: TObject);
    procedure btExitClick(Sender: TObject);
    procedure btClearLogClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btConnectClick(Sender: TObject);
    procedure btSendCmdClick(Sender: TObject);
    procedure btDisconnectClick(Sender: TObject);
    procedure cbCommandChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetControlsStatus(Connected: boolean);
    function  ReadIniFile: boolean;
  end;

var
  Form1: TForm1;

const
   KeyCmd      = 'cmd';
   KeyArg      = 'arg';
   KeyAnswer   = 'answer';
   KeyBody     = 'body';
   KeyAdres    = 'address';
   KeySMS      = 'sms';
   KeyDate     = 'date';
   KeyCommand     = 'command';
   Keydescription = 'description';
   KeyID       = '_id';
   KeyContacts = 'contacts';
   KeyPhones   = 'phones';

   CmdGetSmsCount    = 'getsmscount';
   CmdGetSMS         = 'getsms';
   CmdGetSMSLast     = 'getsmslast';
   CmdGetCallCount   = 'getcallcount';
   CmdGetCall        = 'getcall';
   CmdGetCallLast    = 'getcalllast';
   CmdSendSMS        = 'sendsms';
   CmdMakeCall       = 'makecall';
   CmdGetCmdList     = 'cmdlist'; // ������ ������ ������
   CmdGetContact     = 'getcontact';
   CmdGetSMSAfter    = 'getsmsafter';
   CmdGetCallAfter      = 'getcallafter';

   SmsTypeDraft = 'draft'; SmsTypeFailed = 'failed'; SmsTypeInbox = 'inbox'; SmsTypeOutBox = 'outbox';
   SmsTypeQueued = 'queued'; SmsTypeSent = 'sent';

   CallTypeIncoming = 'incoming'; CallTypeOutgoing = 'outgoing'; CallTypeMissed = 'missed';
   CallTypeVoiceMail = 'voicemail';

  procedure LogOut(LogStr:string);

implementation

{$R *.dfm}

uses Unit2;

procedure LogOut(LogStr:string);
var log_f:TextFile;
begin
   LogStr := DateTimeToStr(now) + ' ' + LogStr;
   Form1.Memo1.Lines.Add(LogStr);
end;

procedure TForm1.btClearLogClick(Sender: TObject);
begin
   Memo1.Clear;
end;

procedure TForm1.btConnectClick(Sender: TObject);
var Host: string; Port: word;
begin
   Host := edHost.Text;
   Port := StrToInt(edPort.Text);
   Manager.ConnectToPhone(Host, Port);
end;

procedure TForm1.btDisconnectClick(Sender: TObject);
begin
   Manager.DisconnectFromPhone;
end;

procedure TForm1.btExitClick(Sender: TObject);
begin
   Close;
end;

procedure TForm1.btSendCmdClick(Sender: TObject);
var Cmd: string; DT : TDateTime; UMSec: int64;
begin
   if (cbCommand.Text = CmdGetSMSAfter) or (cbCommand.Text = CmdGetCallAfter) then
   begin
      DT := Trunc(DatePicker.Date) + TimeOf(TimePicker.Time);
      UMSec := DateTimeToUnix(DT) * 1000; // time in millisecond
      Cmd := cbCommand.Text + ' ' + IntToStr(UMSec);
   end else Cmd := cbCommand.Text;
   Manager.SendToPhone(Cmd);
end;

procedure TForm1.cbCommandChange(Sender: TObject);
begin
   if (cbCommand.Text = CmdGetSMSAfter) or (cbCommand.Text = CmdGetCallAfter) then
   begin
      DatePicker.Visible := True;
      TimePicker.Visible := True;
   end else
   begin
      DatePicker.Visible := False;
      TimePicker.Visible := False;
   end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var FileName: string; IniFile: TIniFile;
begin
   FileName := ExtractFilePath(Application.ExeName) + 'Config.ini';
   try
      IniFile := TIniFile.Create(FileName);
      IniFile.WriteString('Phone', 'Host', edHost.Text);
      IniFile.WriteInteger('Phone', 'Port', StrToInt(edPort.Text));
   except
      LogOut('Error write settings to ini file');
      Exit;
   end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

   SetControlsStatus(False);

   cbCommand.Items.Add(CmdGetCmdList);
   cbCommand.Items.Add(CmdGetSmsCount);
   cbCommand.Items.Add(CmdGetSMS);
   cbCommand.Items.Add(CmdGetSMSLast);
   cbCommand.Items.Add(CmdGetSMSAfter);
   cbCommand.Items.Add(CmdGetCallCount);
   cbCommand.Items.Add(CmdGetCall);
   cbCommand.Items.Add(CmdGetCallLast);
   cbCommand.Items.Add(CmdGetCallAfter);
   cbCommand.Items.Add(CmdSendSMS);
   cbCommand.Items.Add(CmdMakeCall);
   cbCommand.Items.Add(CmdGetContact);
   cbCommand.ItemIndex := 0;
   ReadIniFile;
   Manager := TManager.Create;
   DatePicker.Visible := False;
   TimePicker.Visible := False;
   DatePicker.DateTime := Now;
   TimePicker.DateTime  := Now;
end;

function TForm1.ReadIniFile: boolean;
var   IniFile : TIniFile; FileName:string;
      Port: word;
begin
   Result := False;
   FileName := ExtractFilePath(Application.ExeName) + 'Config.ini';
   if FileExists(FileName) then
   begin
      IniFile := TIniFile.Create(FileName);
      edHost.Text    := IniFile.ReadString('Phone','Host','');
      Port           := IniFile.ReadInteger('Phone','Port',0);
      edPort.Text := IntToStr(Port);
      IniFile.Free;
   end;
   Result := True;
end;

procedure TForm1.SetControlsStatus(Connected: boolean);
begin
   if Connected then
   begin
      btDisconnect.Enabled := True;
      btConnect.Enabled := False;
      btSendCmd.Enabled := True;
   end else
   begin
      btDisconnect.Enabled := False;
      btConnect.Enabled := True;
      btSendCmd.Enabled := False;
   end;
end;

end.
