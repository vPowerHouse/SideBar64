object Form2: TForm2
  Left = 0
  Top = 0
  BorderWidth = 1
  Caption = 'Form2'
  ClientHeight = 278
  ClientWidth = 442
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  Menu = MainMenu1
  Visible = True
  OnClose = FormClose
  TextHeight = 15
  object ComboBox1: TComboBox
    Left = 16
    Top = 16
    Width = 145
    Height = 23
    Style = csDropDownList
    TabOrder = 0
    Items.Strings = (
      'One'
      'Two'
      'Three'
      'Four'
      'Five'
      'Six')
  end
  object MainMenu1: TMainMenu
    AutoMerge = True
    Left = 240
    Top = 104
    object mTwo: TMenuItem
      Caption = 'Two'
      GroupIndex = 1
      object mReg: TMenuItem
        Caption = 'Reg'
        GroupIndex = 1
        OnClick = mRegClick
      end
      object mBig: TMenuItem
        Caption = 'Big'
        GroupIndex = 1
        OnClick = mBigClick
      end
    end
  end
end
