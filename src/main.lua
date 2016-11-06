platform = {}
player = {}

function love.load()
	playerX = 32
	playerY = 416
	X = 0
	playerSpeed = 150
	player = love.graphics.newImage("res/player.png")
	playerSprite = love.graphics.newQuad(0, 32, 32, 32, player:getDimensions())

    -- This is the height and the width of the platform.
	platform.width = love.graphics.getWidth()    -- This makes the platform as wide as the whole game window.
	platform.height = love.graphics.getHeight()  -- This makes the platform as tall as the whole game window.
	platform.x = 0                               -- This starts drawing the platform at the left edge of the game window.
	platform.y = platform.height / 1.32            -- This starts drawing the platform at the very middle of the game window

	playerGround = playerY     -- This makes the character land on the plaform.
	playerYVelocity = 0        -- Whenever the character hasn't jumped yet, the Y-Axis velocity is always at 0.
	playerJumpHeight = -300    -- Whenever the character jumps, he can reach this height.
	playerGravity = -500        -- Whenever the character falls, he will descend at this rate.
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
    if playerY > playerGround then    -- The game checks if the player has jumped.
		playerYVelocity = 0       -- The Y-Axis Velocity is set back to 0 meaning the character is on the ground again.
    		playerY = playerGround    -- The Y-Axis Velocity is set back to 0 meaning the character is on the ground again.
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

