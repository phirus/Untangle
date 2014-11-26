function createBox(x,y,w)
	local Point = {}
	Point.x = x or 50
	Point.y = y or 50
	Point.w = w or 50
	Point.hit = false
	Point.ox = 0
	Point.oy = 0

	return Point
end

function isInBox(x,y,Box)
	return (x >= Box.x -Box.w/2 and x <= (Box.x + Box.w/2) and  y >= Box.y -Box.w/2 and y <= (Box.y + Box.w/2) )
end

function getCorners(Box)
	local nw = {}
	local ne = {}
	local sw = {}
	local se = {}
	nw.x , nw.y = Box.x - Box.w/2 , Box.y - Box.w/2
	ne.x , ne.y = Box.x + Box.w/2 , Box.y - Box.w/2
	sw.x , sw.y = Box.x - Box.w/2 , Box.y + Box.w/2
	se.x , se.y = Box.x + Box.w/2 , Box.y + Box.w/2

	return nw , ne , sw , se
end

function isBoxInBox(Box_1, Box_2)
	local nw , ne , sw , se = getCorners(Box_1)

	return( isInBox(nw.x,nw.y,Box_2) or isInBox(ne.x,ne.y,Box_2) or isInBox(sw.x,sw.y,Box_2) or isInBox(se.x,se.y,Box_2))
end
