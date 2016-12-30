require 'post'
require 'player'
require 'gamestate'

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
	score_increase(dt)
	post_state(dt)
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
	-- Draw things when you lose or win
	end_game_state()
end

function love.quit()
    print('Quitting Chasing Game...')
end
