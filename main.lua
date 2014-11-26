require ("Line") 
function love.load()
	love.graphics.setCaption("Untangle")

	points = {}
	points[1] = createBox(280,230)
	points[2] = createBox(320,400)
	points[3] = createBox(200,400)
	points[4] = createBox(320,150)
	points[5] = createBox(400,280)

	lines = createClosed(points)	
end

function love.mousepressed(xm, ym, button)
	-- Checks which button was pressed.

	if button == "l" then
		for i = 1, #points do
			local tmp = points[i]
			if (isInBox(xm,ym,tmp)) then
				tmp.hit = true
			end
			tmp.ox = tmp.x - xm
			tmp.oy = tmp.y -ym
		end
	end
end

function love.mousereleased(xm, ym, button)
	if (button == "l" ) then
		for i = 1, #points do
			local tmp = points[i]
			tmp.hit = false
		end
	end
end

function love.update(dt)

	for i = 1, #points do
		local tmp = points[i]
		if (tmp.hit == true) then
			local tempx = tmp.x
			local tempy = tmp.y 

			tmp.x = tmp.ox + love.mouse.getX()
			tmp.y = tmp.oy + love.mouse.getY()

			for j = 1, #points do
				if(i ~= j and isBoxInBox(points[i],points[j])) then
					tmp.x = tempx
					tmp.y = tempy
				end
			end
		end
	end
	isLineListIntersection(lines)
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
	if(line.hit == true) then
		love.graphics.setColor(255,0,0,255)
	end
	love.graphics.setLineWidth( 5 )
	love.graphics.line(line.head.x,line.head.y,line.tail.x,line.tail.y)
end

function love.draw()
    love.graphics.setColor(255, 255, 255, 255)

	love.graphics.circle("fill", 400, 320, 200, 50 )

	for i = 1, #lines do
		drawLine(lines[i])
	end
	
	for i = 1, #points do
		drawPoint(points[i])
	end
	
	local m,n = getLinearEquation(lines[1])
	local x = getIntersection(lines[1],lines[2])

	local text= "m = " .. m ..", n = " .. n .. ", x = " .. x

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print(text,100,100)
end