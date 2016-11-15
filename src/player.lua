player = {}

function load_player()
	playerX = 32
	playerY = 416
	playerSpeed = 200
	player = love.graphics.newImage("res/player.png")
	playerSprite = love.graphics.newQuad(0, 32, 32, 32, player:getDimensions())
	playerGround = playerY     -- This makes the character land on the plaform.
	playerYVelocity = 0
	playerJumpHeight = -350
	playerGravity = -1000
end

function update_player(dt)
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
end

function check_player_on_ground(dt)
    if playerY > playerGround then    -- Check if player jumps
		playerYVelocity = 0
    	playerY = playerGround 
	end
end

function limit_player(dt)
	if playerX < 0 then
		playerX = 0
	end

	if playerX > love.graphics.getWidth() / 2 - 32 then
		playerX = love.graphics.getWidth() / 2 - 32
	end
end

function draw_player()
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(player, playerSprite, playerX, playerY)
end