object Help: THelp
  Left = 0
  Top = 0
  Caption = 'Help Window'
  ClientHeight = 240
  ClientWidth = 416
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object HelpPanel: TPanel
    Left = 0
    Top = 0
    Width = 416
    Height = 240
    Align = alClient
    BorderWidth = 2
    BorderStyle = bsSingle
    Color = clInactiveBorder
    Locked = True
    ParentBackground = False
    TabOrder = 0
    object Lblhelp: TLabel
      Left = 259
      Top = 16
      Width = 130
      Height = 169
      Caption = 
        'Funktionen:'#13#10'Addition(+)              a+b'#13#10'Subtraktion(-)       ' +
        '   a-b'#13#10'Multiplikation(*)       a*b'#13#10'Division(/)               a' +
        '/b'#13#10'Exponent(^)            a^b'#13#10'Quadtatwurzel(w)    w(a)'#13#10'Sinus(' +
        's)                   s(a)'#13#10'Cosinus(c)               c(a)'#13#10'Tangen' +
        's(t)              t(a)'#13#10'Klammern                (a+b)'#13#10#13#10'Beispie' +
        'l: f(x)= 2*x+s(x+2)'
    end
    object Lbl: TLabel
      Left = 29
      Top = 24
      Width = 225
      Height = 195
      Caption = 
        'Die Funktionsdefinition wird ohne Leerzeichen'#13#10'in das Funktionsf' +
        'eld eingegeben.'#13#10'Reservierte Zeichen sind die Operanden:'#13#10'+  -  ' +
        '*  /  ^  w  s  c  t'#13#10'Alle weiteren Zeichen werden als Variablen'#13 +
        #10'gewertet.'#13#10'Im Laufvariablenfeld wird die Laufvariable'#13#10'definier' +
        't. im Beispiel : x'#13#10'Auf der Linken Seite im Variableneditor k'#246'nn' +
        'en'#13#10'Parameter der Gleichung ver'#228'ndert werden.'#13#10'Durch aktivieren ' +
        'des Schaar-H'#228'kchens wird'#13#10'die Anzeige von Funktionsschaaren erm'#246 +
        'glicht.'#13#10'In den 4 Feldern dahinter wird'#13#10'Parameter, Startwert, Z' +
        'ielwert, Schrittweite'#13#10'(von links nach rechts) angegeben.'
    end
    object Btnhelpexit: TButton
      Left = 326
      Top = 201
      Width = 75
      Height = 25
      Caption = 'Close'
      TabOrder = 0
      OnClick = BtnhelpexitClick
    end
  end
end
