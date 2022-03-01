-----------------------------------------------------------------------------------------
--
-- view04_dog.lua 레벨2
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local explosionSound = audio.loadSound( "Content/PNG/script/City Key.mp3" )
	audio.play( explosionSound )

	local background = display.newImage( "Content/PNG/dog/배경.png")
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local dog = display.newImage( "Content/PNG/dog/강아지.png")
	dog.x, dog.y = display.contentWidth/2, display.contentHeight*0.8

	local starNum = 17;
	local star = {}
	local starGroup = display.newGroup()

	for i = 1,starNum do
		local num = math.random(1, 2);
		star[i] = display.newImage(starGroup, "Content/PNG/dog/별"..num..".png")
		star[i].x = background.x + math.random(-500, 500)
		star[i].y = background.y + math.random(-900, 700)
	end

	--스코어 출력 --
	local score = 0
	local showScore = display.newText("소원 개수: "..score, display.contentWidth*0.8, display.contentHeight*0.1)
	showScore:setFillColor(1)
	showScore.size = 70

	local function catch(event)
		display.remove(event.target)

		score = score + 1
		showScore.text = "소원 개수: "..score;
		if score == starNum then
			timer.cancel( timer1 )
			audio.pause( explosionSound )
			composer.setVariable("complete", 1)
			composer.gotoScene("view05_dog_end") 
		end
	end

	for i =1,starNum do
		star[i]:addEventListener("tap", catch)
	end
	--시간 제한--
	local limit = 25

	local showLimit = display.newText(limit, display.contentWidth*0.9, display.contentHeight*0.5)
	showLimit:setFillColor(1)
	showLimit.size = 80
	--[[sceneGroup:insert(showLimit)--]]
	local count = 0

	local function timeAttack(event)
		limit = limit - 1
		showLimit.text = limit
		print(limit)
		if(limit <= 0) then
			timer.cancel( timer1 )
			composer.removeScene("view02_dog")
			composer.gotoScene("view03_dog_fail")
		end
	end

	timer1=timer.performWithDelay(1000, timeAttack, 0)

	
	sceneGroup:insert(background)
	sceneGroup:insert(showScore)
	sceneGroup:insert(dog)
	sceneGroup:insert(starGroup)
	sceneGroup:insert(showLimit)
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene