--
-- Author: Your Name
-- Date: 2014-12-12 11:44:55
--
--选择界面
local GameScene = require("app.scenes.GameScene")
local ShopScene = require("app.scenes.ShopScene")
local SelectScene=class("SelectScene", function ()
	return display.newScene("SelectScene")
end)

function SelectScene:ctor()
	-- 背景
	print("SelectScene")
	self._bg=self:createBG()
	self:addChild(self._bg)

	--开始按钮
	local beginItem=ui.newTTFLabelMenuItem({
		text="开始",
		x=160,
		y=320,
		listener=self.toGameScene,
		})
	ui.newMenu({beginItem}):addTo(self)

	--购买道具按钮
	local buyItem=ui.newTTFLabelMenuItem({
		text="购买道具",
		x=160,y=240,
		listener=self.toShopScene
		})
	ui.newMenu({buyItem}):addTo(self)
end

--添加背景函数
function SelectScene:createBG()
	local bg=display.newSprite("bg_about-hd.png")
	bg:setPosition(0,0)
	bg:setAnchorPoint(0,0)
	return bg
end

--进入游戏主场景
function SelectScene:toGameScene()
	print("go to GameScene")
	CCDirector:sharedDirector():replaceScene(GameScene.new())
end

--进入商店场景
function SelectScene:toShopScene()
	print("go to ShopScene")
	CCDirector:sharedDirector():replaceScene(ShopScene.new())
end

function SelectScene:onEnter()
	-- body
end
function  SelectScene:onExit()
	-- body
end
return SelectScene