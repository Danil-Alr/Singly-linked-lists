{$mode objfpc}
uses heaptrc;
type 
	plist=^tlist;
	tlist=record
		key:integer;
		pnext:plist;
	end;

procedure DisposeList(var phead:plist);
	var p:plist;
 begin
{
	if phead=nil then exit;
	disposeList(phead^.pnext);
	dispose(phead);
	phead:=nil;
}
	while phead<>nil do begin
		p:=phead^.pnext;
		dispose(phead);
		phead:=p;
	end;	
 end;

function CountElements(phead:plist):integer;
 begin
	result:=0;
	while phead<>nil do begin
		phead:=phead^.pnext;
		inc(Result);
	end;	
 end;
 
 
function CreateElement(key:integer):plist;
 begin
	new(result);
	result^.key:=key;
	result^.pnext:=nil;
 end;

procedure AddFirstElement(var phead:plist; p:plist);
 begin
	if phead=nil then phead:=p
	else begin
		p^.pnext:=phead;
		phead:=p;
	end;
 end;

procedure AddLastElement(var phead:plist; p:plist);
	var q:plist;
 begin
	if phead=nil then begin phead:=p; exit; end;
	q:=phead;
	while q^.pnext<>nil do q:=q^.pnext;
	q^.pnext:=p;	
 end;

procedure InsertAfterElement(pEl:plist; p:plist);
 begin
	if pEl=nil then exit;
	p^.pnext:=pEl^.pnext;
	pEl^.pnext:=p;	
 end;

function DeleteNextElement(pprev:plist):plist;
 begin
	result:=nil;
	if (pprev=nil)or(pprev^.pnext=nil) then exit;
	result:=pprev^.pnext;
	pprev^.pnext:=result^.pnext;
	result^.pnext:=nil;
 end;

type TListAction=function (pEl:plist):boolean;
procedure ListAction(phead:plist; proc:TListAction);
begin
	while phead<>nil do begin
		if not proc(phead) then exit;
		phead:=phead^.pnext;
	end;
end;

function outElement(pEl:plist):boolean;
begin
	writeln(pEl^.key);
	result:=true;
end;	

procedure outList(ph:plist);
 begin
	listAction(ph,@outElement);
 end;	

	
	var PH:PList=nil;
		//q,
		p:plist;
		key:integer;
BEGIN
	while(true) do begin
		readln(key);
		if key=0 then break;
		p:=CreateElement(key);
		//addFirstElement(ph,p);
		addLastElement(ph,p);
	end;
	insertAfterElement(ph^.pnext,createElement(100));
	outList(ph);
	p:=DeleteNextElement(ph^.pnext);
	outList(ph);
	writeln('--------');
	outList(p);
	writeln('--------');
	writeln(countElements(ph));
	disposeList(p);
	disposeList(ph);
END.

