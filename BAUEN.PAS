type
material=array[1..20] of word;
var
haus:array[1..20,1..10] of record
                          gebaut:boolean;
                          inhalt:material;
                         end;
baums,steins:integer;
pott:material;
a:char;
y,ya,z:byte;
wasser:boolean;
procedure built(zahl:byte);
var i:word;
begin
 for i:=1 to 10 do begin
  if haus[zahl,i].gebaut=false then begin
   case zahl of
    1..3:if pott[2]<2 then exit else dec(pott[2],2);
    4:if (pott[2]<2) or (pott[3]<2) then exit else begin dec(pott[2],2);dec(pott[3],2);end;
    5..6:if pott[2]<4 then exit else dec(pott[2],4);
    7..8:if (pott[2]<3) or (pott[3]<3) then exit else begin dec(pott[2],3);dec(pott[3],3);end;
    9:if pott[2]<2 then exit else dec(pott[2],2);
    10:if (pott[2]<3) or (pott[3]<3) then exit else begin dec(pott[2],4);dec(pott[3],4);end;
    11..13:if (pott[2]<3) or (pott[3]<3) then exit else begin dec(pott[2],3);dec(pott[3],3);end;
   end;
   haus[zahl,i].gebaut:=true;exit;
  end;
 end;
end;

procedure produziere;
var i,ii:word;
begin
 for ii:=1 to 10 do begin
  for i:=1 to 10 do begin
   if haus[i,ii].gebaut then begin
    case i of
     1:inc(baums);                                               {J„ger}
     2:if baums>0 then begin dec(baums);inc(pott[1]);end;        {Holzf„ller}
     3:if steins>0 then begin dec(steins);inc(pott[3]);end;      {Steinmetz}
     4:if pott[1]>0 then begin dec(pott[1]);inc(pott[2]);end;    {Schreinerei}
     5:if (pott[8]>0) then begin dec(pott[8]);inc(pott[4]);end;                                             {Kohlebergwerk}
     6:if (pott[8]>0) then begin dec(pott[8]);inc(pott[5]);end;                                             {Kohlebergwerk}
     7:if (pott[5]>0) and (pott[4]>0) then begin dec(pott[4]);dec(pott[5]);inc(pott[6]);end;    {Stahlkocher}
     8:if (pott[4]>0) and (pott[6]>0) then begin dec(pott[4]);dec(pott[6]);inc(pott[7]);end;    {Schmied}
     9:if wasser then inc(pott[8]);
    10:begin inc(pott[9]);inc(pott[10],3);end;
    end;
   end;
  end;
 end;
end;
function anzahl(art:byte):byte;
var i,temp:byte;
begin
 temp:=0;
 for i:=1 to 10 do begin
  if haus[art,i].gebaut then inc(temp);
 end;
 anzahl:=temp;
end;

begin
 wasser:=true;baums:=30;pott[1]:=100;pott[2]:=100;pott[3]:=100;steins:=500;
 repeat
  a:=#0;
  z:=0;
  clrscr;
  writeln('B„ume       : ',baums);
  writeln('Steine      : ',steins);
  writeln('Holzst„mme  : ',pott[1]);
  writeln('Holzbretter : ',pott[2]);
  writeln('Stein       : ',pott[3]);
  writeln('Kohle       : ',pott[4]);
  writeln('Eisen       : ',pott[5]);
  writeln('Stahl       : ',pott[6]);
  writeln('Waffen      : ',pott[7]);
  writeln('Nahrung     : ',pott[8]);
  writeln('Schweine    : ',pott[9]);
  writeln('Getreide    : ',pott[10]);
  writeln;
  writeln('1 : F”rster     : ',anzahl(1));
  writeln('2 : Holzf„ller  : ',anzahl(2));
  writeln('3 : Steinmetze  : ',anzahl(3));
  writeln('4 : Schreinerei : ',anzahl(4));
  writeln('5 : Kohlebergw. : ',anzahl(5));
  writeln('6 : Eisenbergw. : ',anzahl(6));
  writeln('7 : Stahlkocher : ',anzahl(7));
  writeln('8 : Schmied     : ',anzahl(8));
  writeln('9 : Fischer     : ',anzahl(9));
  writeln('10: Farmer      : ',anzahl(10));

    repeat
   if keypressed then begin
    a:=readkey;
    ya:=y;
    case a of
    #72:if y>1 then dec(y);
    #80:if y<25 then inc(y);
    #13:a:=#255;
    #27:halt;
    #32:case y of
    14:built(1);
    15:built(2);
    16:built(3);
    17:built(4);
    18:built(5);
    19:built(6);
    20:built(7);
    21:built(8);
    22:built(9);
    23:built(10);
    end;

    end;
    if y<>ya then begin gotoxy(50,ya);write(' ');gotoxy(50,y);write('<');end;
   end;
  until a=#255;
 produziere;
 until z=15;
 clrscr;
end.