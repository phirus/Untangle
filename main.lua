require("Line.lua")
function love.load()
	love.graphics.setCaption("Untangle")

	p1 = createBox(280,230)
	p2 = createBox(320,400)

	line1 = createLine(p1,p2)

end

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

	local m,n = getLinearEquation(line1)
	local text= "m = " .. m ..", n = " .. n

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print(text,100,100)
end
