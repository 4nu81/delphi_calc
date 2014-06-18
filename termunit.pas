unit termunit;

interface

uses math, contnrs;

type

  TVarList = class;

  TTermOperator = (opPlus, opMinus, opMulti, opDiv, Termopnil, opExp);
  TBaseTerm = class(TObject)
  private
    FVarlist : TVarList;
    FParent : TBaseTerm;
    function getvar : TVarList;
    function GetRootItem: TBaseTerm;
  public
    constructor create(AParent : TBaseTerm);
    destructor destroy; override;
    function ergebnis : double; virtual; Abstract;
    property posvar  : TVarList read getvar;
    property RootItem : TBaseTerm read GetRootItem;
    property Parent : TBaseTerm read FParent write FParent;
    procedure FillList(ATerm : TBaseTerm; var AList : TVarList);
  end;

  TTermclass=class of TTerm;

  TTerm=class(TBaseTerm)
  private
    Fright: TBaseTerm;
    Fleft: TbaseTerm;
    procedure Setleft(const Value: TBaseTerm);
    procedure Setright(const Value: TBaseTerm);
  published
  public
    Constructor Create(AParent : TBaseTerm; ALeft : TBaseTerm = nil;ARight : TBaseTerm = nil);
    property right : TBaseTerm read Fright write Setright;
    property left : TBaseTerm read Fleft write Setleft;

  end;


  TvalTerm = class(TBaseTerm)
  private
    FWert: double;
  published
  public
    constructor Create(Wert : double;AParent : TBaseTerm);
    function ergebnis : double; override;
    property Wert : double read FWert write FWert;
  end;


  TSQRTerm = class(TTerm)
  public
    function ergebnis : double; override;
  end;

  TExpTerm = Class(TTerm)
  public
    function ergebnis : double; override;
  End;

  TAddTerm = Class(TTerm)
  public
    function ergebnis : double; override;
  End;

  TSubTerm = Class(TTerm)
  public
    function ergebnis : double; override;
  End;

  TMalTerm = Class(TTerm)
  public
    function ergebnis : double; override;
  End;

  TDivTerm = Class(TTerm)
  public
    function ergebnis : double; override;
  End;

  TSinTerm = Class(TTerm)
  public
    function ergebnis : double; override;
  End;

  TCosTerm = Class(TTerm)
  public
    function ergebnis : double; override;
  End;


  TTanTerm = Class(TTerm)
  public
    function ergebnis : double; override;
  End;


  TVarTerm = Class(TValTerm)
  private
    FName : String;
  public
    constructor create(AParent : TBaseTerm;AName : String; AValue : Double = 1);
    function ergebnis : double; override;
    property Name : String read FName;
  End;

  TVarList = class(TObjectList)
  private
    function getitems(index: integer): TVarTerm;
  published
  public
    procedure setze(Laufvar:String;x:double);
    procedure add(AVarTerm : TVarTerm);
    Procedure setvalue(AName: String; AWert : double);
    function  FindByName(STerm : String): TVarTerm;
    property items[index:integer] : TVarTerm read getitems;
  end;


implementation

uses
  SysUtils;

{ term }

constructor TTerm.Create(AParent : TBaseTerm;ALeft: TBaseTerm; ARight : TBaseTerm);
begin
  inherited Create(AParent);
  if ALeft <> nil then
  begin
    Fleft:=ALeft;
    Fleft.Parent:=self;
  end else FLeft:= nil;
  if ARight <> nil then
  begin
    Fright:=ARight;
    FRight.Parent:=self;
  end else FRight:= nil;
end;

procedure Tterm.Setleft(const Value: TBaseTerm);
begin
  Fleft := Value;
end;

procedure Tterm.Setright(const Value: TBaseTerm);
begin
  Fright := Value;
end;

{ TSQRTerm }

function TSQRTerm.ergebnis: double;
begin
  if right.ergebnis>=0 then result:=Power(right.ergebnis,0.5)
  else raise exception.create('Wurzel negativer Zahl');
end;

{ TvalTerm }

constructor TvalTerm.Create(Wert: double;AParent : TBaseTerm);
begin
  inherited create(AParent);
  FWert:=Wert;
end;

function TvalTerm.ergebnis: double;
begin
  result:=FWert;
end;

{ TExpTerm }

function TExpTerm.ergebnis: double;
begin
  result:=Power(left.ergebnis,right.ergebnis);
end;

{ TAddTerm }

function TAddTerm.ergebnis: double;
begin
  result:=left.ergebnis+right.ergebnis;
end;

{ TSubTerm }

function TSubTerm.ergebnis: double;
begin
  result:=left.ergebnis-right.ergebnis;
end;

{ TMalTerm }

function TMalTerm.ergebnis: double;
begin
  result:=left.ergebnis*right.ergebnis;
end;

{ TDivTerm }

function TDivTerm.ergebnis: double;
begin
  if right.ergebnis<>0 then result:=left.ergebnis/right.ergebnis
  else raise exception.create('Division durch Null');
end;

{ TSinTerm }

function TSinTerm.ergebnis: double;
var
  cos,sin: extended;
begin
  math.SinCos(right.ergebnis,sin,cos);
  result:=sin;
end;

{ TCosTerm }

function TCosTerm.ergebnis: double;
var
  cos,sin: extended;
begin
  math.SinCos(right.ergebnis,sin,cos);
  result:=cos;
end;

{ TBaseTerm }

constructor TBaseTerm.create(AParent : TBaseTerm);
begin
  inherited create;
  FParent:=AParent;
  FVarList:=TVarList.create(false);
end;

destructor TBaseTerm.destroy;
begin
  FVarList.destroy;
  inherited;
end;

procedure TBaseTerm.FillList(ATerm: TBaseTerm; var AList: TVarList);
begin
  if ATerm is TVarTerm then AList.add(TVarTerm(ATerm));
  if ATerm is TTerm then
  begin
    FillList(TTerm(ATerm).left, AList);
    FillList(TTerm(ATerm).right, AList);
  end;
end;

function TBaseTerm.GetRootItem: TBaseTerm;
begin
  result:=self;
  if FParent<>nil then result:=self.FParent.RootItem;
end;

function TBaseTerm.getvar: TVarList;
begin
  FVarList.Clear;
  FillList(self, FVarList);
  result:=FVarList;
end;

{ TVarTerm }

constructor TVarTerm.create(APArent:TBaseTerm;AName: String; AValue: Double);
begin
  inherited create(AValue,AParent);
  Fname := AName;
end;

function TVarTerm.ergebnis: double;
begin
  result:=inherited ergebnis;
end;

{ TVarList }

procedure TVarList.add(AVarTerm: TVarTerm);
begin
  inherited add(AVarTerm);
end;

function TVarList.FindByName(STerm: String): TVarTerm;
var
  i: Integer;
begin
  result:=nil;
  for i := 0 to Self.Count - 1 do
    if self.items[i].Name=STerm then
      result:=self.items[i];
end;

function TVarList.getitems(index: integer): TVarTerm;
begin
  result:=TVarTerm(self.Get(index));
end;

procedure TVarList.setvalue(AName: String; AWert: double);
var
  i: Integer;
begin
  for i := 0 to self.Count-1 do
    begin
      if self.items[i].name = AName then self.items[i].Wert:=AWert;
    end;
end;

procedure TVarList.setze(Laufvar: String; x: double);
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    if Self.items[i].Name = Laufvar then
      self.Items[i].Wert:=x;
end;

{ TTanTerm }

function TTanTerm.ergebnis: double;
begin
  result:=math.Tan(right.ergebnis);
end;

end.
