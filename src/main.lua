platform = {}
player = {}

function love.load()
	playerX = 32
	playerY = 416
	playerSpeed = 200
	player = love.graphics.newImage("res/player.png")
	playerSprite = love.graphics.newQuad(0, 32, 32, 32, player:getDimensions())

	platform.width = love.graphics.getWidth()
	platform.height = love.graphics.getHeight() 
	platform.x = 0                              
	platform.y = platform.height / 1.32

	playerGround = playerY     -- This makes the character land on the plaform.
	playerYVelocity = 0
	playerJumpHeight = -350
	playerGravity = -1000
end

function love.update(dt)
	if love.keyboard.isDown('left') then
		playerX = playerX - (playerSpeed * dt)
	end

	if love.keyboard.isDown('right') then
		playerX = playerX + (playerSpeed * dt)
	end

	if love.keyboard.isDown('space') then
		if  playerYVelocity == 0 then					-- Check player is on the ground
			playerYVelocity = playerJumpHeight		-- The player's Y-Axis Velocity is set to it's Jump Height.
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

	if playerX < 0 then
		playerX = 0
	end

	if playerX > platform.width / 2 - 32 then
		playerX = platform.width / 2 - 32
	end
end

function love.keyreleased(key)
    if key == "escape" then
		love.event.quit()
	end
end

function love.draw()
	love.graphics.draw(player, playerSprite, playerX, playerY)
	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle('fill', platform.x, platform.y, platform.width, platform.height)
end

function love.quit()
    print('Quitting Chasing Game...')
end

