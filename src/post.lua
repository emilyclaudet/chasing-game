posts = {}

function load_post()
	postWidth = 28
	postHeight = 48
	postVelocity = 200
	postX = love.graphics.getWidth()
	postY = 416 - postHeight/2
end

function regenerate_post(dt)
	elapsedTime = 0 
	elapsedTime = elapsedTime + dt

	if elapsedTime > 0 then
		if postX < 0 then
			postX = love.graphics.getWidth()
			postY = math.random( 416 - 48 , 416 - 10)
			postHeight = math.random(20, 48)
		else
			postX = postX - postVelocity * dt	
		end
	end
end

function draw_post()
	love.graphics.setColor(255, 0, 0)
	love.graphics.rectangle('fill', postX, postY, postWidth, postHeight)
end