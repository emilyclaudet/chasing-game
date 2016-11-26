require 'player'

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
		else
			postX = postX - postVelocity * dt	
		end
	end
end

function draw_post()
	love.graphics.setColor(255, 0, 0)
	love.graphics.rectangle('fill', postX, postY, postWidth, postHeight)
end

-- Returns true if player overlaps with post
function check_collision(x1,y1,w1,h1,x2,y2,w2,h2)
	x1 = playerX - 2
	y1 = playerY - 2
	w1 = 28
	h1 = 28
	x2 = postX
	y2 = postY
	w2 = postWidth
	h2 = postHeight
	return x1 < x2 + w2 and
           x2 < x1 + w1 and
           y1 < y2 + h2 and
           y2 < y1 + h1
end