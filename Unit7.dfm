object Form7: TForm7
  Left = 0
  Top = 0
  Caption = 'FunctionDraw'
  ClientHeight = 572
  ClientWidth = 905
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Comic Sans MS'
  Font.Style = []
  Icon.Data = {
    0000010001001010000001000800680500001600000028000000100000002000
    0000010008000000000040050000000000000000000000010000000100000000
    0000000033000000FF0000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000001000000000000000000000000000000010000000000000000000000
    0000000001000000000000000000000000000000010000000000000000000202
    0202020202020000000000000000000000000000010202020000000000000000
    0000000001000002020200000000010101010101010101010102010101010000
    0000000001000000000202000000000000000000010000000000020000000000
    0000000001000000000002020000000000000000010000000000000200000000
    0000000001000000000000020200000000000000010000000000000002000000
    000000000100000000000000020000000000000001000000000000000200FDFF
    FFFFFDFFFFFFFDFFFFFFFDFFFFFF00FFFFFFFC3FFFFFFD8FFFFF0000FFFFFDE7
    FFFFFDF7FFFFFDF3FFFFFDFBFFFFFDF9FFFFFDFDFFFFFDFDFFFFFDFDFFFF}
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 15
  object Image: TImagePlus
    Left = 121
    Top = 81
    Width = 784
    Height = 491
    About = 'GDA imaging controls V1.4'
    Flip = False
    Align = alClient
    ExplicitLeft = 123
    ExplicitHeight = 456
  end
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 905
    Height = 81
    Align = alTop
    TabOrder = 0
    object Lbl10: TLabel
      Left = 588
      Top = 32
      Width = 25
      Height = 15
      Caption = 'xmin'
    end
    object Lbl11: TLabel
      Left = 651
      Top = 56
      Width = 24
      Height = 15
      Caption = 'ymin'
    end
    object Lbl12: TLabel
      Left = 870
      Top = 32
      Width = 28
      Height = 15
      Caption = 'xmax'
    end
    object Lbl13: TLabel
      Left = 648
      Top = 8
      Width = 27
      Height = 15
      Caption = 'ymax'
    end
    object Lbl2: TLabel
      Left = 224
      Top = 6
      Width = 70
      Height = 15
      Caption = 'Funktionsfeld'
    end
    object Lbl4: TLabel
      Left = 88
      Top = 6
      Width = 66
      Height = 15
      Caption = 'Laufvariabel'
    end
    object ButtonGraph: TButton
      Left = 360
      Top = 44
      Width = 190
      Height = 31
      Caption = 'Draw Graph'
      Default = True
      TabOrder = 3
      Visible = False
      OnClick = ButtonGraphClick
    end
    object TX3: TEdit
      Left = 166
      Top = 22
      Width = 180
      Height = 23
      TabOrder = 1
      Text = 'b+a*x^2'
    end
    object LaufVar: TEdit
      Left = 88
      Top = 22
      Width = 72
      Height = 23
      TabOrder = 0
      Text = 'x'
    end
    object BtnRechne: TButton
      Left = 360
      Top = 8
      Width = 190
      Height = 67
      Caption = 'Lese Term'
      TabOrder = 2
      OnClick = BtnRechneClick
    end
    object Btndel: TButton
      Left = 556
      Top = 8
      Width = 26
      Height = 67
      Caption = 'Del'
      TabOrder = 5
      OnClick = BtndelClick
    end
    object BtnHelp: TButton
      Left = 16
      Top = 5
      Width = 64
      Height = 25
      Caption = 'Help'
      TabOrder = 4
      OnClick = BtnHelpClick
    end
    object SchaarVar: TEdit
      Left = 224
      Top = 52
      Width = 25
      Height = 23
      TabOrder = 6
      Text = 'a'
    end
    object Schaar1: TCheckBox
      Left = 163
      Top = 58
      Width = 55
      Height = 17
      Caption = 'Schaar'
      TabOrder = 10
    end
    object ColorBar: TScrollBar
      Left = 16
      Top = 59
      Width = 121
      Height = 16
      LargeChange = 10
      Max = 66846
      PageSize = 0
      Position = 1
      TabOrder = 11
      OnChange = ColorBarChange
    end
    object ColorPanel: TPanel
      Left = 16
      Top = 36
      Width = 64
      Height = 17
      Color = clRed
      ParentBackground = False
      TabOrder = 12
    end
    object xmin: TRxCalcEdit
      Left = 616
      Top = 29
      Width = 121
      Height = 21
      AutoSize = False
      NumGlyphs = 2
      TabOrder = 13
      Value = -10.000000000000000000
      OnChange = yminChange
    end
    object xmax: TRxCalcEdit
      Left = 743
      Top = 29
      Width = 121
      Height = 21
      AutoSize = False
      NumGlyphs = 2
      TabOrder = 14
      Value = 10.000000000000000000
      OnChange = yminChange
    end
    object ymin: TRxCalcEdit
      Left = 681
      Top = 54
      Width = 121
      Height = 21
      AutoSize = False
      NumGlyphs = 2
      TabOrder = 15
      Value = -6.000000000000000000
      OnChange = yminChange
    end
    object ymax: TRxCalcEdit
      Left = 681
      Top = 7
      Width = 121
      Height = 21
      AutoSize = False
      NumGlyphs = 2
      TabOrder = 16
      Value = 6.000000000000000000
      OnChange = yminChange
    end
    object Schaarmin: TEdit
      Left = 255
      Top = 52
      Width = 26
      Height = 23
      TabOrder = 7
      Text = '1'
    end
    object Schaarmax: TEdit
      Left = 287
      Top = 52
      Width = 27
      Height = 23
      TabOrder = 8
      Text = '10'
    end
    object Schaardelta: TEdit
      Left = 320
      Top = 52
      Width = 26
      Height = 23
      TabOrder = 9
      Text = '1'
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 81
    Width = 121
    Height = 491
    Align = alLeft
    TabOrder = 1
    object xWert: TLabel
      Left = 16
      Top = 320
      Width = 99
      Height = 25
      AutoSize = False
    end
    object YWert: TLabel
      Left = 16
      Top = 360
      Width = 99
      Height = 25
      AutoSize = False
    end
    object VarEditor: TValueListEditor
      AlignWithMargins = True
      Left = 4
      Top = 42
      Width = 113
      Height = 253
      Align = alTop
      TabOrder = 0
      TitleCaptions.Strings = (
        'Variabel'
        'Wert')
      OnSetEditText = VarEditorSetEditText
      ColWidths = (
        56
        51)
    end
    object Panel24: TPanel
      Left = 1
      Top = 1
      Width = 119
      Height = 38
      Align = alTop
      Caption = 'Variableneditor'
      TabOrder = 1
    end
  end
end
