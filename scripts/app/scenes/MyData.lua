--
-- Author: Your Name
-- Date: 2014-12-12 10:34:07
--
-- 游戏数据，单例模式
module("MyData",package.seeall)
local bulltes = {} --保存发射出去的子弹
local enemys = {}  --保存敌人
local enemyName = {"pig_2.png","pig_11.png","bird1.png"} --敌人图片资源名
local enemyHp   = {20, 50 , 100}            --敌人血量
local enemyDemage = {3,5,8}                 --敌人的伤害
 
function getBulltes()
 	return bulltes
end

function addBulltes( bullte )
	table.insert(bulltes , bullte)
end

function resetBulltes()
	bulltes = {}
end

function removeFormBulltes( bullte)
	table.removebyvalue(bulltes, bullte)
end

function getEnemys()
	return enemys
end

function addEnemys(enemy)
	table.insert(enemys, enemy)
end

function resetEnemy()
	enemys = {}
end

function removeFromEnemys(enemy )
	table.removebyvalue(enemys, enemy)
end

function getEnemyName(type)
	return enemyName[type]
end

-- 获取敌人属性
function getEnemyAttribute(type)
	local attribute = {
	name = enemyName[type],
	hp   = enemyHp[type],
	demage = enemyDemage[type]
	}
	return attribute
end

