WCP.LIB.Member = {}
WCP.LIB.Member.__index = WCP.LIB.Member

-- Initializer
function WCP.LIB.Member.create(raid_index)
  local self = {}

  setmetatable(self, WCP.LIB.Member)

  local name, rank, subgroup, _, _, class, _, online, isDead, role, _ = GetRaidRosterInfo(raid_index)

  self.class = class
  self.isDead = isDead
  self.name = name
  self.online = online
  self.rank = rank
  self.role = role
  self.subgroup = subgroup

  return self
end

function WCP.LIB.Member:is_available()
  return (self.name ~= nil)
end

function WCP.LIB.Member:is_leader()
  return (self.rank == 2)
end

function WCP.LIB.Member:is_assist()
  return (self.rank == 1)
end

-- @note Any target set as MainTank via RaidFrames is considered to be a melee.
function WCP.LIB.Member:is_melee()
  if(self.role == "MAINTANK") then return true end

  return (self.class == "ROGUE" or self.class == "WARRIOR")
end

function WCP.LIB.Member:is_range()
  return (self.class == "MAGE" or self.class == "WARLOCK" or self.class == "HUNTER")
end

function WCP.LIB.Member:is_heal()
  return (self.class == "PRIEST" or self.class == "PALADIN" or self.class == "DRUID" or self.class == "SHAMAN")
end
