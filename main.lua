require ("Line") 
require("camera")

function love.load()
	love.graphics.setCaption("Untangle")
	local display_width = love.graphics.getWidth()
	local display_height = love.graphics.getHeight()
	camera = createCamera(x, y)

	points = {}
	for i = 1, 10 do
		points[i] = placeBox(display_width,display_height)
	end

	lines = createClosed(points)	
end

function love.mousepressed(xm, ym, button)
	xm = xm - camera.x
	ym = ym - camera.y

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
	xm = xm - camera.x
	ym = ym - camera.y

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

			tmp.x = tmp.ox + love.mouse.getX() - camera.x
			tmp.y = tmp.oy + love.mouse.getY() - camera.y

			for j = 1, #points do
				if(i ~= j and isBoxInBox(points[i],points[j])) then
					tmp.x = tempx
					tmp.y = tempy
				end
			end
		end
	end
	isLineListIntersection(lines)

	if (love.keyboard.isDown( "up" )) then camera.y = camera.y + camera.speed end
	if (love.keyboard.isDown( "down" )) then camera.y = camera.y - camera.speed end
	if (love.keyboard.isDown( "left" )) then camera.x = camera.x + camera.speed end
	if (love.keyboard.isDown( "right" )) then camera.x = camera.x - camera.speed end 
end

function drawPoint(point)
	love.graphics.setColor(0, 0, 0, 255)
	love.graphics.rectangle("fill",point.x-point.w/2 + camera.x,point.y-point.w/2 +camera.y,point.w,point.w)
	if(point.hit == true) then
		love.graphics.setColor(0, 0, 255, 255)
	else
		love.graphics.setColor(0, 255, 0, 255)
	end
	
	love.graphics.rectangle("line",(point.x-point.w/2)+camera.x,(point.y-point.w/2)+camera.y,point.w,point.w)

end

function drawLine(line)
	love.graphics.setColor(0, 255, 0, 255)
	if(line.hit == true) then
		love.graphics.setColor(255,0,0,255)
	end
	love.graphics.setLineWidth( 5 )
	love.graphics.line(line.head.x + camera.x, line.head.y + camera.y,line.tail.x + camera.x,line.tail.y + camera.y)
end

function love.draw()
    love.graphics.setColor(255, 255, 255, 255)

	love.graphics.circle("fill", 400+camera.x, 320+camera.y, 200, 50 )

	for i = 1, #lines do
		drawLine(lines[i])
	end
	
	for i = 1, #points do
		drawPoint(points[i])
	end
	
	local m,n = getLinearEquation(lines[1])
	local x = getIntersection(lines[1],lines[2])

	local display_width = love.graphics.getWidth()
	local display_height = love.graphics.getHeight()

	local text= "m = " .. m ..", n = " .. n .. ", x = " .. x .. "\nDisplay: x = " .. display_width .. " y = " .. display_height

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print(text,100,100)
end