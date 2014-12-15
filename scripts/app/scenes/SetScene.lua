--
-- Author: Your Name
-- Date: 2014-12-12 17:19:20
--
local SetScene = class("SetScene", function()
	return display.newScene("SetScene")
end)

function SetScene:ctor( )
	display.newSprite("bg_pause.png", display.cx, display.cy):addTo(self, -1, 0)
	--返回到主菜单场景
	local beginItem=ui.newTTFLabelMenuItem({
		text="返回到主菜单场景",
		x=160,
		y=320,
		listener=function ( )
			display.replaceScene(require("app.scenes.MainScene").new())
		end,
		})
	ui.newMenu({beginItem}):addTo(self)
end

function SetScene:onEnter()
	-- body
end

function SetScene:onExit()
	-- body
end




return SetScene