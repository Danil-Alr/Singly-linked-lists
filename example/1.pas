type 
	plist=^tlist;
	tlist=record
		key:integer;
		pnext:plist;
	end;
	
	var PH:PList=nil;
		p:plist;
		key:integer;
BEGIN
	while(true) do begin
		readln(key);
		if key=0 then break;
		new(p);
		p^.key:=key;
		p^.pnext:=nil;
		if ph=nil then ph:=p
		else begin
			p^.pnext:=ph;
			ph:=p;
		end;
	end;
	p:=ph;
	while p<>nil do begin
		writeln(p^.key);
		p:=p^.pnext;
	end;
END.

