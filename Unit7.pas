unit Unit7;

interface

uses
  Messages, SysUtils, Variants, Classes, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Graphics, Graph, imaging, Grids, ValEdit,
  Termunit, TransString, unit2, Mask, ToolEdit, CurrEdit;

type
  TForm7 = class(TForm)
    Panel: TPanel;
    TX3: TEdit;
    ButtonGraph: TButton;
    Lbl10: TLabel;
    Lbl11: TLabel;
    Lbl12: TLabel;
    Lbl13: TLabel;
    Image: TImagePlus;
    Panel2: TPanel;
    VarEditor: TValueListEditor;
    LaufVar: TEdit;
    BtnRechne: TButton;
    Btndel: TButton;
    BtnHelp: TButton;
    Lbl2: TLabel;
    Lbl4: TLabel;
    SchaarVar: TEdit;
    Schaar1: TCheckBox;
    ColorBar: TScrollBar;
    ColorPanel: TPanel;
    xmin: TRxCalcEdit;
    xmax: TRxCalcEdit;
    ymin: TRxCalcEdit;
    ymax: TRxCalcEdit;
    Panel24: TPanel;
    xWert: TLabel;
    YWert: TLabel;
    Schaarmin: TEdit;
    Schaarmax: TEdit;
    Schaardelta: TEdit;
    procedure GraphClick;
    procedure FormResize(Sender: TObject);
    procedure ButtonGraphClick(Sender: TObject);
    procedure VarEditorSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure BtnRechneClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure getmeasures(var a,b,c,d,vxmin,vxmax,vymin,vymax :double);
    procedure BtndelClick(Sender: TObject);
    procedure BtnHelpClick(Sender: TObject);
    procedure ColorBarChange(Sender: TObject);
    procedure yminChange(Sender: TObject);
    procedure ImageMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    Graph : TGraph;
    procedure OnVarListChange(AList : TVarList);
    procedure OnBoarderChange();
  public
    { Public-Deklarationen }
  end;

var
  Form7: TForm7;

implementation


{$R *.dfm}


{ TForm7 }

procedure TForm7.GraphClick;
var
  a,b,c,d : double;
  vxmin,vxmax,vymin,vymax : double;
  vschaar : boolean;
  vschaarvar : string;
  vschaarmin,vschaarmax,vschaardelta : double;
begin
  vschaarvar:=SchaarVar.text;
  vschaar:=Schaar1.Checked;
  vschaarmin:=StrToFloat(Schaarmin.text);
  vschaarmax:=StrToFloat(Schaarmax.text);
  vschaardelta:=StrToFloat(Schaardelta.text);
  getmeasures(a,b,c,d,vxmin,vxmax,vymin,vymax);
  Graph.Initialize(a,b,c,d,vxmin,vxmax,vymin,vymax);
  Graph.DrawGraphChoice(a,b,c,d,vxmin,vxmax,vymin,vymax,TX3.text,Laufvar.text,vschaarvar,
  vschaar,vschaarmin,vschaarmax,vschaardelta,ColorPanel.Color);
end;

procedure TForm7.ImageMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  yd,xd,a,b,c,d : Double;
  vxmin,vxmax,vymin,vymax : double;
begin
//  if ssleft in Shift then
  try
  begin
    getmeasures(a,b,c,d,vxmin,vxmax,vymin,vymax);
    yd:=Graph.gety(Laufvar.text,a,b,x);
    xd:=Graph.getx(a,b,x);
    xd:=round(xd*10000)/10000;
    yd:=round(yd*10000)/10000;
    xWert.caption:='x= '+FloatToStr(xd);
    yWert.caption:='y= '+FloatToStr(yd);
  end;
  finally
  end;
end;

procedure TForm7.OnBoarderChange;
var
  a,b,c,d : double;
  vxmin,vxmax,vymin,vymax : double;
begin
  Image.Canvas.Brush.Color := clWhite;
  Image.Canvas.FillRect(Image.Canvas.ClipRect);
  getmeasures(a,b,c,d,vxmin,vxmax,vymin,vymax);
  Graph.Initialize(a,b,c,d,vxmin,vxmax,vymin,vymax);
  graphclick;
end;

procedure TForm7.OnVarListChange(AList: TVarList);
var
  i : integer;
begin
  VarEditor.Strings.Clear;
  for i := 0 to AList.Count - 1 do
  begin
    if VarEditor.Strings.IndexOfObject(AList.items[i])<0 then
    Vareditor.Strings.AddObject(AList.items[i].Name+'='+FloatToStr(AList.Items[i].ergebnis),AList.items[i]);
  end;

end;

procedure TForm7.VarEditorSetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: string);
var
  i: Integer;
begin
  if (ARow <= Vareditor.Strings.Count) and (Vareditor.Strings.Count >= 0) then
  TVarTerm(VarEditor.Strings.Objects[ARow-1]).Wert := StrToFloatDef(Value,0);
end;

procedure TForm7.yminChange(Sender: TObject);
begin
  OnBoarderChange;
end;

procedure TForm7.BtndelClick(Sender: TObject);
var
  a,b,c,d : double;
  vxmin,vxmax,vymin,vymax : double;
begin
  Image.Canvas.Brush.Color := clWhite;
  Image.Canvas.FillRect(Image.Canvas.ClipRect);
  getmeasures(a,b,c,d,vxmin,vxmax,vymin,vymax);
  Graph.Initialize(a,b,c,d,vxmin,vxmax,vymin,vymax);
end;

procedure TForm7.BtnHelpClick(Sender: TObject);
begin
  Help.show;
end;

procedure TForm7.BtnRechneClick(Sender: TObject);
begin
  graph.ParseTerm(TX3.text);
  graphclick;
  ButtonGraph.Visible:=true;
  ButtonGraph.Caption:= 'Draw '+TX3.text;
  Form7.caption:='FunctionDraw '+TX3.text;
  BtnRechne.height:=33;
end;

procedure TForm7.ButtonGraphClick(Sender: TObject);
begin
  Graphclick;
end;

procedure TForm7.ColorBarChange(Sender: TObject);
begin
  ColorPanel.Color:=Colorbar.Position*250;
end;

procedure TForm7.FormCreate(Sender: TObject);
begin
  Graph:=TGraph.create(image.height, image.width, Image.Canvas);
  Graph.OnVarListChange:=OnVarListChange;
end;

procedure TForm7.FormDestroy(Sender: TObject);
begin
  graph.free;
end;

procedure TForm7.FormResize(Sender: TObject);
var a,b,c,d,vxmin,vxmax,vymin,vymax : double;
begin
  image.picture.bitmap.width:=width;
  image.picture.bitmap.height:=height;
  graph.height:=image.height;
  graph.width:=image.width;
  Image.Canvas.Brush.Color := clWhite;
  Image.Canvas.FillRect(Image.Canvas.ClipRect);
  getmeasures(a,b,c,d,vxmin,vxmax,vymin,vymax);
  Graph.Initialize(a,b,c,d,vxmin,vxmax,vymin,vymax);
  graphclick;
end;

procedure TForm7.getmeasures(var a, b, c, d, vxmin, vxmax, vymin, vymax: double);
var
  FHeight,FWidth : integer;
begin
  Fheight:=Image.Height-1;
  Fwidth:=Image.Width-1;
  vxmin:=xmin.value;
  vxmax:=xmax.value;
  vymax:=ymax.value;
  vymin:=ymin.value;
  a:=Fwidth/(vxmax-vxmin);
  b:=-a*vxmin;
  c:=FHeight/(vymin-vymax);
  d:=-c*vymax;
end;

end.
