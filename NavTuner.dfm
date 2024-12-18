object SideBar: TSideBar
  Left = 0
  Top = 0
  Width = 228
  Height = 672
  Align = alRight
  AutoScroll = True
  BorderWidth = 3
  Caption = 'SideBar'
  Color = clBtnFace
  ParentFont = True
  Position = poDesigned
  Visible = True
  TextHeight = 15
  object Label1: TLabel
    Left = 112
    Top = 184
    Width = 34
    Height = 15
    Caption = 'Label1'
  end
  object Splitter1: TSplitter
    Left = 0
    Top = 236
    Width = 206
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 224
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 206
    Height = 236
    Align = alTop
    Caption = 'Select form to resize or show '
    TabOrder = 0
    object ListBox1: TListBox
      Left = 9
      Top = 23
      Width = 97
      Height = 129
      ItemHeight = 15
      TabOrder = 0
      OnDblClick = ListBox1DblClick
    end
    object Grow: TButton
      Left = 118
      Top = 31
      Width = 79
      Height = 29
      Caption = 'Grow'
      TabOrder = 1
      OnClick = GrowClick
    end
    object Shrink: TButton
      Left = 129
      Top = 64
      Width = 57
      Height = 16
      Caption = 'Shrink'
      TabOrder = 2
      OnClick = ShrinkClick
    end
    object Sel_Show: TButton
      Left = 118
      Top = 92
      Width = 75
      Height = 25
      Caption = 'Show'
      TabOrder = 3
      OnClick = Sel_ShowClick
    end
    object Hnd_sizeof: TButton
      Left = 118
      Top = 122
      Width = 75
      Height = 25
      Caption = 'Hnd_sizeof'
      TabOrder = 4
      OnClick = Hnd_sizeofClick
    end
    object Button1: TButton
      Left = 60
      Top = 203
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 5
      OnClick = Button1Click
    end
  end
  object btnRunStop: TButton
    Left = 8
    Top = 184
    Width = 75
    Height = 17
    Caption = 'btnRunStop'
    TabOrder = 1
    OnClick = btnRunStopClick
  end
  object memoShowMessages: TMemo
    Left = 0
    Top = 239
    Width = 206
    Height = 341
    Align = alTop
    Lines.Strings = (
      'memoShowMessages')
    TabOrder = 2
  end
  object TaskTimer: TTimer
    Enabled = False
    Interval = 747
    Left = 139
    Top = 248
  end
end
