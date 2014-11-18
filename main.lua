require("Point.lua")
function love.load()
	love.graphics.setCaption("drag n drop")

	p1 = {}
	p2 = {}

	p1.x = 280
	p1.y = 230
	p1.w = 50
	p1.hit = false
	p1.ox = 0
	p1.oy = 0

	p2.x = 320
	p2.y = 400
	p2.w = 50
	p2.hit = false

	x_m = 500
	y_m = 200

	hit = false

	line1 = {}
	line1.head = p1
	line1.tail = p2
	line1.hit = false

end

-- function isInBox(x,y,box)
-- 	return (x >= box.x -box.w/2 and x <= (box.x + box.w/2) and  y >= box.y -box.w/2 and y <= (box.y + box.w/2) )
-- end

-- function getCorners(box)
-- 	local nw = {}
-- 	local ne = {}
-- 	local sw = {}
-- 	local se = {}
-- 	nw.x , nw.y = box.x - box.w/2 , box.y - box.w/2
-- 	ne.x , ne.y = box.x + box.w/2 , box.y - box.w/2
-- 	sw.x , sw.y = box.x - box.w/2 , box.y + box.w/2
-- 	se.x , se.y = box.x + box.w/2 , box.y + box.w/2

-- 	return nw , ne , sw , se
-- end

-- function isBoxInBox(box_1, box_2)
-- 	local nw , ne , sw , se = getCorners(box_1)

-- 	return( isInBox(nw.x,nw.y,box_2) or isInBox(ne.x,ne.y,box_2) or isInBox(sw.x,sw.y,box_2) or isInBox(se.x,se.y,box_2))
-- end

function love.mousepressed(xm, ym, button)
	-- Checks which button was pressed.
	if button == "l" then
		if (isInBox(xm,ym,p1)) then
			p1.hit = true
		end
		p1.ox = p1.x - xm
		p1.oy = p1.y -ym
	end

	if button == "l" then
		if (isInBox(xm,ym,p2)) then
			p2.hit = true
		end
		p2.ox = p2.x - xm
		p2.oy = p2.y -ym
	end

end

function love.mousereleased(xm, ym, button)
	if (button == "l" ) then
		p1.hit = false
		p2.hit = false
	end
end

function love.update(dt)
	if (p1.hit == true) then
		local tempx = p1.x
		local tempy = p1.y 

		p1.x = p1.ox + love.mouse.getX()
		p1.y = p1.oy + love.mouse.getY()
		if(isBoxInBox(p1,p2)) then
			p1.x = tempx
			p1.y = tempy
		end
	end

	if (p2.hit == true) then
		local tempx = p2.x
		local tempy = p2.y 

		p2.x = p2.ox + love.mouse.getX()
		p2.y = p2.oy + love.mouse.getY()
		if(isBoxInBox(p2,p1)) then
			p2.x = tempx
			p2.y = tempy
		end
	end

end

function drawPoint(point)
	love.graphics.setColor(0, 0, 0, 255)
	love.graphics.rectangle("fill",point.x-point.w/2,point.y-point.w/2,point.w,point.w)
	if(point.hit == true) then
		love.graphics.setColor(0, 0, 255, 255)
	else
		love.graphics.setColor(0, 255, 0, 255)
	end
	
	love.graphics.rectangle("line",point.x-point.w/2,point.y-point.w/2,point.w,point.w)

end

function drawLine(line)
	love.graphics.setColor(0, 255, 0, 255)
	love.graphics.setLineWidth( 5 )
	love.graphics.line(line.head.x,line.head.y,line.tail.x,line.tail.y)
end

function love.draw()
    love.graphics.setColor(255, 255, 255, 255)

	love.graphics.circle("fill", 400, 320, 200, 50 )

	drawLine(line1)
	drawPoint(p1)
	drawPoint(p2)
end
