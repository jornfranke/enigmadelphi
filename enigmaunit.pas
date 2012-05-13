unit enigmaunit;

interface

uses dialogs,sysutils;

type
   TRingSetting = 1..26;
   TRotorCount = (rc3,rc4);
   TRotorType  = (rt1,rt2,rt3,rt4,rt5,rt6,rt7,rt8,rtBeta,rtGamma,rtNotUsed);
   TWireDirection = (wdforward,wdbackward);
   TReflectorType = (refNormalB,refNormalC,refThinB,refThinC);

   TEnigmaRotor = class (TObject)
   private
     FRingSetting: TRingSetting;
     FRotorType: TRotorType;
     FWiring: String;
     FNotch: String;
     FPosition: Char;
     FWireDirection: TWireDirection;
     procedure SetRotorType(RotorType: TRotorType);
   public
     function Crypt(Letter: Char): Char;
     procedure IncreasePosition;

     constructor Create;
     destructor Destroy; override;

     property WireDirection: TWireDirection read FWireDirection write FWireDirection;
     property RingSetting: TRingSetting read FRingSetting write FRingSetting;
     property RotorType: TRotorType read FRotorType write SetRotorType;
     property Notch: String read FNotch write FNotch;
     property Position: Char read FPosition write FPosition;
     property Wiring: String read FWiring write FWiring;
   end;

   TEnigmaReflector = class (TObject)
   private
     FWiring: String;
     FReflectorType: TReflectorType;
     procedure SetReflectorType(ReflectorType: TReflectorType);
   public
     constructor Create;
     destructor Destroy; override;
     function Crypt(Letter: Char): Char;

     property ReflectorType: TReflectorType read FReflectorType write SetReflectorType;
     property Wiring: String read FWiring write FWiring;
   end;


   TEnigmaMachine = class (TObject)

      FPlugBoardSettings: String;
      FRotorPositions: String;
      FDebugOutput: String;
      FRotorCount: TRotorCount;
      FRotor1: TEnigmaRotor;
      FRotor2: TEnigmaRotor;
      FRotor3: TEnigmaRotor;
      FRotor4: TEnigmaRotor;
      FReflector: TEnigmaReflector;
   private
     procedure SetRotorCount(RotorCount: TRotorCount);
     procedure MoveRotors;
     procedure WriteDebug(DebugLine: String);
     function ProcessPlugBoard(Letter: Char): Char;
   public
     constructor Create;
     destructor Destroy; override;
     function Crypt(Letter: Char): Char;
     procedure ClearDebugOutput;
     property DebugOutput: String read FDebugOutput;
   published
      property Rotor1: TEnigmaRotor read FRotor1 write FRotor1;
      property Rotor2: TEnigmaRotor read FRotor2 write FRotor2;
      property Rotor3: TEnigmaRotor read FRotor3 write FRotor3;
      property Rotor4: TEnigmaRotor read FRotor4 write FRotor4;
      property Reflector: TEnigmaReflector read FReflector write FReflector;
      property RotorPositions: String read FRotorPositions write FRotorPositions;
      property RotorCount: TRotorCount read FRotorCount write SetRotorCount;
      property PlugBoardSettings: String read FPlugBoardSettings write FPlugBoardSettings;
   end;


{ Geheime Verdrahtung, Kerben und Bewegung der Walzen:
http://homepages.tesco.net/~andycarlson/enigma/simulating_enigma.html
}

const
  Rotor1Wiring = 'EKMFLGDQVZNTOWYHXUSPAIBRCJ';
  Rotor2Wiring = 'AJDKSIRUXBLHWTMCQGZNPYFVOE';
  Rotor3Wiring = 'BDFHJLCPRTXVZNYEIWGAKMUSQO';
  Rotor4Wiring = 'ESOVPZJAYQUIRHXLNFTGKDCMWB';
  Rotor5Wiring = 'VZBRGITYUPSDNHLXAWMJQOFECK';
  Rotor6Wiring = 'JPGVOUMFYQBENHZRDKASXLICTW';
  Rotor7Wiring = 'NZJHGRCXMYSWBOUFAIVLPEKQDT';
  Rotor8Wiring = 'FKQHTLXOCBJSPDZRAMEWNIUYGV';
  BetaRotorWiring = 'LEYJVCNIXWPBQMDRTAKZGFUHOS';
  GammaRotorWiring = 'FSOKANUERHMBTIYCWLQPZXVGJD';
  BReflectorWiringNormal = 'YRUHQSLDPXNGOKMIEBFZCWVJAT';
  CReflectorWiringNormal = 'FVPJIAOYEDRZXWGCTKUQSBNMHL';
  BReflectorWiringThin = 'ENKQAUYWJICOPBLMDXZVFTHRGS';
  CReflectorWiringThin = 'RDOBJNTKVEHMLFCWZAXGYIPSUQ';
  Rotor1Notch = 'Q';
  Rotor2Notch = 'E';
  Rotor3Notch = 'V';
  Rotor4Notch = 'J';
  Rotor5Notch = 'Z';
  Rotor6Notch = 'ZM';
  Rotor7Notch = 'ZM';
  Rotor8Notch = 'ZM';



implementation


{TEnigmaRotor}

constructor TEnigmaRotor.Create;    // Enigma Rotor initialisieren
begin
  RotorType:=rt1;                   // Standard Rotortyp: Rotor1
  Position:='A';                    // Standard Rotorposition: A
  RingSetting:=1;                   // Standard Ringsetting: 1
  FWireDirection:=wdForward;        // Startpunkt: Vor Reflektor
end;




function TEnigmaRotor.Crypt(Letter: Char): Char; //Verschlüsselungsvorgang durch den Rotor
var
  C: Char;
  Index, WiringIndex, PositionIndex, Endposition: ShortInt;
begin
  C:=Letter;                                                         // In C befindet sich der zu verschlüsselnde Buchstabe
  PositionIndex:=Ord(Position)-64-RingSetting;                       // In PositionIndex befindet sich die Position der Walze, Verdrahtung des inneren Ringes berücksichtigen
  if PositionIndex < 1 then PositionIndex:=PositionIndex+26;         // Falls der Positionsindex die Grenzen des Alphabets überspringt von hinten  weiter "durchdrehen"
  Index:=Ord(C)-64;                                                  // Index: Position des zu verschlüsselnden Buchstaben im normalen Alphabets
  WiringIndex:=Index+PositionIndex;                                  // WiringIndex: Index des Buchstabens innerhalb der geheimen Verdrahtung der Walzen
  if WiringIndex > 26 then WiringIndex:=WiringIndex-26;              // Falls der Wiringindex die Grenzen des Alphabets überspringt von vorne weiter "durchdrehen"

     if WireDirection=wdForward then begin                           // Verschlüsselung vor dem Reflektor  (von dem normalen Alphabet auf geheime Verdrahtung)
        Endposition:=Ord(Wiring[WiringIndex])-64-PositionIndex;      // Entposition: Buchstabe in der geheimen Verdrahtung raussuchen
        if EndPosition < 1 then Endposition:=Endposition+26;         // Falls Endposition die Grenzen des Alphabets überspringt von vorne weiter "durchdrehen"
        c:=chr(endposition+64);                                      // Buchstabe in einen Ascii-Buchstaben verwandeln
     end
     else if WireDirection=wdBackward then begin                     // Verschlüsselung nach dem Reflektor (von geheimer Verdrahtung auf Alphabet)
        Endposition:=Pos(chr(WiringIndex+64),Wiring)-PositionIndex;  // Endposition: Buchstabe von WiringIndex in der geheimen Verdrahtung suchen. Die Position dieses Buchstaben ergibt den verschlüsselnden Buchstaben
        if Endposition < 1 then Endposition:=Endposition+26;         // Falls Endposition die Grenzen des Alphabets überspringt von vorne weiter "durchdrehen"
        c:=chr(endposition+64);                                      // Buchstabe in einen Ascii-Buchstaben verwandeln
     end;
  result:=C;  // Ergebnis der Verschlüsselung zurückgeben !
end;

procedure TEnigmaRotor.IncreasePosition;
begin
  if Position='Z' then Position:='A' else
  Position:=chr(ord(Position)+1);
end;

procedure TEnigmaRotor.SetRotorType(RotorType: TRotorType);
begin
  case RotorType of
    rt1: begin
           FWiring:=Rotor1Wiring;
           FNotch:=Rotor1Notch;
           FRotorType:=rt1;
         end;
    rt2: begin
           FWiring:=Rotor2Wiring;
           FNotch:=Rotor2Notch;
           FRotorType:=rt2;
         end;
    rt3: begin
           FWiring:=Rotor3Wiring;
           FNotch:=Rotor3Notch;
           FRotorType:=rt3;
         end;
    rt4: begin
           FWiring:=Rotor4Wiring;
           FNotch:=Rotor4Notch;
           FRotorType:=rt4;
         end;
    rt5: begin
           FWiring:=Rotor5Wiring;
           FNotch:=Rotor5Notch;
           FRotorType:=rt5;
         end;
    rt6: begin
            FWiring:=Rotor6Wiring;
            FNotch:=Rotor6Notch;
            FRotorType:=rt6;
         end;
    rt7: begin
            FWiring:=Rotor7Wiring;
            FNotch:=Rotor7Notch;
            FRotorType:=rt7;
         end;
    rt8: begin
           FWiring:=Rotor8Wiring;
           FNotch:=Rotor8Notch;
           FRotorType:=rt8;
         end;
    rtBeta: begin
              FWiring:=BetaRotorWiring;
              FNotch:='';                   // Besitzt keine Kerbe, weil er sich nicht automatisch weiterdreht
              FRotorType:=rtBeta;
             end;
    rtGamma: begin
               FWiring:=GammaRotorWiring;
               FNotch:='';                // Besitzt keine Kerbe, weil er sich nicht automatisch weiterdreht
               FRotorType:=rtGamma;
             end;
    rtNotUsed: begin
                 FWiring:='';
                 FNotch:='';
                 FRotorType:=rtNotUsed;
               end;
  end;
end;

destructor TEnigmaRotor.Destroy;
begin
end;

{TEnigmaReflector}

constructor TEnigmaReflector.Create;
begin
  ReflectorType:=refNormalB;
end;

function TEnigmaReflector.Crypt(Letter: Char): Char;
var
  Index: Byte;
begin
  Index:=Ord(Letter)-64;    // Ascii-Buchstaben in eine entsprechende Zahl von 1 - 26 umwandeln
  result:=Wiring[Index];    // Anhand dieser Zahl in der geheimen Verdrahtung des Reflektors nachschauen und den verschlüsselten Buchstaben zurückgeben
end;

procedure TEnigmaReflector.SetReflectorType(ReflectorType: TReflectorType);
begin
  case ReflectorType of
    refNormalB: begin
                  FWiring:=BReflectorWiringNormal;
                  FReflectorType:=refNormalB;
                end;
    refNormalC: begin
                  FWiring:=CReflectorWiringNormal;
                  FReflectorType:=refNormalC;
                end;
    refThinB: begin
                FWiring:=BReflectorWiringThin;
                FReflectorType:=refThinB;
              end;
    refThinC: begin
                FWiring:=CReflectorWiringThin;
                FReflectorType:=refThinC;
              end;
  end;
end;

destructor TEnigmaReflector.Destroy;
begin
end;

{TEnigmaMachine}

constructor TEnigmaMachine.Create; // Enigma-Maschine initialisieren
begin
  FRotorCount:=rc3;
  FPlugBoardSettings:='EN IG MA';
  Rotor1:=TEnigmaRotor.Create;
  Rotor1.RotorType:=rt1;
  Rotor2:=TEnigmaRotor.Create;
  Rotor2.RotorType:=rt2;
  Rotor3:=TEnigmaRotor.Create;
  Rotor3.RotorType:=rt3;
  Rotor4:=TEnigmaRotor.Create;
  Rotor4.RotorType:=rtNotUsed;
  Reflector:=TEnigmaReflector.Create;
  Reflector.ReflectorType:=refNormalB;
end;




function TEnigmaMachine.ProcessPlugBoard(Letter: Char): Char;
var
  i: Integer;
  c: Char;
begin
  c:= Letter;                           //c: Zu verschlüsselnder Buchstabe
  i:=pos(Letter,PlugBoardSettings);     //i: Ist der zu verschlüsselnde Buchstabe im Steckbrett vorhanden ?
  if i>0 then                           // Wenn vorhanden dann
     if ((PlugBoardSettings[i+1]=' ') or (i>=length(Plugboardsettings))) then c:=PlugBoardSettings[i-1] //Suche Buchstaben heraus, mit dem vertauscht werden soll
     else c:=PlugBoardSettings[i+1];   // "
  result:=c;  // c ausgeben (entweder vertauschter Buchstabe, oder wenn keine Steckbrettverbindung vorhanden, dann wird keine Änderung am Buchstaben vorgenommen)
end;

function TEnigmaMachine.Crypt(Letter: Char): Char; // Verschlüsselung der EnigmaMaschine: Gibt verschlüsselten Buchstabe zurück
var
 C: Char;
begin
  C:=Letter;
  case RotorCount of             //Prüfe Anzahl der Rotoren
  rc3: begin                                                 // 3 Rotoren
         MoveRotors;                                         // Walzen gegebenfalls bewegen
         Rotor1.WireDirection:=wdForward;                    // Buchstabe wird vor dem Reflektor eingegeben
         Rotor2.WireDirection:=wdForward;                    //  "
         Rotor3.WireDirection:=wdForward;                    //  "
         WriteDebug('Ausgangsbuchstabe: '+C);                // Debugausgabe: Anfangsbuchstabe
         C:=ProcessPlugBoard(C);                             // Buchstabe dem Steckbrett übergeben
         WriteDebug('Verschlüsselung durch Steckbrett: '+C); // Debugausgabe: Verschlüsselter Buchstabe durch Steckbrett
         C:=Rotor3.Crypt(C);                                 // Buchstabe durch Rotor 3 verschlüsseln (der äußerst rechte)
         WriteDebug('Verschlüsselung durch 3. Rotor: '+C);   // Debugausgabe: Verschlüsselter Buchstabe durch Rotor 3
         C:=Rotor2.Crypt(C);                                 // Buchstabe durch Rotor 2 verschlüsseln
         WriteDebug('Verschlüsselung durch 2. Rotor: '+C);   // Debugausgabe: Verschlüsselter Buchstabe durch Rotor 2
         C:=Rotor1.Crypt(C);                                 // Buchstabe durch Rotor 1 verschlüsseln
         WriteDebug('Verschlüsselung durch 1. Rotor: '+C);   // Debugausgabe: Verschlüsselter Buchstabe durch Rotor 1
         C:=Reflector.Crypt(C);                              // Buchstabe durch den Reflektor verschlüsseln
         WriteDebug('Verschlüsselung durch Reflektor: '+C);  // Debugausgabe: Verschlüsselter Buchstabe durch Reflektor
         Rotor1.WireDirection:=wdBackward;                   // Buchstabe hat den Reflektor passiert
         Rotor2.WireDirection:=wdBackward;                   // "
         Rotor3.WireDirection:=wdBackward;                   // "
         C:=Rotor1.Crypt(C);                                 // Buchstabe durch Rotor 1 verschlüsseln
         WriteDebug('Verschlüsselung durch 1. Rotor: '+C);   // Debugausgabe: Verschlüsselter Buchstabe durch Rotor 1
         C:=Rotor2.Crypt(C);                                 // Buchstabe durch Rotor 2 verschlüsseln
         WriteDebug('Verschlüsselung durch 2. Rotor: '+C);   // Debugausgabe: Verschlüsselter Buchstabe durch Rotor 2
         C:=Rotor3.Crypt(C);                                 // Buchstabe durch Rotor 3 verschlüsseln (der äußerst rechte)
         WriteDebug('Verschlüsselung durch 3. Rotor: '+C);   // Debugausgabe: Verschlüsselter Buchstabe durch Rotor 3
         C:=ProcessPlugBoard(C);                             // Buchstabe dem Steckbrett übergeben
         WriteDebug('Verschlüsselung durch Steckbrett: '+C); // Debugausgabe: Verschlüsselter Buchstabe durch Steckbrett
     end;
  rc4: begin                                                 // 4 Rotoren
         MoveRotors;                                         // Rotor gegebenfalls bewegen
         Rotor1.WireDirection:=wdForward;                    // Buchstabe wird vor dem Reflektor eingegeben
         Rotor2.WireDirection:=wdForward;                    //  "
         Rotor3.WireDirection:=wdForward;                    //  "
         Rotor4.WireDirection:=wdForward;                    //  "
         WriteDebug('Ausgangsbuchstabe: '+C);                // Debugausgabe: Anfangsbuchstabe
         C:=ProcessPlugBoard(C);                             // Buchstabe dem Steckbrett übergeben
         WriteDebug('Verschlüsselung durch Steckbrett: '+C); // Debugausgabe: Verschlüsselter Buchstabe durch Steckbrett
         C:=Rotor3.Crypt(C);                                 // Buchstabe durch Rotor 3 verschlüsseln (der äußerst rechte)
         WriteDebug('Verschlüsselung durch 3. Rotor: '+C);   // Debugausgabe: Verschlüsselter Buchstabe durch Rotor 3
         C:=Rotor2.Crypt(C);                                 // Buchstabe durch Rotor 2 verschlüsseln
         WriteDebug('Verschlüsselung durch 2. Rotor: '+C);   // Debugausgabe: Verschlüsselter Buchstabe durch Rotor 2
         C:=Rotor1.Crypt(C);                                 // Buchstabe durch Rotor 1 verschlüsseln
         WriteDebug('Verschlüsselung durch 1. Rotor: '+C);   // Debugausgabe: Verschlüsselter Buchstabe durch Rotor 1
         C:=Rotor4.Crypt(C);                                 // Buchstabe durch Rotor 4 (äußerst links) verschlüsseln
         WriteDebug('Verschlüsselung durch 4. Rotor: '+C);   // Debugausgabe: Verschlüsselter Buchstabe durch Rotor 4
         C:=Reflector.Crypt(C);                              // Buchstabe durch den Reflektor verschlüsseln
         WriteDebug('Verschlüsselung durch Reflektor: '+C);  // Debugausgabe: Verschlüsselter Buchstabe durch Reflektor
         Rotor1.WireDirection:=wdBackward;                   // Buchstabe hat den Reflektor passiert
         Rotor2.WireDirection:=wdBackward;                   //  "
         Rotor3.WireDirection:=wdBackward;                   //  "
         Rotor4.WireDirection:=wdBackward;                   //  "
         C:=Rotor4.Crypt(C);                                 // Buchstabe durch Rotor 4 (äußerst links) verschlüsseln
         WriteDebug('Verschlüsselung durch 4. Rotor: '+C);   // Debugausgabe: Verschlüsselter Buchstabe durch Rotor 4
         C:=Rotor1.Crypt(C);                                 // Buchstabe durch Rotor 1 verschlüsseln
         WriteDebug('Verschlüsselung durch 1. Rotor: '+C);   // Debugausgabe: Verschlüsselter Buchstabe durch Rotor 1
         C:=Rotor2.Crypt(C);                                 // Buchstabe durch Rotor 2 verschlüsseln
         WriteDebug('Verschlüsselung durch 2. Rotor: '+C);   // Debugausgabe: Verschlüsselter Buchstabe durch Rotor 2
         C:=Rotor3.Crypt(C);                                 // Buchstabe durch Rotor 3 verschlüsseln (der äußerst rechte)
         WriteDebug('Verschlüsselung durch 3. Rotor: '+C);   // Debugausgabe: Verschlüsselter Buchstabe durch Rotor 3
         C:=ProcessPlugBoard(C);                             // Buchstabe dem Steckbrett übergeben
         WriteDebug('Verschlüsselung durch Steckbrett: '+C); // Debugausgabe: Verschlüsselter Buchstabe durch Steckbrett
     end;
end;
  result:=C;       //Verschlüsselten
  WriteDebug(''); // Leerzeile zur besseren Übersicht in der Debug-Ausgabe einfügen
end;


procedure TEnigmaMachine.MoveRotors;       //Bewegung der Rotoren der Enigma-Maschine
begin
  case Length(Rotor2.Notch) of  // Prüfe Anzahl der Kerben (Notches) von Rotor 2
       1: if Rotor2.Position=Rotor2.Notch[1] then begin    // Wenn Rotor 2 seine Kerbe erreicht hat dann
            Rotor1.IncreasePosition;                       // 1. Rotor bewegen
            Rotor2.IncreasePosition;                       // 2. Rotor bewegen
            WriteDebug('Bewege 1. Rotor: '+chr(ord(Rotor1.Position)-1)+'->'+Rotor1.Position); // Debugausgabe der Rotorbewegung
            WriteDebug('Bewege 2. Rotor: '+chr(ord(Rotor2.Position)-1)+'->'+Rotor2.Position); // Debugausgabe der Rotorbewegung
          end;
       2: if ((Rotor2.Position=Rotor2.Notch[1]) or (Rotor2.Position=Rotor2.Notch[2])) then begin // Wenn Rotor 2 eine seiner Kerben erreicht hat dann drehe
            Rotor1.IncreasePosition;                                                             // 1. Rotor bewegen
            Rotor2.IncreasePosition;                                                             // 2. Rotor bewegen
            WriteDebug('Bewege 1. Rotor: '+chr(ord(Rotor1.Position)-1)+'->'+Rotor1.Position);    // Debugausgabe der Rotorbewegung
            WriteDebug('Bewege 2. Rotor: '+chr(ord(Rotor2.Position)-1)+'->'+Rotor2.Position);   // Debugausgabe der Rotorbewegung
          end;
      end;
      case Length(Rotor3.Notch) of         //Prüfe Anzahl der Kerben (Notches) von Rotor 3
       1: if Rotor3.Position=Rotor3.Notch[1] then begin        // Wenn Rotor 3 seine Kerbe erreicht hat dann
           Rotor2.IncreasePosition;                            // 2. Rotor bewegen
           WriteDebug('Bewege 2. Rotor: '+chr(ord(Rotor2.Position)-1)+'->'+Rotor2.Position); // Debugausgabe der Rotorbewegung
          end;
       2: if ((Rotor3.Position=Rotor3.Notch[1]) or (Rotor3.Position=Rotor3.Notch[2])) then begin //Wenn Rotor 3 seine Kerben erreicht hat dann
            Rotor2.IncreasePosition;                                                             // 2. Rotor bewegen
            WriteDebug('Bewege 2. Rotor: '+chr(ord(Rotor2.Position)-1)+'->'+Rotor2.Position); // Debugausgabe der Rotorbewegung
          end;
  end;
     Rotor3.IncreasePosition; // Rotor 3 (äußerst rechts) bewegt sich bei jedem Tastendruck !
     WriteDebug('Bewege 3. Rotor: '+chr(ord(Rotor3.Position)-1)+'->'+Rotor3.Position); // Debugausgabe der Rotorbewegung
end;

procedure TEnigmaMachine.SetRotorCount(RotorCount: TRotorCount);
begin
case RotorCount of
  rc3: begin
        Rotor4.RotorType:=rtNotUsed;
        FRotorCount:=rc3;
     end;
  rc4: begin
         Rotor4.Rotortype:=rtBeta;
         FRotorCount:=rc4;
     end;
end;
end;

procedure TEnigmaMachine.WriteDebug(DebugLine: String);
begin
  FDebugOutput:=FDebugOutput+DebugLine+#13+#10;
end;

procedure TEnigmaMachine.ClearDebugOutput;
begin
  FDebugOutput:='';
end;

destructor TEnigmaMachine.Destroy;
begin
end;

end.
