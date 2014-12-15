
local SelectScene=require("app.scenes.SelectScene")
local SetScene = require("app.scenes.SetScene")
--开始场景
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
   	
   	--背景图片
   	display.newSprite("startbg.png", 240, 160):addTo(self, -1, 0)

   	--[[ 
   	--开始按钮
    local beginItem = ui.newImageMenuItem({
    	image = "start.png",
    	imageSelected = "start.png",
    	listener = function()
    		self:startGame()
    	end
    	})

    --新游戏按钮
    local newGameItem = ui.newImageMenuItem({
    	image = "100points.png",
    	imageSelected = "100points.png",
    	listener = function()
    		self:newGame()
    	end
    	})

   	ui.newMenu({beginItem,newGameItem})
    self._menu:setPosition(ccp(240, 160))
    self:addChild(self._menu)
	
	--]]

	--开始游戏菜单按钮
	local beginItem = ui.newTTFLabelMenuItem({
		text = "新游戏",
		font = "Arial",
		size = 35,
		color = ccc3(200, 120, 150),
		textAlign = kCCVerticalTextAlignmentCenter,
		listener = function ()
			self:startGame()
		end
		})

	self._menu = ui.newMenu({beginItem})
 	self._menu:setPosition(ccp(display.cx, 300))
 	self:addChild(self._menu)

 	--新游戏菜单按钮
 	local newGameItem = ui.newTTFLabelMenuItem({
		text = "设置",
		font = "Arial",
		size = 35,
		color = ccc3(200, 120, 150),
		textAlign = kCCVerticalTextAlignmentCenter,
		listener = function ()
			self:goSetScene()
		end
		})
 	ui.newMenu({newGameItem}):addTo(self, 1, 0):setPosition(ccp(display.cx, 250))

 	--退出按钮
 	local exitGameItem = ui.newTTFLabelMenuItem({
		text = "退出游戏",
		font = "Arial",
		size = 35,
		color = ccc3(200, 120, 150),
		textAlign = kCCVerticalTextAlignmentCenter,
		listener = function ()
			self:exitGame()
		end
		})
 	ui.newMenu({exitGameItem}):addTo(self, 1, 0):setPosition(ccp(display.cx, 200))

--[[ 
 	--local sy = CCParticleSystemQuad:create("yanhua.plist")
 	local sy = CCParticleExplosion:create()
 	--sy:setTextureWithRect(CCTextureCache:sharedTextureCache():addImage("fire.png"), CCRectMake(0, 0, 32, 32))
 	sy:setBlendAdditive(true)
 	sy:setPosition(ccp(160, 320))
 	sy:setDuration(-1)
 	sy:setAutoRemoveOnFinish(true)
 	sy:setSpeed(57)
 	self:addChild(sy)
--]]


end

function MainScene:startGame()
	print("StartGame")

	display.replaceScene(SelectScene.new(), "fade", 1.0,
		ccc3(0, 0, 0))
end

function MainScene:goSetScene()
	display.replaceScene(SetScene.new(), "fade", 1.0,
		ccc3(0, 0, 0))
	print("newGame")
end

function MainScene:exitGame(  )
	print("exitGame")
	os.exit()
end


function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
