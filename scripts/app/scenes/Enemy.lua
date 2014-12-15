--
-- Author: Your Name
-- Date: 2014-12-12 14:32:18
--
--敌人类
require("app.scenes.MyData")

local Enemy = class("Enemy", function (  )
	return display.newNode()
end)

function Enemy:ctor(prames)

	self._enemyType = prames.enemyType
	local attribute = MyData.getEnemyAttribute(self._enemyType)
	self._sp = display.newSprite(MyData.getEnemyName(self._enemyType))
	self._sp:setScale(0.5)
	self._hp = attribute.hp
	self._demage = attribute.demage
	self._sp:addTo(self)

end

--敌人移动
function Enemy:move()
	if self._enemyType == 1 then
		--直线运动
		self:runAction(CCMoveBy:create(0.5, ccp(0, -20)))
	elseif self._enemyType == 2 then
		--左右+直线运动
		local x = self:getPositionX()
		local a = tostring(os.time()):reverse():sub(1, 6)
		local direction =  (math.random(a)%2>0) or false
		--print(math.random(a))
		if direction and  x+50 < display.width then
			print("222222")
			self:runAction(CCMoveBy:create(0.5,ccp(40, 0) ))
		elseif not direction and x-50 > 0  then
			print("1111111")
			self:runAction(CCMoveBy:create(0.5,ccp(-40, 0) ))
		end
	
		self:runAction(CCMoveBy:create(0.5, ccp(0, -25)))

	elseif self._enemyType == 2 then
		self:runAction(CCMoveBy:create(0.5, ccp(0, -40)))
	end
	
end


 

return Enemy