unit mainunit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Menus, StdCtrls, ToolWin, ExtCtrls, Buttons, ImgList, enigmaunit,shellapi;

type
  TMainForm = class(TForm)
    EnigmaPageControl: TPageControl;
    EnigmaMainSheet: TTabSheet;
    EnigmaConfigSheet: TTabSheet;
    MainMenu1: TMainMenu;
    Enigma1: TMenuItem;
    Hilfe1: TMenuItem;
    Info1: TMenuItem;
    Hilfe2: TMenuItem;
    N1: TMenuItem;
    Beenden1: TMenuItem;
    GroupBox1: TGroupBox;
    ThreeRotorsRadioButton: TRadioButton;
    FourRotorsRadioButton: TRadioButton;
    GroupBox2: TGroupBox;
    ReflectorBRadioButton: TRadioButton;
    ReflectorCRadioButton: TRadioButton;
    GroupBox4: TGroupBox;
    BetaRadioButton: TRadioButton;
    GammaRadioButton: TRadioButton;
    N2: TMenuItem;
    Einstellung1: TMenuItem;
    ToolBar1: TToolBar;
    EnigmaToolButton: TToolButton;
    PreferencesToolButton: TToolButton;
    InfoToolButton: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    HelpToolButton: TToolButton;
    ExitToolButton: TToolButton;
    ToolButton2: TToolButton;
    EnigmaMaschine1: TMenuItem;
    N3: TMenuItem;
    Rotor3Edit: TEdit;
    Rotor2UpDown: TUpDown;
    Rotor3UpDown: TUpDown;
    Rotor2Edit: TEdit;
    Panel1: TPanel;
    QKeyButton: TSpeedButton;
    WKeyButton: TSpeedButton;
    EKeyButton: TSpeedButton;
    RKeyButton: TSpeedButton;
    TKeyButton: TSpeedButton;
    ZKeyButton: TSpeedButton;
    UKeyButton: TSpeedButton;
    IKeyButton: TSpeedButton;
    OKeyButton: TSpeedButton;
    AKeyButton: TSpeedButton;
    DKeyButton: TSpeedButton;
    FKeyButton: TSpeedButton;
    GKeyButton: TSpeedButton;
    HKeyButton: TSpeedButton;
    JKeyButton: TSpeedButton;
    KKeyButton: TSpeedButton;
    PKeyButton: TSpeedButton;
    YKeyButton: TSpeedButton;
    XKeyButton: TSpeedButton;
    CKeyButton: TSpeedButton;
    VKeyButton: TSpeedButton;
    BKeyButton: TSpeedButton;
    NKeyButton: TSpeedButton;
    MKeyButton: TSpeedButton;
    LKeyButton: TSpeedButton;
    Panel2: TPanel;
    Label1: TLabel;
    QLight: TSpeedButton;
    WLight: TSpeedButton;
    ELight: TSpeedButton;
    RLight: TSpeedButton;
    TLight: TSpeedButton;
    ZLight: TSpeedButton;
    ULight: TSpeedButton;
    ILight: TSpeedButton;
    OLight: TSpeedButton;
    ALight: TSpeedButton;
    SLight: TSpeedButton;
    DLight: TSpeedButton;
    FLight: TSpeedButton;
    GLight: TSpeedButton;
    HLight: TSpeedButton;
    JLight: TSpeedButton;
    KLight: TSpeedButton;
    PLight: TSpeedButton;
    YLight: TSpeedButton;
    XLight: TSpeedButton;
    CLight: TSpeedButton;
    VLight: TSpeedButton;
    BLight: TSpeedButton;
    NLight: TSpeedButton;
    MLight: TSpeedButton;
    LLight: TSpeedButton;
    ToolbarImages: TImageList;
    Rotor1Edit: TEdit;
    Rotor1UpDown: TUpDown;
    LightImages: TImageList;
    DarkImages: TImageList;
    GroupBox3: TGroupBox;
    PlugBoardMemo: TMemo;
    UseButton: TButton;
    Label2: TLabel;
    TabSheet1: TTabSheet;
    DebugOutputRichEdit: TRichEdit;
    Button2: TButton;
    GroupBox5: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Rotor1ComboBox: TComboBox;
    Rotor3ComboBox: TComboBox;
    Rotor2ComboBox: TComboBox;
    Debug1: TMenuItem;
    DebugButton: TToolButton;
    Rotor1RingSettingEdit: TEdit;
    Rotor1RingUpDown: TUpDown;
    Rotor2RingSettingEdit: TEdit;
    Rotor2RingUpDown: TUpDown;
    Rotor3RingSettingEdit: TEdit;
    Rotor3RingUpDown: TUpDown;
    Rotor4Edit: TEdit;
    Rotor4RingSettingEdit: TEdit;
    Rotor4RingUpDown: TUpDown;
    Rotor4UpDown: TUpDown;
    SKeyButton: TSpeedButton;
    InputEdit: TRichEdit;
    OutputEdit: TRichEdit;
    Label6: TLabel;
    procedure Beenden1Click(Sender: TObject);
    procedure Info1Click(Sender: TObject);
    procedure Einstellung1Click(Sender: TObject);
    procedure EnigmaMaschine1Click(Sender: TObject);
    procedure ShowDarkImage(Button: TSpeedButton;ImageIndex: Integer);
    procedure ShowLightImage(Button: TSpeedButton; ImageIndex: Integer);
    procedure FourRotorsRadioButtonClick(Sender: TObject);
    procedure ThreeRotorsRadioButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Rotor2UpDownChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Smallint; Direction: TUpDownDirection);
    procedure Rotor3UpDownChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Smallint; Direction: TUpDownDirection);
    procedure UseButtonClick(Sender: TObject);
    procedure KeyBoardClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Debug1Click(Sender: TObject);
    procedure LightButton(C: Char);
    procedure DarkButton(C: Char);
    procedure ButtonMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ButtonMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Rotor4UpDownChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Smallint; Direction: TUpDownDirection);
    procedure Hilfe2Click(Sender: TObject);
    procedure PlugBoardLabelClick(Sender: TObject);
    procedure Rotor1UpDownChangingEx(Sender: TObject;
      var AllowChange: Boolean; NewValue: Smallint;
      Direction: TUpDownDirection);
  private
     EnigmaMachine: TEnigmaMachine;
     LightLetter: Char;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  MainForm: TMainForm;

implementation

uses aboutunit;

{$R *.DFM}

procedure TMainForm.Beenden1Click(Sender: TObject);
begin
 Application.Terminate;
end;

procedure TMainForm.Info1Click(Sender: TObject);
begin
  AboutForm.ShowModal;
end;


procedure TMainForm.ShowDarkImage(Button: TSpeedButton;ImageIndex: Integer);
var
  Bitmap: TBitmap;
begin
  Bitmap:=TBitmap.Create;
  DarkImages.GetBitmap(ImageIndex,Bitmap);
  Button.Glyph:=Bitmap;
  Bitmap.Free;
end;

procedure TMainForm.KeyBoardClick(Sender: TObject);
var
  PlainLetter: Char;
  CryptLetter: Char;
begin
 PlainLetter:=(Sender as TSpeedButton).Hint[1];
 InputEdit.Text:=InputEdit.Text+PlainLetter;
 EnigmaMachine.Rotor1.Position:=Rotor1Edit.Text[1];
 EnigmaMachine.Rotor2.Position:=Rotor2Edit.Text[1];
 EnigmaMachine.Rotor3.Position:=Rotor3Edit.Text[1];

 EnigmaMachine.Rotor1.RingSetting:=StrToInt(Rotor1RingSettingEdit.Text);
 EnigmaMachine.Rotor2.RingSetting:=StrToInt(Rotor2RingSettingEdit.Text);
 EnigmaMachine.Rotor3.RingSetting:=StrToInt(Rotor3RingSettingEdit.Text);
 if FourRotorsRadioButton.Checked=True then begin
   EnigmaMachine.Rotor4.Position:=Rotor4Edit.Text[1];
   EnigmaMachine.Rotor4.RingSetting:=StrToInt(Rotor4RingSettingEdit.Text);
 end;
 CryptLetter:=EnigmaMachine.Crypt(PlainLetter);
 LightLetter:=CryptLetter;
 OutputEdit.Text:=OutputEdit.Text+CryptLetter;
 Rotor1Edit.Text:=EnigmaMachine.Rotor1.Position;
 Rotor2Edit.Text:=EnigmaMachine.Rotor2.Position;
 Rotor3Edit.Text:=EnigmaMachine.Rotor3.Position;
 Rotor4Edit.Text:=EnigmaMachine.Rotor4.Position;
 DebugOutputRichEdit.Text:=EnigmaMachine.DebugOutPut;
end;

procedure TMainForm.ShowLightImage(Button: TSpeedButton;ImageIndex: Integer);
var
  Bitmap: TBitmap;
begin
  Bitmap:=TBitmap.Create;
  LightImages.GetBitmap(ImageIndex,Bitmap);
  Button.Glyph:=Bitmap;
  Bitmap.Free;
end;


procedure TMainForm.PlugBoardLabelClick(Sender: TObject);
begin
  //
end;

procedure TMainForm.Einstellung1Click(Sender: TObject);
begin
  EnigmaPageControl.ActivePageIndex:=1;
end;

procedure TMainForm.EnigmaMaschine1Click(Sender: TObject);
begin
  EnigmaPageControl.ActivePageIndex:=0;
end;

procedure TMainForm.FourRotorsRadioButtonClick(Sender: TObject);
begin
  BetaRadioButton.Enabled:=True;
  GammaRadioButton.Enabled:=True;
end;

procedure TMainForm.ThreeRotorsRadioButtonClick(Sender: TObject);
begin
  BetaRadioButton.Enabled:=False;
  GammaRadioButton.Enabled:=False;
end;


procedure TMainForm.LightButton(C: Char);
begin
  case C of
  'A':   ShowLightImage(ALight,0);
  'B':   ShowLightImage(BLight,1);
  'C':   ShowLightImage(CLight,2);
  'D':   ShowLightImage(DLight,3);
  'E':   ShowLightImage(ELight,4);
  'F':   ShowLightImage(FLight,5);
  'G':   ShowLightImage(GLight,6);
  'H':   ShowLightImage(HLight,7);
  'I':   ShowLightImage(ILight,8);
  'J':   ShowLightImage(JLight,9);
  'K':   ShowLightImage(KLight,10);
  'L':   ShowLightImage(LLight,11);
  'M':   ShowLightImage(MLight,12);
  'N':   ShowLightImage(NLight,13);
  'O':   ShowLightImage(OLight,14);
  'P':   ShowLightImage(PLight,15);
  'Q':   ShowLightImage(QLight,16);
  'R':   ShowLightImage(RLight,17);
  'S':   ShowLightImage(SLight,18);
  'T':   ShowLightImage(TLight,19);
  'U':   ShowLightImage(ULight,20);
  'V':   ShowLightImage(VLight,21);
  'W':   ShowLightImage(WLight,22);
  'X':   ShowLightImage(XLight,23);
  'Y':   ShowLightImage(YLight,24);
  'Z':   ShowLightImage(ZLight,25);
  end;
end;

procedure TMainForm.DarkButton(C: Char);
begin
  case C of
  'A':   ShowDarkImage(ALight,0);
  'B':   ShowDarkImage(BLight,1);
  'C':   ShowDarkImage(CLight,2);
  'D':   ShowDarkImage(DLight,3);
  'E':   ShowDarkImage(ELight,4);
  'F':   ShowDarkImage(FLight,5);
  'G':   ShowDarkImage(GLight,6);
  'H':   ShowDarkImage(HLight,7);
  'I':   ShowDarkImage(ILight,8);
  'J':   ShowDarkImage(JLight,9);
  'K':   ShowDarkImage(KLight,10);
  'L':   ShowDarkImage(LLight,11);
  'M':   ShowDarkImage(MLight,12);
  'N':   ShowDarkImage(NLight,13);
  'O':   ShowDarkImage(OLight,14);
  'P':   ShowDarkImage(PLight,15);
  'Q':   ShowDarkImage(QLight,16);
  'R':   ShowDarkImage(RLight,17);
  'S':   ShowDarkImage(SLight,18);
  'T':   ShowDarkImage(TLight,19);
  'U':   ShowDarkImage(ULight,20);
  'V':   ShowDarkImage(VLight,21);
  'W':   ShowDarkImage(WLight,22);
  'X':   ShowDarkImage(XLight,23);
  'Y':   ShowDarkImage(YLight,24);
  'Z':   ShowDarkImage(ZLight,25);
  end;
end;


procedure TMainForm.Rotor2UpDownChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
begin
  case Direction of
  updUP:  begin
            if Rotor2Edit.Text[1]='Z' then Rotor2Edit.Text:='A' else
            Rotor2Edit.Text:=chr (ord(Rotor2Edit.Text[1])+1);
          end;

  updDOWN:
          if Rotor2Edit.Text[1]='A' then Rotor2Edit.Text:='Z' else
          Rotor2Edit.Text:=chr (ord(Rotor2Edit.Text[1])-1)
   end;

end;

procedure TMainForm.Rotor3UpDownChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
begin
  case Direction of
  updUP:  begin
            if Rotor3Edit.Text[1]='Z' then Rotor3Edit.Text:='A' else
            Rotor3Edit.text:=chr (ord(Rotor3Edit.text[1])+1);
          end;

  updDOWN:
          if Rotor3Edit.Text[1]='A' then Rotor3Edit.Text:='Z' else
          Rotor3Edit.Text:=chr (ord(Rotor3Edit.Text[1])-1)
   end;

end;


procedure TMainForm.FormCreate(Sender: TObject);
begin
  Rotor1ComboBox.ItemIndex:=0;
  Rotor2ComboBox.ItemIndex:=1;
  Rotor3ComboBox.ItemIndex:=2;
  EnigmaMachine:=TEnigmaMachine.Create;
  UseButtonClick(Sender);
end;

procedure TMainForm.UseButtonClick(Sender: TObject);
var
  i: Integer;
  s: String;
begin
  if ThreeRotorsRadioButton.Checked=True then begin
     EnigmaMachine.RotorCount:=rc3;
     Rotor4Edit.Visible:=False;
     Rotor4RingSettingEdit.Visible:=False;
     Rotor4UpDown.Visible:=False;
     Rotor4RingUpDown.Visible:=False;

     if ReflectorBRadioButton.Checked=True then EnigmaMachine.Reflector.Reflectortype:=refNormalB
     else if ReflectorCRadioButton.Checked=True then EnigmaMachine.Reflector.Reflectortype:=refNormalC;
  end
  else begin
    Rotor4Edit.Visible:=True;
    Rotor4RingSettingEdit.Visible:=True;
    Rotor4UpDown.Visible:=True;
    Rotor4RingUpDown.Visible:=True;

    EnigmaMachine.RotorCount:=rc4;
    if ReflectorBRadioButton.Checked=True then EnigmaMachine.Reflector.Reflectortype:=refThinB
    else if ReflectorCRadioButton.Checked=True then EnigmaMachine.Reflector.Reflectortype:=refThinC;
    if BetaRadioButton.Checked=True then EnigmaMachine.Rotor4.RotorType:=rtBeta
    else if GammaRadioButton.Checked=True then EnigmaMachine.Rotor4.RotorType:=rtGamma;
  end;
  case Rotor1ComboBox.ItemIndex of
       0: EnigmaMachine.Rotor1.RotorType:=rt1;
       1: EnigmaMachine.Rotor1.RotorType:=rt2;
       2: EnigmaMachine.Rotor1.RotorType:=rt3;
       3: EnigmaMachine.Rotor1.RotorType:=rt4;
       4: EnigmaMachine.Rotor1.RotorType:=rt5;
       5: EnigmaMachine.Rotor1.RotorType:=rt6;
       6: EnigmaMachine.Rotor1.RotorType:=rt7;
       7: EnigmaMachine.Rotor1.RotorType:=rt8;
  end;
  case Rotor2ComboBox.ItemIndex of
       0: EnigmaMachine.Rotor2.RotorType:=rt1;
       1: EnigmaMachine.Rotor2.RotorType:=rt2;
       2: EnigmaMachine.Rotor2.RotorType:=rt3;
       3: EnigmaMachine.Rotor2.RotorType:=rt4;
       4: EnigmaMachine.Rotor2.RotorType:=rt5;
       5: EnigmaMachine.Rotor2.RotorType:=rt6;
       6: EnigmaMachine.Rotor2.RotorType:=rt7;
       7: EnigmaMachine.Rotor2.RotorType:=rt8;
  end;
  case Rotor3ComboBox.ItemIndex of
       0: EnigmaMachine.Rotor3.RotorType:=rt1;
       1: EnigmaMachine.Rotor3.RotorType:=rt2;
       2: EnigmaMachine.Rotor3.RotorType:=rt3;
       3: EnigmaMachine.Rotor3.RotorType:=rt4;
       4: EnigmaMachine.Rotor3.RotorType:=rt5;
       5: EnigmaMachine.Rotor3.RotorType:=rt6;
       6: EnigmaMachine.Rotor3.RotorType:=rt7;
       7: EnigmaMachine.Rotor3.RotorType:=rt8;
  end;
  s:='';
  for i:=0 to PlugBoardMemo.Lines.Count-1 do begin
    if Length(PlugBoardMemo.Lines[i])=2 then s:=s+' '+PlugBoardMemo.Lines[i] else
    PlugboardMemo.Lines.Delete(i);
  end;
  EnigmaMachine.PlugBoardSettings:=Copy(s,2,Length(S)-1);
end;

procedure TMainForm.Button2Click(Sender: TObject);
begin
  DebugOutputRichEdit.Lines.Clear;
  EnigmaMachine.ClearDebugOutput;
end;

procedure TMainForm.Debug1Click(Sender: TObject);
begin
  EnigmaPageControl.ActivePageIndex:=2;
end;

procedure TMainForm.ButtonMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  KeyBoardClick(Sender);
  LightButton(LightLetter);
end;

procedure TMainForm.ButtonMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DarkButton(LightLetter);
end;

procedure TMainForm.Rotor4UpDownChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
begin
  case Direction of
  updUP:  begin
            if Rotor4Edit.Text[1]='Z' then Rotor4Edit.Text:='A' else
            Rotor4Edit.Text:=chr (ord(Rotor4Edit.Text[1])+1);
          end;

  updDOWN:
          if Rotor4Edit.Text[1]='A' then Rotor4Edit.Text:='Z' else
          Rotor4Edit.Text:=chr (ord(Rotor4Edit.Text[1])-1)
   end;
end;

procedure TMainForm.Hilfe2Click(Sender: TObject);
begin
  ShellExecute (Application.Handle,'','Enigma.chm','',PChar(ExtractFilePath(Application.Exename)),SW_SHOW);
end;

procedure TMainForm.Rotor1UpDownChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
begin
  case Direction of
  updUP:  begin
            if Rotor1Edit.Text[1]='Z' then Rotor1Edit.Text:='A' else
            Rotor1Edit.Text:=chr (ord(Rotor1Edit.Text[1])+1);
          end;

  updDOWN:
          if Rotor1Edit.Text[1]='A' then Rotor1Edit.Text:='Z' else
          Rotor1Edit.Text:=chr (ord(Rotor1Edit.Text[1])-1)
   end;

end;

end.
