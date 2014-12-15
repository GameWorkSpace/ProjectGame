--
-- Author: Your Name
-- Date: 2014-12-11 13:43:12
--

--local SelectScene = require("app.scenes.SelectScene")
--商店场景
local ShopScene = class("ShopScene", function (  )
	return display.newScene("ShopScene")
end)

function ShopScene:ctor()
	display.newSprite("bj3.png", display.cx, display.cy):addTo(self, -1, 0)

	local beginItem = ui.newTTFLabelMenuItem({
		text = "返回",
		font = "Arial",
		size = 35,
		color = ccc3(200, 120, 150),
		textAlign = kCCVerticalTextAlignmentCenter,
		listener = function ()
			self:startGame()
		end
		})
	ui.newMenu({beginItem}):addTo(self):setPosition(ccp(display.cx, display.cy))

end

function ShopScene:startGame()
	print("StartGame")

	display.replaceScene(require("app.scenes.SelectScene").new(), "fade", 1.0,
		ccc3(0, 0, 0))
end

function ShopScene:onEnter()
	
end

function ShopScene:onExit()
	
end


return ShopScene