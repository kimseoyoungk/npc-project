-----------------------------------------------------------------------------------------
--
-- View01_bear.lua
--
-----------------------------------------------------------------------------------------
local loadsave = require( "loadsave" )
local composer = require( "composer" )
local physics = require("physics")
local scene = composer.newScene()
local json = require( "json" ) 


function scene:create( event )
	local sceneGroup = self.view
	
	local background = display.newImageRect("Content/PNG/stage/스테이지1.png", display.contentWidth, display.contentHeight)
	background.x, background.y=display.contentWidth/2, display.contentHeight/2

	local cat = display.newImage("Content/PNG/stage/스테이지1고양이.png")
	cat.x, cat.y = 630, 1150

	local arrowright = display.newImage("Content/PNG/stage/오른쪽넘기기.png")
	arrowright.x, arrowright.y = display.contentWidth*0.9, display.contentHeight/2

	local function storymove()
		composer.gotoScene("story01")
	end

	local function nextmove()
		composer.removeScene("stage01")
		composer.gotoScene("stage02")
	end

	cat:addEventListener("tap", storymove)
	arrowright:addEventListener("tap", nextmove)

	sceneGroup:insert(background)
	sceneGroup:insert(cat)
	sceneGroup:insert(arrowright)


	-- 엔딩 제이쓴 파일 생성
    local path = system.pathForFile( "ending.json", system.DocumentsDirectory)
 
    local file, errorString = io.open( path, "r" )
    if not file then
        print("make an ending file")
        --엔딩관련 데이터 파일 생성
        local ending = {
            bgMusic = "Content/PNG/script/지도.mp3",
            logValue = "0.5",
            slider = 50
        }
        loadsave.saveTable( ending, "ending.json" )
    end



	loadedEnding = loadsave.loadTable( "ending.json" )


	-- showoverlay 함수 사용 option
    local options = {
        isModal = true
    }
    
	--샘플 볼륨 이미지
    local volumeButton = display.newImage("Content/PNG/설정/설정.png")
    volumeButton.x,volumeButton.y = display.contentWidth * 0.87, display.contentHeight * 0.9
    sceneGroup:insert(volumeButton)

    --샘플볼륨함수--
    local function setVolume(event)
        composer.showOverlay( "volumeControl", options )
    end
    volumeButton:addEventListener("tap",setVolume)

    --[[local home = audio.loadStream( "음악/음악샘플.mp3" )
    audio.setVolume( loadedEnding.logValue )--loadedEndings.logValue
    audio.play(home)
]]



 

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
		composer.removeScene("stage01")
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