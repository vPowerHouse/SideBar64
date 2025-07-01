object MainForm: TMainForm
  Left = 184
  Top = 104
  Hint = 'Use Redo and Undo icons to move between desktops'
  Caption = 'DeskTop__One'
  ClientHeight = 489
  ClientWidth = 1010
  Color = clAppWorkSpace
  DragMode = dmAutomatic
  ParentFont = True
  FormStyle = fsMDIForm
  VisualManager = FormTabsBar1
  Position = poDesigned
  OnActivate = FormActivate
  OnCreate = FormCreate
  TextHeight = 15
  object Label1: TLabel
    Left = 678
    Top = 0
    Width = 34
    Height = 15
    Caption = 'Label1'
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 464
    Width = 1010
    Height = 25
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    AutoHint = True
    Panels = <>
    ParentFont = True
    SimplePanel = True
    UseSystemFont = False
  end
  object FormTabsBar1: TFormTabsBar
    Left = 0
    Top = 25
    Width = 1010
    Height = 30
    ParentColor = False
    TabOptions.ShowFormIcon = True
    TabOptions.ShowFormSystemMenu = True
    TabOptions.ShowCloseButton = True
    TabOptions.ShowHintForTruncatedCaption = True
    TabMinWidth = 100
    TabMaxWidth = 250
    ShowTabsMenuButton = True
  end
  object ActionMainMenuBar1: TActionMainMenuBar
    Left = 0
    Top = 0
    Width = 1010
    Height = 25
    UseSystemFont = False
    ActionManager = ActionManager1
    Caption = 'ActionMainMenuBar1'
    Color = clMenuBar
    ColorMap.DisabledFontColor = 10461087
    ColorMap.HighlightColor = clWhite
    ColorMap.BtnSelectedFont = clBlack
    ColorMap.UnusedColor = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'Lucida Console'
    Font.Style = []
    Spacing = 0
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 55
    Width = 1010
    Height = 33
    BorderWidth = 1
    Color = clBtnFace
    Images = VirtualImageList1
    Indent = 5
    List = True
    ParentColor = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    Transparent = False
    Wrapable = False
    object ToolButton9: TToolButton
      Left = 5
      Top = 0
      Action = FileNew1
    end
    object ToolButton1: TToolButton
      Left = 28
      Top = 0
      Action = FileOpen1
    end
    object ToolButton2: TToolButton
      Left = 51
      Top = 0
      Action = FileSave1
    end
    object ToolButton4: TToolButton
      Left = 74
      Top = 0
      Action = EditCut1
    end
    object ToolButton3: TToolButton
      Left = 97
      Top = 0
      Width = 8
      Caption = 'ToolButton3'
      ImageIndex = 2
      ImageName = 'Item3'
      Style = tbsSeparator
    end
    object ToolButton5: TToolButton
      Left = 105
      Top = 0
      Action = EditCopy1
    end
    object ToolButton6: TToolButton
      Left = 128
      Top = 0
      Action = EditPaste1
    end
    object ToolButton7: TToolButton
      Left = 151
      Top = 0
      Width = 31
      Caption = 'ToolButton7'
      ImageIndex = 3
      ImageName = 'Item4'
      Style = tbsSeparator
    end
    object ToolButton8: TToolButton
      Left = 182
      Top = 0
      Action = WindowCascade1
    end
    object ToolButton10: TToolButton
      Left = 205
      Top = 0
      Action = WindowTileHorizontal1
    end
    object ToolButton11: TToolButton
      Left = 228
      Top = 0
      Action = WindowTileVertical1
    end
    object ToolButton12: TToolButton
      Left = 251
      Top = 0
      Caption = 'ToolButton12'
      ImageIndex = 17
      ImageName = 'Item18'
    end
    object ToolButton14: TToolButton
      Left = 274
      Top = 0
      Width = 39
      Caption = 'ToolButton14'
      ImageIndex = 10
      ImageName = 'Item11'
      Style = tbsDivider
    end
    object tbSideBarFloat: TToolButton
      Left = 313
      Top = 0
      Hint = 'Show sidebar on side'
      Caption = 'floatJumper'
      ImageIndex = 2
      ImageName = 'Item3'
      OnClick = tbSideBarFloatClick
    end
    object tbListForms2: TToolButton
      Left = 336
      Top = 0
      Hint = 'List screen forms'
      Caption = 'tbListForms2'
      ImageIndex = 1
      ImageName = 'Item2'
      OnClick = ListScreenFormsExecute
    end
    object tbOpenDT2: TToolButton
      Left = 359
      Top = 0
      Hint = 'Load/Show Desk Top Two'
      Caption = 'tbOpenDT2'
      ImageIndex = 19
      ImageName = 'Item5A'
      OnClick = btnShow_Other_AppClick
    end
    object ToolButton15: TToolButton
      Left = 382
      Top = 0
      Hint = 'Show SideBar Parent'
      Caption = 'ToolButton15'
      ImageIndex = 12
      ImageName = 'Item13'
      OnClick = ToolButton15Click
    end
    object tbtnTransfer: TToolButton
      Left = 405
      Top = 0
      Hint = 'Move active window'
      Caption = 'tbtnTransfer'
      ImageIndex = 10
      ImageName = 'Item11'
    end
  end
  object OpenDialog: TOpenDialog
    Filter = 'All files (*.*)|*.*'
    Left = 40
    Top = 160
  end
  object ActionList1: TActionList
    Images = VirtualImageList1
    Left = 40
    Top = 96
    object FileNew1: TAction
      Category = 'File'
      Caption = '&New'
      Hint = 'New|Create a new file'
      ImageIndex = 6
      ImageName = 'Item7'
      ShortCut = 16462
      OnExecute = FileNew1Execute
    end
    object FileOpen1: TAction
      Category = 'File'
      Caption = '&Open'
      Hint = 'Open|Open a file'
      ImageIndex = 7
      ImageName = 'Item8'
      ShortCut = 16463
      OnExecute = FileOpen1Execute
    end
    object FileClose1: TWindowClose
      Category = 'File'
      Caption = '&Close'
      Hint = 'Close|Close current file'
    end
    object FileSave1: TAction
      Category = 'File'
      Caption = '&Save'
      Hint = 'Save|Save current file'
      ImageIndex = 8
      ImageName = 'Item9'
      ShortCut = 16467
    end
    object FileSaveAs1: TAction
      Category = 'File'
      Caption = 'Save &As...'
      Hint = 'Save As|Save current file with different name'
    end
    object FileExit1: TAction
      Category = 'File'
      Caption = 'E&xit'
      Hint = 'Exit|Exit application'
      OnExecute = FileExit1Execute
    end
    object EditCut1: TEditCut
      Category = 'Edit'
      Caption = 'Cu&t'
      Hint = 'Cut|Cuts the selection and puts it on the Clipboard'
      ImageIndex = 0
      ImageName = 'Item1'
      ShortCut = 16472
    end
    object EditCopy1: TEditCopy
      Category = 'Edit'
      Caption = '&Copy'
      Hint = 'Copy|Copies the selection and puts it on the Clipboard'
      ImageIndex = 1
      ImageName = 'Item2'
      ShortCut = 16451
    end
    object EditPaste1: TEditPaste
      Category = 'Edit'
      Caption = '&Paste'
      Hint = 'Paste|Inserts Clipboard contents'
      ImageIndex = 2
      ImageName = 'Item3'
      ShortCut = 16470
    end
    object WindowCascade1: TWindowCascade
      Category = 'Window'
      Caption = '&Cascade'
      Hint = 'Cascade'
      ImageIndex = 17
      ImageName = 'Item18'
      OnExecute = WindowCascade1Execute
    end
    object WindowTileHorizontal1: TWindowTileHorizontal
      Category = 'Window'
      Caption = 'Tile &Horizontally'
      Hint = 'Tile Horizontally'
      ImageIndex = 15
      ImageName = 'Item16'
      OnExecute = WindowTileHorizontal1Execute
    end
    object WindowTileVertical1: TWindowTileVertical
      Category = 'Window'
      Caption = 'Tile &Vertically'
      Hint = 'Tile Vertically'
      ImageIndex = 16
      ImageName = 'Item17'
      OnExecute = WindowTileVertical1Execute
    end
    object WindowMinimizeAll1: TWindowMinimizeAll
      Category = 'Window'
      Caption = '&Minimize All'
      Hint = 'Minimize All'
    end
    object HelpAbout1: TAction
      Category = 'Help'
      Caption = '&About...'
      Hint = 
        'About|Displays program information, version number, and copyrigh' +
        't'
      ImageIndex = 11
      ImageName = 'Item12'
      OnExecute = HelpAbout1Execute
    end
    object FileFourOpen: TAction
      Category = 'File'
      Caption = 'FileFourOpen'
      Hint = 'Opens 4 forms with Names from Listbox'
      ImageIndex = 6
      ImageName = 'Item7'
      ShortCut = 16454
      OnExecute = FileFourOpenExecute
    end
    object FileTwoOpen: TAction
      Category = 'File'
      Caption = 'FileTwoOpen'
      Hint = 'Open all Twos'
      ImageIndex = 6
      ImageName = 'Item7'
      ShortCut = 16468
      OnExecute = FileTwoOpenExecute
    end
    object ListScreenForms: TAction
      Category = 'File'
      Caption = 'WindowFormsShow'
      ImageIndex = 12
      ImageName = 'Item13'
      OnExecute = ListScreenFormsExecute
    end
    object Action2: TAction
      Category = 'Window'
      Caption = 'Action2'
      ImageIndex = 12
      ImageName = 'Item13'
    end
  end
  object ImageCollection1: TImageCollection
    Images = <
      item
        Name = 'Item1'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              61000000674944415478DAD591E10AC0200884F5C9B79EDC2921B8D1C5AD7E8C
              099161F7D9999A98EC8422807AC96B8ACE3F01C41EA29AD380DA1575A700992F
              0166DEC917342F9E12CBE458B1D02C841D9456EEA021E02948508542C0E8F2F7
              806AEBD50CD0E4E95F60E2026F537AF152CE794F0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item2'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              61000000784944415478DAAD935112802008057927574F4E608D6511D0D8FBC1
              415D3727C1C4B41228005A8CC81CD200C93C01A4202E407BBD3A9009304E1DE3
              6A6E622A080D768B26B0F2E85D21A6C1996A02B4D7AB405206F3A7B5F80E3C83
              FB019F0CA68B3C6CDC1F296DF0BA801AA70C22C0920105C12FAF71251B84137E
              78751E98B10000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item3'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              610000009E4944415478DAA593010E80200845FD37F366D2CDBC9909A94313B5
              C5E66204DF37012497DC1FC34C001C569673B014180BA4A8443029D582EC2422
              76490EFB5C5C0BAB4F442A879A48111005F911639CA27AEF9B885CD20BB8A6BC
              327DD184E0FC98047DD28AE680E079CCF06E1BAED289B027B004382EDF2CB225
              801A84947B5A09CC39D8118C349F08B4551A7394E5A54F08AC6D84BB8ED6147F
              D7F90640FE867651317D460000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item4'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              610000004E4944415478DA63FCCFF09F8112C038020C6064684451F09FA19E11
              AB012085C892308D181AD0D5211B00D380AE089BAB60F2180660B39564030819
              429401B80CC11906C4028A0DC03070D400060006A749F164BB4D690000000049
              454E44AE426082}
          end>
      end
      item
        Name = 'Item5'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              610000004E4944415478DA63FCCFF09F8112C0380C0D6064684411F8CF50CF48
              B40120CDE81A6006228B23AB831B804D33BA4120797403893600DD7B64B9005B
              D8100C036C9A493680E85820078C1AC0C0000096A749F1A1C3B36C0000000049
              454E44AE426082}
          end>
      end
      item
        Name = 'Item6'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              61000000684944415478DAB593590A002008449BFB1FBA0532225794FC8A725E
              8E197AEBAD122000D672C7DC832B9CF92B4F045810CAA373DC163CC82B660009
              746E12C42A40AA46B305EB15228DFD5341A90756D9EE2B843CEF016280E820BD
              90F428AB16A262F617B251060C3B0D61F1D96C32F30000000049454E44AE4260
              82}
          end>
      end
      item
        Name = 'Item7'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              61000000464944415478DA63FCCFF09F8112C008338011C4C40380EA18091A00
              04D86D6164C46908D10680E4C0349A2124B9009B77883200C335A3060C6B0308
              EA8602AC06900B28360000F85E6AF1B6DC41EF0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item8'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              61000000734944415478DABD93510A002108057D37EFE66E864A41ABE5C2FA53
              9133BC8AC0C4F4A5702280B469F57E5C09049E215BFB58398225724114313B8E
              3433AB6F6C07F84EAE02B6E9EB886E0E0414C296EC3801C25B481208DC5A0E4A
              CF748935784950815D601BB7F02238A9ED2BFCF21BA37A0074EA5FF2B1FA52A3
              0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item9'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              610000005A4944415478DA63FCCFF09F8112C008328011449101807A19E10634
              34303080F0810307F06A72707000AB01D1641B40B10B606A87A3012000A37101
              6475580D201690ED02981A920D80850DD961405B0340809C0C856200B90000A4
              7791F17030F3370000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item10'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              61000000904944415478DAA592DD0DC02008846132DD4CDC4C27A382B121B6FE
              B5F76062C87D1E200200C3420C8CA39A14B8686846C429640B905202EFFD2B64
              3BC1A89D25A0871D037E2510331169FF229985DC2D640868660AA19A735680C8
              42A6009DBE736A6E09248DDDC81260750CB0FD4B128A71BF85D910ED368ED7D8
              AFF4D34742C0DBA0802DB779B51A2BA49C47FE872ED02F84F3D9B97EE7000000
              0049454E44AE426082}
          end>
      end
      item
        Name = 'Item11'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              61000000854944415478DAD5934B0EC0200844E1661EADBD1937B3104B3A2A98
              7E5665A1129C17062357AAF4257805602B07A11A66DAEB12606211096BA5145D
              B7BC0317DBC51C22E75D9A0928CE201D40A325EA2C128F90CE8203503CE6BE87
              434400B5E49A450035713F2FB010BE8689C0E263C004CB0068C1CF18AF2DFCA4
              835B6AEF64047CFDCE077C078DF7FD1DD3900000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item12'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              61000000704944415478DAB5D3D10AC020080550EF978FBEDC05B1707673562C
              E845F2546650513919A8532B827851197651B9D08116E0084BB648071862939F
              1D7DFC0578640BB0C83690ADC950832F849D280472D7096A907B11D30710843D
              C16BE23A71864C4FE0FFC2311021F40ABF002BE306F2CF5F74BBECDAB9000000
              0049454E44AE426082}
          end>
      end
      item
        Name = 'Item13'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              61000000A14944415478DAB5D25B1280200805505899EE4CDD99AECCC4C24711
              D94CF155D93DA18419328C8580D383B28EA01432C0C118E3F482B556852A4061
              EF3D38E7DA424AA95D134AEB12D280524727476800B81311A0EEE80BC6987A73
              0E3E21DF012BF50FC087A821757B88FA14684C3CF3733884A08F71DFCBF547EA
              E11EC8E05004FAA1CCBF32802FA82DDD4511B9005221847C872C011AB20C48C8
              6B8091710B1B4AFF85F1182894A20000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item14'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              61000000A74944415478DA9D925B0E032108456165BA336467BA321A4899523A
              EAD4FB6320DC131EA280C03F62402110F4184F00FA3AE431C08D510A7904886D
              1F759001B73BC0D4A284A26C8A32809A5B6B506BB564EF1D3496892982B5C0CC
              4464C931C61292C731801697524083FE06A8B4A33C4A5CE01720CB808817607A
              461FC1E7773333FF8C903BB85D6234032880A63B589E51CD9F93D2F41ACB8F84
              C0B2836C7FA2438E013BBD0099238574ED022A280000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item15'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              610000008B4944415478DAA5925D1280200884E56472743C59092543FEA2ED4B
              0D23DFAE205CE10A7F043D007079A1DC075D003767CD5D01D6003ED4B8BEF5D2
              DC0076DD8780997B3D070578DD892820A27E05E0993AAB6E7E8C73122E78649B
              35815C6553C55001A304B65E225B7719E20C1023EA7F4AF401E9164EAFA009CA
              163C83ACE3CB16EC3BF02618BEC413DD39E17CF5C0682CAA0000000049454E44
              AE426082}
          end>
      end
      item
        Name = 'Item16'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              61000000424944415478DAEDD1C10A00200803D0EDCBC32F5F744F3017746977
              1F5329084E780520E25811065B803440461F481B2CB9BCF7AEC17BC0BE4179F0
              7F2107AC1B3899CC315EF12889F5D20000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item17'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              610000003F4944415478DAEDD2310A00300803C0E4E5E2CB539C8B2DA2A31933
              9C0A52103AE108407859118C4F4032908EACFF02E50D42BEEE8B4959BFC002E3
              9FD8C90184E082F1DF62F5CE0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item18'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              610000005C4944415478DACD90410AC0200C04775F2EBE7CC5830551DB4D7AD1
              5B102693A120FC79EC00A25A14A13005900AC89A0758067DCBEBAD5F0643336A
              1202EC5A841A1C0D9E21D1E208707BA401A3C70288B4580CA60FB3C7E500A741
              039A58667861A1A22C0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item4A'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              61000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
              00097048597300000EC200000EC20115284A800000018769545874584D4C3A63
              6F6D2E61646F62652E786D7000000000003C3F787061636B657420626567696E
              3D27EFBBBF272069643D2757354D304D7043656869487A7265537A4E54637A6B
              633964273F3E0D0A3C783A786D706D65746120786D6C6E733A783D2261646F62
              653A6E733A6D6574612F223E3C7264663A52444620786D6C6E733A7264663D22
              687474703A2F2F7777772E77332E6F72672F313939392F30322F32322D726466
              2D73796E7461782D6E7323223E3C7264663A4465736372697074696F6E207264
              663A61626F75743D22757569643A66616635626464352D626133642D31316461
              2D616433312D6433336437353138326631622220786D6C6E733A746966663D22
              687474703A2F2F6E732E61646F62652E636F6D2F746966662F312E302F223E3C
              746966663A4F7269656E746174696F6E3E313C2F746966663A4F7269656E7461
              74696F6E3E3C2F7264663A4465736372697074696F6E3E3C2F7264663A524446
              3E3C2F783A786D706D6574613E0D0A3C3F787061636B657420656E643D277727
              3F3E2C94980B0000004D49444154384F636018058CE8021860D18BFF28FC3809
              1C7AD0152E7AF11F430C268E15206BC0A9080A90E4995065A092389D8909300D
              6020C2054800BB010C780C21D185980097C1A3807C0000809524EBC7B4E2A000
              00000049454E44AE426082}
          end>
      end
      item
        Name = 'Item5A'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              61000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
              00097048597300000EC200000EC20115284A800000018769545874584D4C3A63
              6F6D2E61646F62652E786D7000000000003C3F787061636B657420626567696E
              3D27EFBBBF272069643D2757354D304D7043656869487A7265537A4E54637A6B
              633964273F3E0D0A3C783A786D706D65746120786D6C6E733A783D2261646F62
              653A6E733A6D6574612F223E3C7264663A52444620786D6C6E733A7264663D22
              687474703A2F2F7777772E77332E6F72672F313939392F30322F32322D726466
              2D73796E7461782D6E7323223E3C7264663A4465736372697074696F6E207264
              663A61626F75743D22757569643A66616635626464352D626133642D31316461
              2D616433312D6433336437353138326631622220786D6C6E733A746966663D22
              687474703A2F2F6E732E61646F62652E636F6D2F746966662F312E302F223E3C
              746966663A4F7269656E746174696F6E3E313C2F746966663A4F7269656E7461
              74696F6E3E3C2F7264663A4465736372697074696F6E3E3C2F7264663A524446
              3E3C2F783A786D706D6574613E0D0A3C3F787061636B657420656E643D277727
              3F3E2C94980B0000004B49444154384F636018058CE8020C8B5EFC47E1C74960
              AAC109D035C3C4D0C5D1F9B80591004C1ECD4026643578419C0423364B883700
              8B6606140370D8C0C0805B3326205AE128A02A00000F5924EB426DA0D0000000
              0049454E44AE426082}
          end>
      end>
    Left = 252
    Top = 160
  end
  object VirtualImageList1: TVirtualImageList
    AutoFill = True
    DisabledOpacity = 100
    DisabledGrayscale = True
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'Item1'
        Name = 'Item1'
      end
      item
        CollectionIndex = 1
        CollectionName = 'Item2'
        Name = 'Item2'
      end
      item
        CollectionIndex = 2
        CollectionName = 'Item3'
        Name = 'Item3'
      end
      item
        CollectionIndex = 3
        CollectionName = 'Item4'
        Name = 'Item4'
      end
      item
        CollectionIndex = 4
        CollectionName = 'Item5'
        Name = 'Item5'
      end
      item
        CollectionIndex = 5
        CollectionName = 'Item6'
        Name = 'Item6'
      end
      item
        CollectionIndex = 6
        CollectionName = 'Item7'
        Name = 'Item7'
      end
      item
        CollectionIndex = 7
        CollectionName = 'Item8'
        Name = 'Item8'
      end
      item
        CollectionIndex = 8
        CollectionName = 'Item9'
        Name = 'Item9'
      end
      item
        CollectionIndex = 9
        CollectionName = 'Item10'
        Name = 'Item10'
      end
      item
        CollectionIndex = 10
        CollectionName = 'Item11'
        Name = 'Item11'
      end
      item
        CollectionIndex = 11
        CollectionName = 'Item12'
        Name = 'Item12'
      end
      item
        CollectionIndex = 12
        CollectionName = 'Item13'
        Name = 'Item13'
      end
      item
        CollectionIndex = 13
        CollectionName = 'Item14'
        Name = 'Item14'
      end
      item
        CollectionIndex = 14
        CollectionName = 'Item15'
        Name = 'Item15'
      end
      item
        CollectionIndex = 15
        CollectionName = 'Item16'
        Name = 'Item16'
      end
      item
        CollectionIndex = 16
        CollectionName = 'Item17'
        Name = 'Item17'
      end
      item
        CollectionIndex = 17
        CollectionName = 'Item18'
        Name = 'Item18'
      end
      item
        CollectionIndex = 18
        CollectionName = 'Item4A'
        Name = 'Item4A'
      end
      item
        CollectionIndex = 19
        CollectionName = 'Item5A'
        Name = 'Item5A'
      end>
    ImageCollection = ImageCollection1
    Left = 136
    Top = 160
  end
  object ActionManager1: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Items = <
              item
                Action = FileNew1
                ImageIndex = 6
                ImageName = 'Item7'
                ShortCut = 16462
              end
              item
                Action = FileOpen1
                ImageIndex = 7
                ImageName = 'Item8'
                ShortCut = 16463
              end
              item
                Action = FileClose1
              end
              item
                Action = FileSave1
                ImageIndex = 8
                ImageName = 'Item9'
                ShortCut = 16467
              end
              item
                Action = FileSaveAs1
              end
              item
                Action = FileTwoOpen
                Caption = '&FileTwoOpen'
                ImageIndex = 6
                ImageName = 'Item7'
                ShortCut = 16468
              end
              item
                Action = FileFourOpen
                Caption = 'F&ileFourOpen'
                ImageIndex = 6
                ImageName = 'Item7'
                ShortCut = 16454
              end
              item
                Action = FileExit1
              end>
            Caption = '&File'
          end
          item
            Items = <
              item
                Action = EditCut1
                ImageIndex = 0
                ImageName = 'Item1'
                ShortCut = 16472
              end
              item
                Action = EditCopy1
                ImageIndex = 1
                ImageName = 'Item2'
                ShortCut = 16451
              end
              item
                Action = EditPaste1
                ImageIndex = 2
                ImageName = 'Item3'
                ShortCut = 16470
              end>
            Caption = '&Edit'
          end
          item
            Items = <
              item
                Action = WindowCascade1
                ImageIndex = 17
                ImageName = 'Item18'
              end
              item
                Action = WindowTileHorizontal1
                ImageIndex = 15
                ImageName = 'Item16'
              end
              item
                Action = WindowTileVertical1
                ImageIndex = 16
                ImageName = 'Item17'
              end
              item
                Action = WindowMinimizeAll1
              end>
            Caption = '&Window'
          end
          item
            Items = <
              item
                Action = HelpAbout1
                ImageIndex = 11
                ImageName = 'Item12'
              end>
            Caption = '&Help'
          end>
        ActionBar = ActionMainMenuBar1
      end>
    LinkedActionLists = <
      item
        ActionList = ActionList1
        Caption = 'ActionList1'
      end>
    Left = 136
    Top = 96
    StyleName = 'Platform Default'
  end
  object Timer1: TTimer
    Interval = 333
    Left = 704
    Top = 88
  end
end
