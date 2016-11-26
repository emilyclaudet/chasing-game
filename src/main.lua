require 'post'
require 'player'

platform = {}

function love.load()
	state = 'play'
	jumpSound = love.audio.newSource('res/jumpSound.wav', 'static' )
	loseSound = love.audio.newSource('res/loseSound.wav', 'static' )
	scoreSound = love.audio.newSource('res/scoreIncrease.wav', 'static' )
	platform.width = love.graphics.getWidth()
	platform.height = love.graphics.getHeight() 
	platform.x = 0                              
	platform.y = platform.height / 1.34
	score = 0

	load_player()
	load_post()
end

function love.update(dt)
	if state ~= 'play' then
		return 
	end

	update_player(dt)
    check_player_on_ground(dt)
	regenerate_post(dt)
	limit_player(dt)

	-- Score increases everytime a successful jump
	if postX < 0 then
		score = score + 1
		scoreSound:play()
	end
	
	-- Make player die if they hit the post
	if check_collision() == true then
		loseSound:play()
		state = 'lose'
	end

	if score == 3 then
		state = 'win'
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
	draw_player()
	-- Ground
	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle('fill', platform.x, platform.y, platform.width, platform.height)
	-- Posts
	draw_post()
	-- Score
	love.graphics.print(score, 10, 20, 0, 1, 1)

	if state == 'lose' then
		draw_lose_screen()
	end
	if state == 'win' then
		draw_win_screen()
	end
end

function draw_lose_screen()
	love.graphics.setColor(0, 0, 0)
	love.graphics.print("You died", 10, 10, 0, 1, 1)
end

function draw_win_screen()
	love.graphics.setColor(0, 0, 0)
	love.graphics.print("YOU WIN", 100, 100, 0, 2, 2)
end


function love.quit()
    print('Quitting Chasing Game...')
end
