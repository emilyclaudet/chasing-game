platform = {}
player = {}
posts = {}

function love.load()
	state = 'play'
	jumpSound = love.audio.newSource('res/jumpSound.wav', 'static' )
	loseSound = love.audio.newSource('res/loseSound.wav', 'static' )
	playerX = 32
	playerY = 416
	playerSpeed = 200
	player = love.graphics.newImage("res/player.png")
	playerSprite = love.graphics.newQuad(0, 32, 32, 32, player:getDimensions())

	platform.width = love.graphics.getWidth()
	platform.height = love.graphics.getHeight() 
	platform.x = 0                              
	platform.y = platform.height / 1.34

	playerGround = playerY     -- This makes the character land on the plaform.
	playerYVelocity = 0
	playerJumpHeight = -350
	playerGravity = -1000

	gap = 200
	postWidth = 28
	postHeight = 48
	postVelocity = 200
	postX = love.graphics.getWidth()
	postY = 416 - postHeight/2

	postWidth2 = 28
	postHeight2 = 48
	postVelocity2 = 200
	postX2 = love.graphics.getWidth() + gap
	postY2 = 416 - postHeight/2

end

function love.update(dt)
	if state ~= 'play' then
		return 
	end

	if love.keyboard.isDown('left') then
		playerX = playerX - (playerSpeed * dt)
	end

	if love.keyboard.isDown('right') then
		playerX = playerX + (playerSpeed * dt)
	end

	if love.keyboard.isDown('space') then
		if  playerYVelocity == 0 then					-- Check player is on the ground
			playerYVelocity = playerJumpHeight		-- The player's Y-Axis Velocity is set to it's Jump Height.
			jumpSound:play()
		end
	end

    if playerYVelocity ~= 0 then                                      -- The game checks if player has "jumped" and left the ground.
		playerY = playerY + playerYVelocity * dt                -- This makes the character ascend/jump.
		playerYVelocity = playerYVelocity - playerGravity * dt -- This applies the gravity to the character.
	end
 
    -- This is in charge of collision, making sure that the character lands on the ground.
    if playerY > playerGround then    -- Check if player jumps
		playerYVelocity = 0
    	playerY = playerGround 
	end

	-- Controls player's range to not walk off edge of screen
	if playerX < 0 then
		playerX = 0
	end
	if playerX > love.graphics.getWidth() / 2 - 32 then
		playerX = love.graphics.getWidth() / 2 - 32
	end
	
	elapsedTime = 0 
	elapsedTime = elapsedTime + dt

	if elapsedTime > 0 then
		if postX < 0 then
			postX = love.graphics.getWidth()
		else
			postX = postX - postVelocity * dt	
		end
	end

	if elapsedTime > 0 then
		if postX2 < 0 then
			postX2 = love.graphics.getWidth()
		else
			postX2 = postX2 - postVelocity2 * dt	
		end
	end

	-- Make player die if they hit the post
	if check_collision_post1() == true or check_collision_post2() == true then
		loseSound:play()
		state = 'lose'
	end
end

function love.keyreleased(key)
    if key == "escape" then
		love.event.quit()
	end
end

function love.draw()
	--Background
	love.graphics.setColor(0, 255, 255)
	love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
	-- Player
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(player, playerSprite, playerX, playerY)
	-- Ground
	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle('fill', platform.x, platform.y, platform.width, platform.height)
	-- Post 1
	love.graphics.setColor(255, 0, 0)
	love.graphics.rectangle('fill', postX, postY, postWidth, postHeight)
	-- Post 2
	love.graphics.setColor(255, 0, 0)
	love.graphics.rectangle('fill', postX2, postY2, postWidth2, postHeight2)

	if state == 'lose' then
		draw_lose_screen()
	end
end

function draw_lose_screen()
	love.graphics.setColor(0, 0, 0)
	love.graphics.print("You died", 10, 10, 0, 1, 1)
end

-- Returns true if player overlaps with post 1
function check_collision_post1(x1,y1,w1,h1,x2,y2,w2,h2)
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

-- Returns true if player overlaps with post 2
function check_collision_post2(x1,y1,w1,h1,x2,y2,w2,h2)
	x1 = playerX - 2
	y1 = playerY - 2
	w1 = 28
	h1 = 28
	x2 = postX2
	y2 = postY2
	w2 = postWidth2
	h2 = postHeight2
	return x1 < x2 + w2 and
           x2 < x1 + w1 and
           y1 < y2 + h2 and
           y2 < y1 + h1
end

function love.quit()
    print('Quitting Chasing Game...')
end
