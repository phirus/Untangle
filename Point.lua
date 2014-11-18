function isInBox(x,y,box)
	return (x >= box.x -box.w/2 and x <= (box.x + box.w/2) and  y >= box.y -box.w/2 and y <= (box.y + box.w/2) )
end

function getCorners(box)
	local nw = {}
	local ne = {}
	local sw = {}
	local se = {}
	nw.x , nw.y = box.x - box.w/2 , box.y - box.w/2
	ne.x , ne.y = box.x + box.w/2 , box.y - box.w/2
	sw.x , sw.y = box.x - box.w/2 , box.y + box.w/2
	se.x , se.y = box.x + box.w/2 , box.y + box.w/2

	return nw , ne , sw , se
end

function isBoxInBox(box_1, box_2)
	local nw , ne , sw , se = getCorners(box_1)

	return( isInBox(nw.x,nw.y,box_2) or isInBox(ne.x,ne.y,box_2) or isInBox(sw.x,sw.y,box_2) or isInBox(se.x,se.y,box_2))
end