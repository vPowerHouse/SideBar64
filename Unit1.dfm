object Form1: TForm1
  Left = 0
  Top = 0
  Margins.Left = 4
  Margins.Top = 4
  Margins.Right = 4
  Margins.Bottom = 4
  BorderWidth = 1
  Caption = 'Form1'
  ClientHeight = 831
  ClientWidth = 1364
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu
  TextHeight = 15
  object MainMenu: TMainMenu
    Left = 236
    Top = 68
    object FileMenu: TMenuItem
      Caption = 'File'
      object FileDesktop1: TMenuItem
        Caption = 'Show Desktop 1'
        GroupIndex = 1
        OnClick = FileDesktop1Click
      end
      object FileDesktop2: TMenuItem
        Caption = 'Show Desktop 2'
        GroupIndex = 1
        OnClick = FileDesktop2Click
      end
    end
  end
end
