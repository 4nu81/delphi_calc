unit Graph;

interface

uses Messages, SysUtils, Variants, Classes, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Graphics, Math, TermUnit, TransString;

type
  TOnVarListChange = procedure(AList : TVarList) of Object;

type
  TGraph=class
  private
    FTerm: TBaseTerm; //Termbaum
    FTrans: TTransString; //String wird zu Term transformiert
    FList: TVarList; //Liste der Variablen im Term
    FHeight : Integer; //Höhe des Images
    FWidth : Integer; //Breite des Images
    FCanvas : TCanvas; //Zeichenwerkzeug
    FOnListChange: TOnVarListChange; //Trigger für Veränderungen der Variablenliste
    destructor destruct;
    function vt(c,d,y : double) : integer; //rechnet Welt.Punkte in Bild.Pixel um
    function ut(a,b,x : double) : integer; //rechnet Welt.Punkte in Bild.Pixel um
    procedure initKreuz(a,b,c,d,xmin,xmax,ymin,ymax: double); //Initialisiert Achsen des Koordinatensystems
    function scale(min,max:double):double; //Ermittelt Schrittweite der Scalen des Koordinatensystems
    procedure initRand(a,b,c,d,xmin,xmax,ymin,ymax: double); //Schreibt Scale an den Rand des Images
  public
    constructor create(height, width : integer; ACanvas: TCanvas);
    procedure   Initialize(a,b,c,d,xmin,xmax,ymin,ymax: double); //Initialisiert Koordinatensystem
    property OnVarListChange : TOnVarListChange read FOnListChange write FOnListChange; //Trigger für Variablenlistenänderung
    procedure DrawGraph(a,b,c,d,xmin,xmax,ymin,ymax : double; STerm, Laufvar : String); //Zeichnet Graphen
    procedure DrawGraphChoice(a,b,c,d,xmin,xmax,ymin,ymax: Double; STerm, Laufvar, schaarvar: String; //Zeichnet Graphenschaar
    vschaar: boolean;vschaarmin,vschaarmax,vschaardelta: double; color: integer);
    procedure ParseTerm(STerm : String); //Startet Umwandlung vom String zum Term
    Property height : integer read Fheight write Fheight; //Höhe des Bildes
    Property width : integer read FWidth write FWidth; //Breite des Bildes
    function gety(LaufVar:String; a,b:double; x:integer) : double;
    function getx(a,b:double; x:integer) : double;
  end;


implementation


constructor TGraph.create(height, width : integer; ACanvas:TCanvas);
begin
  inherited create;
  FHeight:= height;
  FWidth:= width;
  FCanvas:=ACanvas;
  FTrans:=TTransString.create;
end;

destructor TGraph.destruct;
begin
  inherited;
end;

procedure TGraph.DrawGraph(a,b,c,d,xmin,xmax,ymin,ymax : Double; STerm, Laufvar : String);
var
  x,y,y2 : double;
begin
  if FTerm=nil then exit;
// Startpunkt
  x := xmin;
  FList.setze(Laufvar, x);
  y:=FTerm.ergebnis; // Funktionsgleichung
  FCanvas.MoveTo(ut(a,b,x),vt(c,d,y)); // Zur Startposition wechseln
// Graph
  while x < xmax do
  begin
    FList.setze(Laufvar, x);
    y:=FTerm.ergebnis; // Funktionsgleichung
    if y<ymin then y:=ymin-1; //Zerstört zu kleine Werte
    if y>ymax then y:=ymax+1; //Zerstört zu große Werte
    FCanvas.LineTo(ut(a,b,x),vt(c,d,y)); // Graphteilabschnitt zeichnen
    x:=x+((xmax-xmin)/1000); // 1000 Schritte im Wertebereich
  end;
  FList.setze(Laufvar, 1);
end;

procedure TGraph.DrawGraphChoice(a, b, c, d, xmin, xmax, ymin, ymax: Double;
  STerm, Laufvar, schaarvar: String; vschaar: boolean; vschaarmin, vschaarmax,
  vschaardelta: double;color : integer);

//  const Tcl: Array[0..5] of TColor = [clred,clgreen,clyellow,clblue,clskyblue,clblack];
var
  Tcl : Array [0..5] of TColor;
  x : double;
  cl : integer;
  r,g,bl : integer;
  i: integer;
begin
  Tcl[0]:=clred;
  Tcl[1]:=clgreen;
  Tcl[2]:=clyellow;
  Tcl[3]:=clblue;
  Tcl[4]:=clskyblue;
  Tcl[5]:=clblack;
  cl:= color;
  FCanvas.Pen.Color:=TColor(cl);
  if vschaar = false then drawgraph(a,b,c,d,xmin,xmax,ymin,ymax,STerm,Laufvar)
  else begin
    x:=vschaarmin;
    i:=0;
    while x<=vschaarmax do
    begin
      FCanvas.Pen.Color:=TColor(tcl[i]);
      FList.setze(schaarvar, x);
      drawgraph(a,b,c,d,xmin,xmax,ymin,ymax,STerm,Laufvar);
      x:=x+vschaardelta;
      if i<5 then inc(i)
        else i:=0;
    end;
  end;
end;

function TGraph.getx(a, b: double; x: integer): double;
begin
  result:=(x-b)/a;
end;

function TGraph.gety(Laufvar:String; a,b:double;x: integer): double;
var
  xd : double;
begin
  xd:=(x-b)/a;
  if FTerm<>nil then begin
  FList.setze(Laufvar, xd);
  result:=FTerm.ergebnis;
  end
    else result:=0;
end;

procedure TGraph.Initialize(a,b,c,d,xmin,xmax,ymin,ymax: double);
begin
  initKreuz(a, b, c, d, xmin, xmax, ymin, ymax);
  initRand(a, b, c, d, xmin, xmax, ymin, ymax);
end;

procedure TGraph.initKreuz(a, b, c, d, xmin, xmax, ymin, ymax: double);
var
  x : double;
  add : double;
begin
  with FCanvas do
  begin
//  Koordinaten-Kreuz
    Pen.Color := clBlack;
    MoveTo(trunc(ut(a,b,0)),1);
    LineTo(trunc(ut(a,b,0)),FHeight);
    MoveTo(1,trunc(vt(c,d,0)));
    LineTo(FWidth,trunc(vt(c,d,0)));

// Koordinaten-Marker
// Definitionsbereich
    add:=scale(xmin,xmax);
    x:=0;
    while x <= xmax do
    begin
      MoveTo(trunc(ut(a,b,x)),trunc(vt(c,d,0)-5));
      LineTo(trunc(ut(a,b,x)),trunc(vt(c,d,0)+5));
      FCanvas.TextOut(trunc(ut(a,b,x)-10),trunc(vt(c,d,0)+10),FloatToStr(x));
      x:=x+add;
    end;
    x:=0;
    while x >= xmin do
    begin
      MoveTo(trunc(ut(a,b,x)),trunc(vt(c,d,0)-5));
      LineTo(trunc(ut(a,b,x)),trunc(vt(c,d,0)+5));
      FCanvas.TextOut(trunc(ut(a,b,x)-10),trunc(vt(c,d,0)+10),FloatToStr(x));
      x:=x-add;
    end;

// Wertebereich
    add:=scale(ymin,ymax);
    x:=0;
    while x <= ymax do
    begin
      MoveTo(trunc(ut(a,b,0)-5),trunc(vt(c,d,x)));
      LineTo(trunc(ut(a,b,0)+5),trunc(vt(c,d,x)));
      FCanvas.TextOut(trunc(ut(a,b,0)+10),trunc(vt(c,d,x)),FloatToStr(x));
      x:=x+add;
    end;
    x:=0;
    while x >= ymin do
    begin
      MoveTo(trunc(ut(a,b,0)-5),trunc(vt(c,d,x)));
      LineTo(trunc(ut(a,b,0)+5),trunc(vt(c,d,x)));
      FCanvas.TextOut(trunc(ut(a,b,0)+10),trunc(vt(c,d,x)),FloatToStr(x));
      x:=x-add;
    end;
  end;
end;

procedure TGraph.initRand(a, b, c, d, xmin, xmax, ymin, ymax: double);
var
  x : double;
  add : double;
begin
  with FCanvas do
  begin

// Rand-Marker
// Definitionsbereich
    add:=scale(xmin,xmax);
    x:=0;
    while x <= xmax do
    begin
      MoveTo(trunc(ut(a,b,x)),1);
      LineTo(trunc(ut(a,b,x)),5);
      FCanvas.TextOut(trunc(ut(a,b,x)-10),10,FloatToStr(x));
      x:=x+add;
    end;
    x:=0;
    while x >= xmin do
    begin
      MoveTo(trunc(ut(a,b,x)),1);
      LineTo(trunc(ut(a,b,x)),5);
      FCanvas.TextOut(trunc(ut(a,b,x)-10),10,FloatToStr(x));
      x:=x-add;
    end;

// Wertebereich
    add:=scale(ymin,ymax);
    x:=0;
    while x <= ymax do
    begin
      MoveTo(1,trunc(vt(c,d,x)));
      LineTo(5,trunc(vt(c,d,x)));
      FCanvas.TextOut(10,trunc(vt(c,d,x)),FloatToStr(x));
      x:=x+add;
    end;
    x:=0;
    while x >= ymin do
    begin
      MoveTo(1,trunc(vt(c,d,x)));
      LineTo(5,trunc(vt(c,d,x)));
      FCanvas.TextOut(10,trunc(vt(c,d,x)),FloatToStr(x));
      x:=x-add;
    end;
  end;
end;

procedure TGraph.ParseTerm(STerm: String);
begin
  FTerm:=FTrans.Buildterm(STerm);
  FList:=FTerm.posvar;
  if Assigned(FOnListChange) then
    FOnListChange(FList);

end;

function TGraph.scale(min, max: double): double;
begin
  if max-min<=5    then result := 0.5;
  if max-min>5    then result := 1;
  if max-min>20   then result := 5;
  if max-min>50   then result := 10;
  if max-min>100  then result := 20;
  if max-min>500  then result := 50;
  if max-min>1000 then result := 100;
  if max-min>2000 then result := 500;
  if max-min>5000 then result := 1000;
end;

function TGraph.ut(a,b,x : double) : integer;
begin
  result := round(a*x+b);
end;

function TGraph.vt(c,d,y : double) : integer;
begin
  result := round(c*y+d);
end;

end.
