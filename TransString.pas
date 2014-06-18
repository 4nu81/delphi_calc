unit TransString;

interface

uses TermUnit, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type

TTyp = (sin, cos, add, sub, multi, divi, clamp, value, opnil, neg, exp, sqr, vari, tan);
TResult = record
  pos1 : integer;
  pos2 : integer;
  typ : TTyp;
end;

 TTransString=class
 protected

   function OpSearch(STerm : String) : TResult;
   function SucheSin(STerm : String) : TResult;
   function SucheAdd(STerm: string) : TResult;
   function SucheExp(STerm:String) : TResult;
   function SucheMulti(STerm: string) : TResult;
   function SucheKlammer(STerm: string) : TResult;
   function SucheX(STerm: String) : TResult;
 public
   function BuildTerm(STerm : String;AParent : TBaseTerm=nil) : TBaseTerm;
   function CreateTerm(Termclass:TTermClass; links,rechts: String;AParent:TBaseTerm):TTerm;
end;

implementation

{TRansString}

function TTransString.CreateTerm(Termclass: TTermClass; links,
  rechts: String;AParent:TBaseTerm): TTerm;
begin
  result:=Termclass.Create(AParent,nil,nil);
  if not (links='') then
  begin
    result.left:=BuildTerm(links,result);
    result.left.parent:=result;
  end;
  result.right:=BuildTerm(rechts,result);
  result.right.parent:=result;
end;

function TTransString.OpSearch(STerm: String) : TResult;
var
Zeiger : TResult;
begin
  Zeiger.typ:=value;
  Zeiger:=SucheAdd(STerm);
  if not (Zeiger.typ in [add,sub,neg]) then zeiger:=SucheMulti(STerm);
  if not (Zeiger.typ in [add,sub,neg,multi,divi]) then zeiger:=SucheExp(STerm);
  if not (Zeiger.typ in [add,sub,neg,exp,sqr,multi,divi]) then zeiger:=SucheSin(STerm);
  if not (Zeiger.typ in [sin,cos,tan,add,sub,multi,exp,divi,neg,sqr]) then zeiger:=SucheKlammer(STerm);
  if not (Zeiger.typ in [sin,cos,tan,add,sub,multi,exp,divi,neg,sqr,clamp]) then zeiger:=SucheX(STerm);
  result:=Zeiger;
end;

function TTransString.BuildTerm(STerm: String;APArent : TBaseTerm=nil): TBaseTerm;
var
attrib : TResult;
links,rechts : string;
ATerm : TTerm;
begin
  result:=nil;
  attrib := OpSearch(STerm);
  if not (attrib.typ in [value,clamp,neg,vari]) then
  begin
    links:= copy(STerm,1,attrib.pos1-1);
    rechts:= copy(STerm,attrib.pos1+1,length(STerm)-attrib.pos1+1);
  end;
  case attrib.typ of
    add:   result:=createTerm(TAddTerm,links,rechts,AParent);
    sub:   result:=createTerm(TSubTerm,links,rechts,AParent);
    multi: result:=createTerm(TMalTerm,links,rechts,AParent);
    divi:  result:=createTerm(TDivTerm,links,rechts,APArent);
    clamp: result:=Buildterm(copy(STerm,2,length(STerm)-2),AParent);
    value: result:=TValTerm.create(StrToFloat(STerm),AParent);
    neg:   result:=createTerm(TMalTerm,'-1',copy(Sterm,2,length(Sterm)-1),AParent);
    exp:   result:=createTerm(TExpTerm,links,rechts,AParent);
    sqr:   result:=createTerm(TSQRTerm,'',rechts,AParent);
    sin:   result:=createTerm(TSinTerm,'',rechts,APArent);
    cos:   result:=createTerm(TCosTerm,'',rechts,APArent);
    tan:   result:=createTerm(TTanTerm,'',rechts,APArent);
    vari:  begin
             if AParent<>nil then
               result:=AParent.posvar.FindByName(STerm);
             if result=nil then
               result:=TvarTerm.create(AParent,STerm);
           end;
  end;
end;

function TTransString.SucheAdd(STerm: string): TResult;
var
  clamp: integer;
  pos1: Integer;
begin
  clamp := 0;
  for pos1 := 1 to length(STerm) do
  begin
    if STerm[pos1] = '(' then inc(clamp);
    if STerm[pos1] = ')' then dec(clamp);
    if clamp = 0 then
    begin
      if (STerm[pos1] = '+') then
      begin
        result.pos1 := pos1;
        result.Typ := add;
      end;
      if(STerm[pos1] = '-') and ((pos1<>1) and not(STerm[pos1-1] in ['+','*','-','/'])) then
      begin
        result.pos1 := pos1;
        result.Typ := sub;
      end;
      if(STerm[pos1] = '-') and (pos1=1) and (STerm[pos1+1] in ['+','-','*','/','(']) then result.Typ:=neg;
    end;
  end;
end;

function TTransString.Sucheexp(STerm: String): TResult;
var
  pos1 : integer;
  clamp: integer;
begin
  clamp:=0;
  for pos1 := 1 to length(STerm) do
  begin
    if STerm[pos1] = '(' then inc(clamp);
    if STerm[pos1] = ')' then dec(clamp);
    if clamp = 0 then
      if STerm[pos1]='^' then
      begin
        result.pos1 := pos1;
        result.typ := exp;
      end;
      if STerm[pos1] = 'w' then
      begin
        result.pos1 := pos1;
        result.typ := sqr;
      end;
  end;
end;

function TTransString.SucheMulti(STerm: string) : TResult;
var
  pos1: Integer;
  clamp: integer;
begin
  clamp := 0;
  for pos1 := 1 to length(STerm) do
  begin
    if STerm[pos1] = '(' then inc(clamp);
    if STerm[pos1] = ')' then dec(clamp);
    if clamp = 0 then
      begin
        if STerm[pos1]='*' then
        begin
          result.pos1 := pos1;
          result.typ := multi;
        end;
        if STerm[pos1]='/' then
        begin
          result.pos1 := pos1;
          result.typ := divi;
        end;
      end;
  end;
end;

function TTransString.SucheSin(STerm: String): TResult;
var
  pos1 : integer;
  clamp: integer;
begin
  clamp:=0;
  for pos1 := 1 to length(STerm) do
  begin
    if STerm[pos1] = '(' then inc(clamp);
    if STerm[pos1] = ')' then dec(clamp);
    if clamp = 0 then
      if STerm[pos1]='s' then
      begin
        result.pos1 := pos1;
        result.typ := sin;
      end;
      if STerm[pos1] = 'c' then
      begin
        result.pos1 := pos1;
        result.typ := cos;
      end;
      if STerm[pos1] = 't' then
      begin
        result.pos1 := pos1;
        result.typ := tan;
      end;
  end;
end;

function TTransString.SucheX(STerm: String): TResult;
begin
  if not(STerm[1] in ['0'..'9'])  then
  begin
    result.pos1 := 1;
    result.typ := vari
  end
  else
    result.typ := value;
end;

function TTransString.SucheKlammer(STerm: string): TResult;
var
  pos1: Integer;
  clampcount: integer;
begin
  // Suche Klammer
  clampcount := 0;
  for pos1 := 1 to length(STerm) do
  begin
    if STerm[pos1] = '(' then
    begin
      if clampcount = 0 then
        result.pos1 := pos1;
        result.typ := clamp;
        inc(clampcount);
    end;
    if STerm[pos1] = ')' then
    begin
      dec(clampcount);
      if clampcount = 0 then
      begin
        result.pos2 := pos1;
      end;
    end;
  end;
end;

end.
