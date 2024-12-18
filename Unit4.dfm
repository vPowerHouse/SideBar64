object Form4: TForm4
  Left = 0
  Top = 0
  Caption = 'Form4'
  ClientHeight = 134
  ClientWidth = 786
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
    ItemIndex = 0
    TabOrder = 0
    Text = 'Aye'
    Items.Strings = (
      'Aye'
      'Bee'
      'Cee'
      'Dee'
      'Eee')
  end
  object MainMenu1: TMainMenu
    AutoMerge = True
    Left = 272
    Top = 23
    object mFour: TMenuItem
      Caption = 'Four'
      GroupIndex = 5
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
