--
-- Author: Your Name
-- Date: 2014-12-11 13:48:35
--
--子弹类
require("app.scenes.MyData")

local  Bullte = class("Bullte", function ()
	return display.newNode()
end)

function Bullte:ctor(prames)
	self._addBullte =  prames.addBullte 
	self._sp = display.newSprite("yellowbird1.png")
	self._sp:setScale(0.8)
	self:addChild(self._sp)
	self._demage = 10 --伤害
	self._speed = 230 --速度

	self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(eventType)
		if eventType.name == "began" then
			return true
		elseif eventType.name == "moved" then
			print("move")
		else
			print("TouchEnd:",eventType.x,eventType.y)
			self:setTouchEnabled(false)
			--判断是否点击在子弹上
			if self._sp:boundingBox():containsPoint(self:convertToNodeSpace(ccp(eventType.x,eventType.y))) then
				self:shootBullte(ccp(self:getPositionX(), self:getPositionY()))
			else
				self:shootBullte(ccp(eventType.x, eventType.y))

			end

		end
	end)

end

--发射子弹,p为坐标
function Bullte:shootBullte( p )
	local  distance = math.sqrt(display.cx*display.cx + (display.height-50)*(display.height-50))
	local x = self:getPositionX()
	local y = self:getPositionY()
 	local disX
 	local disY
 	
 	if p.y < 55 then
 		disX = x 
		disY = y + distance
	elseif p.x < x then      --p点在屏幕左边，
		local angle = math.atan((p.y - 50)/(x - p.x))
		disX = x - distance*math.cos(angle)
		disY = y + distance*math.sin(angle)
		print("distancePoint:",disX,disY)
	elseif p.x > x then  --p点在屏幕右边，
		local angle = math.atan((p.y - 50)/(p.x - x))	
		disX = x + distance*math.cos(angle)
		disY = y + distance*math.sin(angle)
		print("distancePoint:",disX,disY)
	else
		disX = x 
		disY = y + distance
	end

	local seq = transition.sequence({
		CCMoveTo:create(distance/self._speed, ccp(disX,disY)),
		CCCallFunc:create(function ()
			self:removeFromParent()
			MyData.removeFormBulltes(self)
		end)
		})
			
	self:runAction(seq)
	self._addBullte()

	--将子弹添加到bulltes
	MyData.addBulltes(self)

	print("当前屏幕子弹数",#MyData.getBulltes())

end



return Bullte