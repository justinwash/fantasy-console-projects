pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
--isofight: don't die or fall

function _init()
 --how many players
	num_players=2
 --init player characters
	p={{sprnum=0,drc=false,x=36,
		   y=50,dx=0,dy=0,hp=50,
					stock=5,id=1},
				{sprnum=32,drc=true,x=78,
					y=50,dx=0,dy=0,hp=50,
				 stock=5,id=2}} end

function _update60()
 --check for win conditions
	if p[1].hp<=0 or p[1].stock<=0
		then win(p[2]) end
	if p[2].hp<=0 or p[2].stock<=0
	 then win(p[1]) end
 --update characters
 for c in all(p) do
  c.dx=0 c.dy=0 
  move(c)
  fall(c) end
end

function _draw()
	cls()
	tilemap()
	drawchars()

 print(p[1].falling)
end

function drawchars()
	if p[1].y>p[2].y then
	 	spr(p[2].sprnum,p[2].x,
	 	p[2].y,1,2,p[2].drc)
	 	spr(p[1].sprnum,p[1].x,
	 	p[1].y,1,2,p[1].drc) end
	if p[1].y<=p[2].y then
	 	spr(p[1].sprnum,p[1].x,
	 	p[1].y,1,2,p[1].drc)
	 	spr(p[2].sprnum,p[2].x,
	 	p[2].y,1,2,p[2].drc) end
end

function fall(c)
 clr=6
 if pget(c.x-1,c.y+17)!=clr
 and pget(c.x+8,c.y+17)!=clr
  then c.falling=true 
 else c.falling=false end
 if c.falling == true then
  c.y+=1 end
end

function tilemap()
	startx=48 starty=32 rows=4
	while rows>0 do
		x=startx y=starty c=4
		while c>0 do
			spr(128,x,y,32,32)
			x=x-16 y=y+8 c=c-1
		end
		startx=startx+16
		starty=starty+8
		rows=rows-1
	end
end
	
function move(char)
 if char.id==1 then op=p[2] end
 if char.id==2 then op=p[1] end

 if char.y<=op.y-5
 or char.y>=op.y+5 then
  coly=false
 else coly=true end

 if char.x-op.x<=9
 and op.x-char.x<=0 then
  coll=true
 else coll=false end

 if coly and coll then
  col=true 
 else col = false end
 ctrl=char.id-1
	--check for btn then move
	if btn(0, ctrl) 
 and col==false then 
  char.dx = -0.5 end
 if btn(1, ctrl) then   
 	char.dx = 0.5 end
 if btn(2, ctrl) then
  char.dy = -0.25 end
 if btn(3, ctrl) then
 	char.dy = 0.25 end
 char.x+=char.dx
 char.y+=char.dy
end

function atk1(p)
	print('punching',24,24,8)
	ctrl=p.id-1
	--check for btn then atk1
	if btn(5, ctrl) then
		p.sprnum=p.atk1spr
	else p.sprnum=p.idlespr end
end
__gfx__
44444444444444440000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
22222222222222220000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ffff5f5fffff5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55577777555777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ff577777ff5777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
fff77777fff777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
fff77777fff777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
fff22222fff222220000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
fff72227fff722270000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77727727777277270000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77727772777277720000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777777777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
aaaaaaaa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
aaaaaaaa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ffff5f5f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55588888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ff588888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
fff88888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
fff88888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
fff55555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
fff85558000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
88858858000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
88858885000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
88888888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000444444440000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000222222220000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000ffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000ffff5f5f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000ffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000222222220000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000555777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000ff5777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000fff777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000fff777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000fff222220000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000fff722270000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000777277270000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000777277720000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000ffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000444444440000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000222222220000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000ffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000f5f5ffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000ffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000222222220000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000777775550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000777775ff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000077777fff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000077777fff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000022222fff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000072227fff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000727727770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000277727770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000ffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000066000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000006666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000666666666600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000066666666666666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000006666666666666666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000666666666666666666666600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00066666666666666666666666666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06666666666666666666666666666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66666666666666666666666666666666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
56666666666666666666666666666665000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55566666666666666666666666666555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55555666666666666666666666655555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55555556666666666666666665555555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05555555566666666666666555555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00055555555666666666655555555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000555555556666665555555500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000005555555566555555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000055555555555555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000555555555500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000005555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000055000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000001010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000001010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
