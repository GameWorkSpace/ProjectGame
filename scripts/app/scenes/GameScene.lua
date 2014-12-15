--
-- Author: Your Name
-- Date: 2014-12-10 19:28:07
--
local Bullte = require("app.scenes.Bullte")
local Enemy  = require("app.scenes.Enemy") 
require("framework.scheduler")
require("app.scenes.MyData")

--游戏主场景
local GameScene = class("GameScene", function ()
	return display.newScene("GameScene")
end)

function GameScene:ctor( )
	--背景图片
	display.newSprite("bj2.png", display.cx, display.cy):addTo(self, -1, 0)
	
	self._bullteArray = {}                   --待发射的子弹队列 
	
	self:createBullte()
	self:createEnemy()

	local scheduler = CCDirector:sharedDirector():getScheduler()
	self._moveScheduler = scheduler:scheduleScriptFunc(function ()
			local enemys = MyData.getEnemys()
			for i,v in ipairs(enemys) do
		   		v:move()                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
		    end                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
			end, 3, false)
	
	self._checkScheduer = scheduler:scheduleScriptFunc(function ()
		self:checkHit()
	end, 1.0/60, false)

end


--创建子弹
function GameScene:createBullte()

	self._currentBullte = Bullte.new({addBullte = function()
			self:addBullte()
		end})
	self._currentBullte:setTouchEnabled(true)
	self._currentBullte:setPosition(ccp(display.cx, 80))
	self:addChild(self._currentBullte)

	for i=1,2 do
		local bullte = Bullte.new({addBullte = function()
			self:addBullte()
		end})
		bullte:setPosition(ccp(35 + 50*(i-1), 50))
		self:addChild(bullte)
		table.insert(self._bullteArray, bullte)
	end

end

--添加子弹
function GameScene:addBullte(  )
	--local bulltes  = MyData.getBulltes()
	self._currentBullte = self._bullteArray[2]
	table.removebyvalue(self._bullteArray, self._currentBullte)
	local seq = CCSequence:createWithTwoActions(
			CCMoveTo:create(0.5, ccp(display.cx, 80)),
			CCCallFunc:create(function ()
				self._currentBullte:setTouchEnabled(true)
			end))
	self._currentBullte:runAction(seq)
	
	print(#self._bullteArray)

	self._bullteArray[1]:runAction(CCMoveTo:create(0.5, ccp(85, 50)))
	local bullte = Bullte.new({addBullte = function()
			self:addBullte()
		end})
	bullte:setPosition(ccp(-25, 50))
	self:addChild(bullte)
	bullte:runAction(CCMoveTo:create(0.5, ccp(35, 50)))
	table.insert(self._bullteArray, bullte)
	self._bullteArray[1],self._bullteArray[2] = self._bullteArray[2],self._bullteArray[1]

end

--创建敌人
function GameScene:createEnemy()
	local enemys = MyData.getEnemys()
	for i=1,4 do
		local enemy = Enemy.new({enemyType = 2})
		enemy:setPosition(ccp(50 + 70*(i-1), 400))
		self:addChild(enemy)
		MyData.addEnemys(enemy)
	end
end

--碰撞检测
function GameScene:checkHit()
	local enemys  = MyData.getEnemys()
	local bulltes = MyData.getBulltes()

	--当敌人或者子弹table为空时，不需要碰撞检测
	if #enemys == 0 or #bulltes == 0 then 
		return
	end

	for i,b in ipairs(bulltes) do
		for j,e in ipairs(enemys) do
			if self:checkBetweenEnmeyAndBullte(e,b) then
				print("发生碰撞")
				e._hp = e._hp - b._demage
				b:stopAllActions()
				MyData.removeFormBulltes(b)
				b:removeFromParent()

				if e._hp <= 0 then
					MyData.removeFromEnemys(e)
					e:stopAllActions()
					e:removeFromParent()
				end

				return
			end
		end
	end
end

--检测2个物体是否有碰撞
function GameScene:checkBetweenEnmeyAndBullte( enemy,bullte)
	
	local size1 = (enemy._sp:boundingBox()).size
	local size2 = (bullte._sp:boundingBox()).size

	local r1 = math.min(size1.width/2.0,size1.height/2.0)
	local r2 = math.min(size2.width/2.0,size2.height/2.0)

	local p1 = enemy:getPositionInCCPoint()
	local p2 = bullte:getPositionInCCPoint()
	
	local distance = math.sqrt((p1.x-p2.x)*(p1.x-p2.x) + (p1.y-p2.y)*(p1.y-p2.y))

	if distance > (r1 + r2)*0.8 then
		return false
	else
		return true
	end

	print("碰撞检测有错误")
end

function GameScene:createTouchLayer()
	
end


function GameScene:onEnter()
	-- body
end

function GameScene:onExit()
	-- body
end



return GameScene