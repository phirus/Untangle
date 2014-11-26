require("Box")
require("Basic")

function createLine(head, tail)
	local Line = {}
	Line.head = head or createBox(280,230)
	Line.tail = tail or createBox(320,400)
	Line.hit = false

	return Line
end

function getLinearEquation(Line)
	local x1, x2, y1, y2 = Line.head.x, Line.tail.x, Line.head.y, Line.tail.y

	local m = (y2-y1)/(x2-x1)
	local n = y1 - (m*x1)

	return m,n
end

function getIntersection(Line_1,Line_2)
	local m1,n1 = getLinearEquation(Line_1)
	local m2,n2 = getLinearEquation(Line_2)

	local x_inter = (n2-n1)/(m1-m2)

	return x_inter
end

function isSharedPoint(Line_1,Line_2)
	local shared = false
	if(Line_1.head == Line_2.head or Line_1.head == Line_2.tail or Line_1.tail == Line_2.head or Line_1.tail == Line_2.tail) then
		shared = true
	end
	return shared
end


function doLinesIntersect(Line_1,Line_2)
	local x_inter = getIntersection(Line_1,Line_2)

    return ( isBetween(x_inter,Line_1.head.x,Line_1.tail.x) and isBetween(x_inter,Line_2.head.x,Line_2.tail.x) and (not isSharedPoint(Line_1,Line_2)))	
end

function isLineListIntersection(lines)
	for i = 1, #lines do
		local tmp = lines[i]
		tmp.hit = false

		for j = 1, #lines do
			if (i ~= j and doLinesIntersect(tmp,lines[j])) then
				tmp.hit = true
			end
		end
	end
end
