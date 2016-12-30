function score_increase(dt) 
	-- Score increases everytime a successful jump
	if postX < 0 then
		score = score + 1
		scoreSound:play()
	end
end

function post_state(dt)
	-- Make player die if they hit the post
	if check_collision() == true then
		loseSound:play()
		state = 'lose'
	end
	if score == 3 then
		state = 'win'
	end
end

-- function game_state(dt)
-- 	if state ~= 'play' then
-- 		return 
-- 	end
-- end

function end_game_state()
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