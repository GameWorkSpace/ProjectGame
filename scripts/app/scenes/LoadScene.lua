--
-- Author: Your Name
-- Date: 2014-12-11 20:09:32
--
local MainScene = require("app.scenes.MainScene")

--资源加载场景

 local LoadScene = class("LoadScene", function()
 	return display.newScene("LoadScene")
 end)

function LoadScene:loaded(  )
	maxvalue=maxvalue+1
	value=maxvalue/60*100
	per=string.format("%d%%",value)
	laber:setString(per)
	time:setPercentage(value)
	if maxvalue==60 then
		display.replaceScene(MainScene.new())
	end
end

function LoadScene:ctor()
	
	value=0
	maxvalue=0
	--定义一个进度条
	sp1=CCSprite:create("progressbar.png")
	time=CCProgressTimer:create(sp1)
	time:setType(kCCProgressTimerTypeBar)
	time:setBarChangeRate(ccp(1, 0))
	time:setMidpoint(ccp(0,0.5))
	time:setScale(0.5)
	time:setPosition(display.cx,display.cy-50)
	time:setPercentage(20)
	self:addChild(time)
	--显示百分比
	laber=CCLabelTTF:create("0%", "", 30)
	laber:setPosition(display.cx,display.cy)
	laber:setColor(ccc3(255, 0, 0))
	self:addChild(laber)
	for i=1,60 do
		CCTextureCache:sharedTextureCache():addImageAsync("1.png",function()
			self:loaded()
		end)
	end

end



function LoadScene:onEnter()
	
end

function LoadScene:onExit()
	
end


 return LoadScene