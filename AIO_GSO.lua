
local GetTickCount = GetTickCount
local Game = Game
local myHero = myHero
local Control = Control
local mathSqrt = math.sqrt
local Vector = Vector
local Draw = Draw
local gsoAIO = {
  Vars = nil,
  Dmg = nil,
  Mana = nil,
  Items = nil,
  Spells = nil,
  Utils = nil,
  OB = nil,
  TS = nil,
  Farm = nil,
  TPred = nil,
  Orb = nil,
  Load = nil
}
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
class "__gsoVars"
--
--
--
function __gsoVars:__init()
    self.loaded = true
    self.version = "0.639"
    self.hName = myHero.charName
    self.supportedChampions = {
      ["Draven"] = true,
      ["Ezreal"] = true,
      ["Ashe"] = true,
      ["Twitch"] = true,
      ["KogMaw"] = true,
      ["Vayne"] = true,
      ["Teemo"] = true,
      ["Sivir"] = true,
      ["Tristana"] = true,
      ["Jinx"] = true
    }
    self.drawRanges = {}
    if not self.supportedChampions[self.hName] == true then
        self.loaded = false
        print("gamsteronAIO "..self.version.." | hero not supported !")
    end
    self.Icons = {
        ["arrow"] = "https://raw.githubusercontent.com/gamsteron/GoSExt/master/Icons/arrow.png",
        ["ashe"] = "https://raw.githubusercontent.com/gamsteron/GoSExt/master/Icons/ashe.png",
        ["botrk"] = "https://raw.githubusercontent.com/gamsteron/GoSExt/master/Icons/botrk.png",
        ["draven"] = "https://raw.githubusercontent.com/gamsteron/GoSExt/master/Icons/draven.png",
        ["circles"] = "https://raw.githubusercontent.com/gamsteron/GoSExt/master/Icons/circles.png",
        ["ezreal"] = "https://raw.githubusercontent.com/gamsteron/GoSExt/master/Icons/ezreal.png",
        ["gsoaio"] = "https://raw.githubusercontent.com/gamsteron/GoSExt/master/Icons/gsoaio.png",
        ["item"] = "https://raw.githubusercontent.com/gamsteron/GoSExt/master/Icons/item.png",
        ["kog"] = "https://raw.githubusercontent.com/gamsteron/GoSExt/master/Icons/kog.png",
        ["orb"] = "https://raw.githubusercontent.com/gamsteron/GoSExt/master/Icons/orb.png",
        ["sivir"] = "https://raw.githubusercontent.com/gamsteron/GoSExt/master/Icons/sivir.png",
        ["teemo"] = "https://raw.githubusercontent.com/gamsteron/GoSExt/master/Icons/teemo.png",
        ["timer"] = "https://raw.githubusercontent.com/gamsteron/GoSExt/master/Icons/timer.png",
        ["tristana"] = "https://raw.githubusercontent.com/gamsteron/GoSExt/master/Icons/tristana.png",
        ["ts"] = "https://raw.githubusercontent.com/gamsteron/GoSExt/master/Icons/ts.png",
        ["twitch"] = "https://raw.githubusercontent.com/gamsteron/GoSExt/master/Icons/twitch.png",
        ["vayne"] = "https://raw.githubusercontent.com/gamsteron/GoSExt/master/Icons/vayne.png",
        ["jinx"] = "https://raw.githubusercontent.com/gamsteron/GoSExt/master/Icons/jinx.png",
        ["pencil"] = "https://raw.githubusercontent.com/gamsteron/GoSExt/master/Icons/pencil.png"
    }
    self._draw          = {}
    self._aaSpeed       = function() return myHero.attackSpeed end
    self._champMenu     = function() return 0 end
    self._bonusDmg      = function() return 0 end
    self._bonusDmgUnit  = function() return 0 end
    self._onTick        = function() return 0 end
    self._mousePos      = function() return nil end
    self._canMove       = function() return true end
    self._canAttack     = function(target) return true end
-- TRISTANA :
    self.meTristana = self.hName == "Tristana"
    self.tristanaETar = nil
-- SIVIR :
    self.meSivir = self.hName == "Sivir"
    self.sivirCanQ = true
    self.sivirCanW = true
-- VAYNE :
    self.meVayne = self.hName == "Vayne"
    self.vayneCanQ = true
    self.vayneCanE = true
-- KOG :
    self.meKog = self.hName == "KogMaw"
    self.kogCanQ = true
    self.kogCanE = true
    self.kogCanR = true
-- TWITCH :
    self.meTwitch = self.hName == "Twitch"
    self.twitchCanW = true
    self.twitchCanE = true
-- ASHE :
    self.meAshe = self.hName == "Ashe"
    self.asheCanW = true
    self.asheCanR = true
-- EZREAL :
    self.meEzreal = self.hName == "Ezreal"
    self.ezrealCanQ = true
    self.ezrealCanW = true
-- DRAVEN :
    self.meDraven = self.hName == "Draven"
    self.dravenCanW = true
    self.dravenCanE = true
    self.dravenCanR = true
end
function __gsoVars:_setDraw(func) self._draw[#self._draw+1] = func end
function __gsoVars:_setAASpeed(func) self._aaSpeed = func end
function __gsoVars:_setChampMenu(func) self._champMenu = func end
function __gsoVars:_setBonusDmg(func) self._bonusDmg = func end
function __gsoVars:_setBonusDmgUnit(func) self._bonusDmgUnit = func end
function __gsoVars:_setOnTick(func) self._onTick = func end
function __gsoVars:_setMousePos(func) self._mousePos = func end
function __gsoVars:_setCanMove(func) self._canMove = func end
function __gsoVars:_setCanAttack(func) self._canAttack = func end
gsoAIO.Vars = __gsoVars()
if gsoAIO.Vars.loaded == false then
    return
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
class "__gsoDmg"
--
--
--
function __gsoDmg:__init()
    self.Damages =
    {
        ["Tristana"] =
        {
            e =
            {
                dmgAP =
                    function()
                        return 25 + ( 25 * myHero:GetSpellData(_E).level ) + ( 0.25 * myHero.ap )
                    end,
                dmgAD =
                    function(stacks)
                        local elvl = myHero:GetSpellData(_E).level
                        local meDmg = myHero.totalDamage
                        local meAP = myHero.ap
                        local stacksDmg = 0
                        local baseDmg = 50 + ( 10 * elvl ) + ( ( 0.4 + ( 0.1 * elvl ) ) * meDmg ) + ( 0.5 * meAP )
                        if stacks > 0 then
                            local stackDmg = 15 + ( 3 * elvl ) + ( ( 0.12 + ( 0.03 * elvl ) ) * meDmg ) + ( 0.15 * meAP )
                            stacksDmg = stacks * stackDmg
                        end
                        return baseDmg + stacksDmg
                    end,
                dmgType = "mixed"
            },
            r =
            {
                dmgAP =
                    function()
                        return 200 + ( 100 * myHero:GetSpellData(_R).level ) + myHero.ap
                    end,
                dmgType = "ap"
            }
        }
    }
    self.CalcDmg =
        function(unit, dmg, isAP)
            if unit == nil or dmg == nil or isAP == nil then return 0 end
            if dmg > 0 then
                local def = isAP and unit.magicResist - myHero.magicPen or unit.armor - myHero.armorPen
                if def > 0 then
                    def = isAP and myHero.magicPenPercent * def or myHero.bonusArmorPenPercent * def
                end
                local result = def > 0 and dmg * ( 100 / ( 100 + def ) ) or dmg * ( 2 - ( 100 / ( 100 - def ) ) )
                local unitShield = isAP and unit.shieldAP or 0
                result = result - unitShield
                return result < 0 and 0 or result
            else
                return 0
            end
        end
    self.PredHP =
        function(unit, spellData)
            if unit == nil or spellData == nil then return 0 end
            local dmgAP = spellData.dmgAP and spellData.dmgAP or 0
            local dmgAD = spellData.dmgAD and spellData.dmgAD or 0
            local dmgTrue = spellData.dmgTrue and spellData.dmgTrue or 0
            local dmgType = spellData.dmgType and spellData.dmgType or ""
            if dmgType == "ad" then
                return self.CalcDmg(unit, dmgAD, false) - unit.shieldAD
            end
            if dmgType == "ap" then
                return self.CalcDmg(unit, dmgAP, true) - unit.shieldAD
            end
            if dmgType == "true" then
                return dmgTrue - unit.shieldAD
            end
            if dmgType == "mixed" then
                return self.CalcDmg(unit, dmgAP, true) + self.CalcDmg(unit, dmgAD, false) - unit.shieldAD
            end
            return 0
        end
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
class "__gsoMana"
--
--
--
function __gsoMana:__init()
    self.spellData = {}
    self.priority = {}
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoMana:_enoughMana(spell)
    local costQ, cdq, costW, cdw, costE, cde, costR, cdr = 0, 0, 0, 0, 0, 0, 0 ,0
    if self.spellData.q and myHero:GetSpellData(_Q).level > 0 then
        costQ = self.spellData.qm and self.spellData.qm or self.spellData.qf()
        cdq = myHero:GetSpellData(_Q).currentCd
    end
    if self.spellData.w and myHero:GetSpellData(_W).level > 0 then
        costW = self.spellData.wm and self.spellData.wm or self.spellData.wf()
        cdw = myHero:GetSpellData(_W).currentCd
    end
    if self.spellData.e and myHero:GetSpellData(_E).level > 0 then
        costE = self.spellData.em and self.spellData.em or self.spellData.ef()
        cde = myHero:GetSpellData(_E).currentCd
    end
    if self.spellData.r and myHero:GetSpellData(_R).level > 0 then
        costR = self.spellData.rm and self.spellData.rm or self.spellData.rf()
        cdr = myHero:GetSpellData(_R).currentCd
    end
    local priority = self.priority[spell]
    local mana = myHero.mana
    local cdMax = 0
    for k,v in pairs(self.priority) do
        if k == _Q then
            if v < priority then
                mana = mana - costQ
                if cdq > cdMax then cdMax = cdq end
            end
        elseif k == _W then
            if v < priority then
                mana = mana - costW
                if cdw > cdMax then cdMax = cdw end
            end
        elseif k == _E then
            if v < priority then
                mana = mana - costE
                if cde > cdMax then cdMax = cde end
            end
        elseif k == _R then
            if v < priority then
                mana = mana - costR
                if cdr > cdMax then cdMax = cdr end
            end
        end
    end
    local extraMana = cdMax > 0 and myHero.mpRegen * cdMax or 0
    mana = mana + extraMana
    local spellCost = 0
    if spell == _Q then
        spellCost = costQ
    elseif spell == _W then
        spellCost = costW
    elseif spell == _E then
        spellCost = costE
    elseif spell == _R then
        spellCost = costR
    end
    if mana < spellCost then
        return false
    end
    return true
end
gsoAIO.Mana = __gsoMana()
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
class "__gsoItems"
--
--
--
function __gsoItems:__init()
    self.itemList = {
        [3144] = { i = nil, hk = nil },
        [3153] = { i = nil, hk = nil }
    }
    self.lastBotrk = 0
    self.performance = 0
    Callback.Add('Tick', function() self:_tick() end)
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoItems:_botrk(unit)
    local hkKey = nil
    if GetTickCount() < self.lastBotrk + 1000 then return false end
    local itmSlot1 = self.itemList[3144].i
    local itmSlot2 = self.itemList[3153].i
    if itmSlot1 and myHero:GetSpellData(itmSlot1).currentCd == 0 then
        hkKey = self.itemList[3144].hk
    elseif itmSlot2 and myHero:GetSpellData(itmSlot2).currentCd == 0 then
        hkKey = self.itemList[3153].hk
    end
    if hkKey and gsoAIO.Load.menu.orb.keys.combo:Value() and gsoAIO.Load.menu.gsoitem.botrk:Value() then
        local unitPos = unit.pos
        if gsoAIO.Utils:_getDistance(myHero.pos, unitPos) < 520 then
            local cPos = cursorPos
            Control.SetCursorPos(unitPos)
            gsoAIO.Orb.setCursor = unitPos
            Control.KeyDown(hkKey)
            Control.KeyUp(hkKey)
            gsoAIO.Items.lastBotrk = GetTickCount()
            gsoAIO.Orb.dActions[GetTickCount()] = { function() Control.SetCursorPos(cPos.x, cPos.y) end, 50 }
            gsoAIO.Orb.dActionsC = gsoAIO.Orb.dActionsC + 1
            return true
        end
    end
    return false
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoItems:_tick()
    local getTick = GetTickCount()
    if getTick > self.performance + 500 then
        self.performance = GetTickCount()
        local t = { ITEM_1, ITEM_2, ITEM_3, ITEM_4, ITEM_5, ITEM_6 }
        local t2 = { [3153] = 0, [3144] = 0 }
        for i = 1, #t do
            local item = t[i]
            local itemID = myHero:GetItemData(item).itemID
            local t2Item = t2[itemID]
            if t2Item then
                t2[itemID] = t2Item + 1
            end
            if self.itemList[itemID] then
                self.itemList[itemID].i = item
                local t3 = { HK_ITEM_1, HK_ITEM_2, HK_ITEM_3, HK_ITEM_4, HK_ITEM_5, HK_ITEM_6 }
                self.itemList[itemID].hk = t3[i]
            end
        end
        for k,v in pairs(self.itemList) do
            local itm = self.itemList[k]
            if t2[k] == 0 and (itm.i or itm.hk) then
                self.itemList[k].i = nil
                self.itemList[k].hk = nil
            end
        end
    end
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
class "__gsoSpells"
--
--
--
function __gsoSpells:__init()
    self.lastQ    = 0
    self.lastW    = 0
    self.lastE    = 0
    self.lastR    = 0
    self.qLatency = 0
    self.wLatency = 0
    self.eLatency = 0
    self.rLatency = 0
    self.delayedSpell = {}
    Callback.Add('WndMsg', function(msg, wParam) self:_onWndMsg(msg, wParam) end)
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoSpells:_onWndMsg(msg, wParam)
    local getTick = GetTickCount()
    local isKey = gsoAIO.Load.menu.orb.keys.combo:Value() or gsoAIO.Load.menu.orb.keys.harass:Value() or gsoAIO.Load.menu.orb.keys.laneClear:Value() or gsoAIO.Load.menu.orb.keys.lastHit:Value()
    if Game.CanUseSpell(_Q) == 0 and wParam == HK_Q and getTick > self.lastQ + 1000 then
        self.lastQ = getTick
        self.qLatency = Game.Latency()*1.1
        if isKey and not self.delayedSpell[0] then
            self.delayedSpell[0] = { function() gsoAIO.Utils:_castAgain(wParam) end, getTick }
        end
    elseif Game.CanUseSpell(_W) == 0 and wParam == HK_W and getTick > self.lastW + 1000 then
        self.lastW = getTick
        self.wLatency = Game.Latency()*1.1
        if isKey and not self.delayedSpell[1] then
            self.delayedSpell[1] = { function() gsoAIO.Utils:_castAgain(wParam) end, getTick }
        end
    elseif Game.CanUseSpell(_E) == 0 and wParam == HK_E and getTick > self.lastE + 1000 then
        self.lastE = getTick
        self.eLatency = Game.Latency()*1.1
        if gsoAIO.Vars.meEzreal then
            gsoAIO.Vars.ezrealCanQ = false
            gsoAIO.Vars.ezrealCanW = false
        end
        if isKey and not self.delayedSpell[2] then
            self.delayedSpell[2] = { function() gsoAIO.Utils:_castAgain(wParam) end, getTick }
        end
    elseif Game.CanUseSpell(_R) == 0 and wParam == HK_R and getTick > self.lastR + 1000 then
        self.lastR = getTick
        self.rLatency = Game.Latency()*1.1
        if gsoAIO.Vars.meEzreal then
            gsoAIO.Vars.ezrealCanQ = false
            gsoAIO.Vars.ezrealCanW = false
        end
        if isKey and not self.delayedSpell[3] then
            self.delayedSpell[3] = { function() gsoAIO.Utils:_castAgain(wParam) end, getTick }
        end
    end
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
class "__gsoUtils"
--
--
--
function __gsoUtils:__init()
    self.latencies = {}
    self.maxPing = Game.Latency() * 0.001
    self.minPing = Game.Latency() * 0.001
    self.delayedActions = {}
    self.attacks = {
        ["caitlynheadshotmissile"] = true,
        ["quinnwenhanced"] = true,
        ["viktorqbuff"] = true
    }
    self.noAttacks = {
        ["volleyattack"] = true,
        ["volleyattackwithsound"] = true,
        ["sivirwattackbounce"] = true,
        ["asheqattacknoonhit"] = true
    }
    self.undyingBuffs = {
        ["zhonyasringshield"] = true
    }
    self.Priorities = {
        ["Aatrox"] = 3, ["Ahri"] = 2, ["Akali"] = 2, ["Alistar"] = 5, ["Amumu"] = 5, ["Anivia"] = 2, ["Annie"] = 2, ["Ashe"] = 1, ["AurelionSol"] = 2, ["Azir"] = 2,
        ["Bard"] = 3, ["Blitzcrank"] = 5, ["Brand"] = 2, ["Braum"] = 5, ["Caitlyn"] = 1, ["Camille"] = 3, ["Cassiopeia"] = 2, ["Chogath"] = 5, ["Corki"] = 1,
        ["Darius"] = 4, ["Diana"] = 2, ["DrMundo"] = 5, ["Draven"] = 1, ["Ekko"] = 2, ["Elise"] = 3, ["Evelynn"] = 2, ["Ezreal"] = 1, ["Fiddlesticks"] = 3, ["Fiora"] = 3,
        ["Fizz"] = 2, ["Galio"] = 5, ["Gangplank"] = 2, ["Garen"] = 5, ["Gnar"] = 5, ["Gragas"] = 4, ["Graves"] = 2, ["Hecarim"] = 4, ["Heimerdinger"] = 3, ["Illaoi"] =  3,
        ["Irelia"] = 3, ["Ivern"] = 5, ["Janna"] = 4, ["JarvanIV"] = 3, ["Jax"] = 3, ["Jayce"] = 2, ["Jhin"] = 1, ["Jinx"] = 1, ["Kalista"] = 1, ["Karma"] = 2, ["Karthus"] = 2,
        ["Kassadin"] = 2, ["Katarina"] = 2, ["Kayle"] = 2, ["Kayn"] = 2, ["Kennen"] = 2, ["Khazix"] = 2, ["Kindred"] = 2, ["Kled"] = 4, ["KogMaw"] = 1, ["Leblanc"] = 2,
        ["LeeSin"] = 3, ["Leona"] = 5, ["Lissandra"] = 2, ["Lucian"] = 1, ["Lulu"] = 3, ["Lux"] = 2, ["Malphite"] = 5, ["Malzahar"] = 3, ["Maokai"] = 4, ["MasterYi"] = 1,
        ["MissFortune"] = 1, ["MonkeyKing"] = 3, ["Mordekaiser"] = 2, ["Morgana"] = 3, ["Nami"] = 3, ["Nasus"] = 4, ["Nautilus"] = 5, ["Nidalee"] = 2, ["Nocturne"] = 2,
        ["Nunu"] = 4, ["Olaf"] = 4, ["Orianna"] = 2, ["Ornn"] = 4, ["Pantheon"] = 3, ["Poppy"] = 4, ["Quinn"] = 1, ["Rakan"] = 3, ["Rammus"] = 5, ["RekSai"] = 4,
        ["Renekton"] = 4, ["Rengar"] = 2, ["Riven"] = 2, ["Rumble"] = 2, ["Ryze"] = 2, ["Sejuani"] = 4, ["Shaco"] = 2, ["Shen"] = 5, ["Shyvana"] = 4, ["Singed"] = 5,
        ["Sion"] = 5, ["Sivir"] = 1, ["Skarner"] = 4, ["Sona"] = 3, ["Soraka"] = 3, ["Swain"] = 3, ["Syndra"] = 2, ["TahmKench"] = 5, ["Taliyah"] = 2, ["Talon"] = 2,
        ["Taric"] = 5, ["Teemo"] = 2, ["Thresh"] = 5, ["Tristana"] = 1, ["Trundle"] = 4, ["Tryndamere"] = 2, ["TwistedFate"] = 2, ["Twitch"] = 1, ["Udyr"] = 4, ["Urgot"] = 4,
        ["Varus"] = 1, ["Vayne"] = 1, ["Veigar"] = 2, ["Velkoz"] = 2, ["Vi"] = 4, ["Viktor"] = 2, ["Vladimir"] = 3, ["Volibear"] = 4, ["Warwick"] = 4, ["Xayah"] = 1,
        ["Xerath"] = 2, ["XinZhao"] = 3, ["Yasuo"] = 2, ["Yorick"] = 4, ["Zac"] = 5, ["Zed"] = 2, ["Ziggs"] = 2, ["Zilean"] = 3, ["Zoe"] = 2, ["Zyra"] = 2
    }
    Callback.Add('Tick', function() self:_tick() end)
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoUtils:_tick()
    self.latencies[GetTickCount() + 2500] = Game.Latency() * 0.001
    local maxPing = 0
    local minPing = 50
    for k,v in pairs(self.latencies) do
        if v > maxPing then
            maxPing = v
        end
        if v < minPing then
            minPing = v
        end
        if GetTickCount() > k then
            self.latencies[k] = nil
        end
    end
    self.maxPing = maxPing
    self.minPing = minPing
    for i = 1, #gsoAIO.Utils.delayedActions do
        local dAction = gsoAIO.Utils.delayedActions[i]
        if Game.Timer() > dAction.endTime then
            dAction.func()
            gsoAIO.Utils.delayedActions[i] = nil
            --print("ok")
        end
    end
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoUtils:_getDistance(a, b)
  local x = a.x - b.x
  local z = a.z - b.z
  return mathSqrt(x * x + z * z)
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoUtils:_pointOnLineSegment(x, z, ax, az, bx, bz)
    local bxax = bx - ax
    local bzaz = bz - az
    local t = ((x - ax) * bxax + (z - az) * bzaz) / (bxax * bxax + bzaz * bzaz)
    if t < 0 then return false
    elseif t > 1 then return false
    else return true
    end
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoUtils:_isImmortal(unit, orb)
    local unitHPPercent = 100 * unit.health / unit.maxHealth
    if self.undyingBuffs["JaxCounterStrike"] ~= nil then    self.undyingBuffs["JaxCounterStrike"] = orb end
    if self.undyingBuffs["kindredrnodeathbuff"] ~= nil then self.undyingBuffs["kindredrnodeathbuff"] = unitHPPercent < 10 end
    if self.undyingBuffs["UndyingRage"] ~= nil then         self.undyingBuffs["UndyingRage"] = unitHPPercent < 15 end
    if self.undyingBuffs["ChronoShift"] ~= nil then         self.undyingBuffs["ChronoShift"] = unitHPPercent < 15; self.undyingBuffs["chronorevive"] = unitHPPercent < 15 end
    for i = 0, unit.buffCount do
        local buff = unit:GetBuff(i)
        if buff and buff.count > 0 then
            local undyingBuff = self.undyingBuffs[buff.name]
            if undyingBuff and undyingBuff == true then
                return true
            end
        end
    end
    return false
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoUtils:_valid(unit, orb)
    if not unit or self:_isImmortal(unit, orb) then
        return false
    end
    if not unit.dead and unit.isTargetable and unit.visible and unit.valid then
        return true
    end
    return false
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoUtils:_castAgain(i)
    Control.KeyDown(i)
    Control.KeyUp(i)
    Control.KeyDown(i)
    Control.KeyUp(i)
    Control.KeyDown(i)
    Control.KeyUp(i)
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoUtils:_isImmobile(unit)
    for i = 0, unit.buffCount do
        local buff = unit:GetBuff(i)
        if buff and buff.count > 0 then
            local bType = buff.type
            if bType == 5 or bType == 11 or bType == 29 or bType == 24 or buff.name == "recall" then
                return true
            end
        end
    end
    return false
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoUtils:_nearTurret(pos, range, bb)
    for i = 1, #gsoAIO.OB.enemyTurrets do
        local unit = gsoAIO.OB.enemyTurrets[i]
        local range = bb and unit.boundingRadius or range
        if self:_getDistance(pos, unit.pos) < range then
            return true
        end
    end
    return false
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoUtils:_nearHeroes(pos, range, bb)
    for i = 1, #gsoAIO.OB.enemyHeroes do
        local unit = gsoAIO.OB.enemyHeroes[i]
        local range = bb and unit.boundingRadius or range
        if self:_getDistance(pos, unit.pos) < range then
            return true
        end
    end
    return false
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoUtils:_nearMinions(pos, range, bb)
    for i = 1, #gsoAIO.OB.enemyMinions do
        local unit = gsoAIO.OB.enemyMinions[i]
        local range = bb and unit.boundingRadius or range
        if self:_getDistance(pos, unit.pos) < range then
            return true
        end
    end
    return false
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoUtils:_nearUnit(pos, id)
    for i = 1, #gsoAIO.OB.enemyHeroes do
        local unit = gsoAIO.OB.enemyHeroes[i]
        if id ~= unit.networkID and self:_getDistance(pos, unit.pos) < unit.boundingRadius then
            return true
        end
    end
    for i = 1, #gsoAIO.OB.enemyMinions do
        local unit = gsoAIO.OB.enemyMinions[i]
        if self:_getDistance(pos, unit.pos) < unit.boundingRadius then
            return true
        end
    end
    return false
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoUtils:_buffCount(unit, bName)
    for i = 0, unit.buffCount do
        local buff = unit:GetBuff(i)
        if buff and buff.count > 0 and buff.name:lower() == bName then
            return buff.count
        end
    end
    return 0
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoUtils:_hasBuff(unit, bName)
    for i = 0, unit.buffCount do
        local buff = unit:GetBuff(i)
        if buff and buff.count > 0 and buff.name:lower() == bName then
            return true
        end
    end
    return false
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoUtils:_isReady(spell)
    return gsoAIO.Orb.dActionsC == 0 and Game.CanUseSpell(spell) == 0 and gsoAIO.Mana:_enoughMana(spell)
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoUtils:_checkWall(from, to, distance)
    local pos1 = to + (to-from):Normalized() * 50
    local pos2 = pos1 + (to-from):Normalized() * (distance - 50)
    local point1 = Point(pos1.x, pos1.z)
    local point2 = Point(pos2.x, pos2.z)
    if (MapPosition:inWall(point1) and MapPosition:inWall(point2)) or MapPosition:intersectsWall(LineSegment(point1, point2)) then
        return true
    end
    return false
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoUtils:_countEnemyHeroesInRange(sourcePos, range, bb)
    local count = 0
    for i = 1, #gsoAIO.OB.enemyHeroes do
        local unit = gsoAIO.OB.enemyHeroes[i]
        local extraRange = bb and unit.boundingRadius or 0
        if gsoAIO.Utils:_getDistance(sourcePos, unit.pos) < range + extraRange then
            count = count + 1
        end
    end
    return count
end



--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
class "__gsoOB"
--
--
--
function __gsoOB:__init()
    self.allyMinions  = {}
    self.enemyMinions = {}
    self.enemyHeroes  = {}
    self.enemyTurrets = {}
    self.meTeam       = myHero.team
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoOB:_tick()
    local mePos = myHero.pos
    for i=1, #self.allyMinions do self.allyMinions[i]=nil end
    for i=1, #self.enemyMinions do self.enemyMinions[i]=nil end
    for i=1, #self.enemyHeroes do self.enemyHeroes[i]=nil end
    for i=1, #self.enemyTurrets do self.enemyTurrets[i]=nil end
    for i = 1, Game.MinionCount() do
        local minion = Game.Minion(i)
        if minion and gsoAIO.Utils:_getDistance(mePos, minion.pos) < 2000 and not minion.dead and minion.isTargetable and minion.visible and minion.valid and not minion.isImmortal then
            if minion.team ~= self.meTeam then
                self.enemyMinions[#self.enemyMinions+1] = minion
            else
                self.allyMinions[#self.allyMinions+1] = minion
            end
        end
    end
    for i = 1, Game.HeroCount() do
        local hero = Game.Hero(i)
        if hero and hero.team ~= self.meTeam and gsoAIO.Utils:_getDistance(mePos, hero.pos) < 10000 and not hero.dead and hero.isTargetable and hero.visible and hero.valid then
            self.enemyHeroes[#self.enemyHeroes+1] = hero
        end
    end
    for i = 1, Game.TurretCount() do
        local turret = Game.Turret(i)
        if turret and turret.team ~= self.meTeam and gsoAIO.Utils:_getDistance(mePos, turret.pos) < 2000 and not turret.dead and turret.isTargetable and turret.visible and turret.valid and not turret.isImmortal then
            self.enemyTurrets[#self.enemyTurrets+1] = turret
        end
    end
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
class "__gsoTS"
--
--
--
function __gsoTS:__init()
    self.apDmg = false
    self.isTeemo = false
    self.isBlinded = false
    self.loadedChamps = false
    self.lastTarget = nil
    self.lastFound = -10000000
    self.selectedTarget = nil
    self.lastSelTick = 0
    self.LHTimers     = {
        [0] = { tick = 0, id = 0 },
        [1] = { tick = 0, id = 0 },
        [2] = { tick = 0, id = 0 },
        [3] = { tick = 0, id = 0 },
        [4] = { tick = 0, id = 0 }
    }
    gsoAIO.Vars:_setDraw(function() self:_draw() end)
    Callback.Add('WndMsg', function(msg, wParam) self:_onWndMsg(msg, wParam) end)
    Callback.Add('Tick', function() self:_tick() end)
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoTS:_getTarget(_range, orb, changeRange)
    if gsoAIO.Load.menu.ts.selected.only:Value() == true and gsoAIO.Utils:_valid(self.selectedTarget, true) then
        return self.selectedTarget
    end
    local result  = nil
    local num     = 10000000
    local mode    = gsoAIO.Load.menu.ts.Mode:Value()
    local prioT  = { 10000000, 10000000 }
    for i = 1, #gsoAIO.OB.enemyHeroes do
        local unit = gsoAIO.OB.enemyHeroes[i]
        local unitID = unit.networkID
        local canTrist = gsoAIO.Vars.meTristana and gsoAIO.Load.menu.ts.tristE.enable:Value() and gsoAIO.Vars.tristanaETar and gsoAIO.Vars.tristanaETar.stacks >= gsoAIO.Load.menu.ts.tristE.stacks:Value() and unitID == gsoAIO.Vars.tristanaETar.id
        local range = changeRange == true and _range + myHero.boundingRadius + unit.boundingRadius or _range
        local meExtended = myHero.pos:Extended(gsoAIO.Orb.lMovePath , (0.15+(gsoAIO.Utils.maxPing*1.5)) * myHero.ms)
        local dist1 = gsoAIO.Utils:_getDistance(myHero.pos, unit.pos)
        local dist2 = gsoAIO.Utils:_getDistance(meExtended, unit.pos)
        local dist3 = dist2 > dist1 and dist2 or dist1
        if gsoAIO.Utils:_valid(unit, orb) and dist3 < range then
            if gsoAIO.Load.menu.ts.selected.enable:Value() and self.selectedTarget and unitID == self.selectedTarget.networkID then
                return self.selectedTarget
            elseif canTrist then
                return unit
            elseif mode == 1 then
                local unitName = unit.charName
                local priority = 6
                if unitName ~= nil then
                    priority = gsoAIO.Load.menu.ts.priority[unitName] and gsoAIO.Load.menu.ts.priority[unitName]:Value() or priority
                end
                local calcNum = 1
                if priority == 1 then
                    calcNum = 1
                elseif priority == 2 then
                    calcNum = 1.15
                elseif priority == 3 then
                    calcNum = 1.3
                elseif priority == 4 then
                    calcNum = 1.45
                elseif priority == 5 then
                    calcNum = 1.6
                elseif priority == 6 then
                    calcNum = 1.75
                end
                local def = self.apDmg == true and unit.magicResist - myHero.magicPen or unit.armor - myHero.armorPen
                def = def * calcNum
                if def > 0 then
                      def = self.apDmg == true and myHero.magicPenPercent * def or myHero.bonusArmorPenPercent * def
                end
                local hpE = unit.health
                hpE = hpE * calcNum
                hpE = hpE * ( ( 100 + def ) / 100 )
                hpE = hpE - (unit.totalDamage*unit.attackSpeed*2) - unit.ap
                if hpE < num then
                    num     = hpE
                    result  = unit
                end
            elseif mode == 2 then
                if dist3 < num then
                    num = dist3
                    result = unit
                end
            elseif mode == 3 then
                local hpE = unit.health
                if hpE < num then
                    num = hpE
                    result = unit
                end
            elseif mode == 4 then
                local unitName = unit.charName
                local hpE = unit.health - (unit.totalDamage*unit.attackSpeed*2) - unit.ap
                local priority = 6
                if unitName ~= nil then
                    priority = gsoAIO.Load.menu.ts.priority[unitName] and gsoAIO.Load.menu.ts.priority[unitName]:Value() or priority
                end
                if priority == prioT[1] and hpE < prioT[2] then
                    prioT[2] = hpE
                    result = unit
                elseif priority < prioT[1] then
                    prioT[1] = priority
                    prioT[2] = hpE
                    result = unit
                end
            end
        end
    end
    return result
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoTS:_comboT()
    local target = self:_getTarget(myHero.range, true, true)
    if target then
        self.lastTarget = target
        return target
    else
        self.lastTarget = nil
        return nil
    end
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoTS:_lastHitT()
    local result  = nil
    local min     = 10000000
    for i = 1, #gsoAIO.Farm.lastHit do
        local eMinionLH = gsoAIO.Farm.lastHit[i]
        local minion	= eMinionLH[1]
        local hp		= eMinionLH[2]
        local checkT = Game.Timer() < self.LHTimers[0].tick
        local mHandle = minion.handle
        if (not checkT or (checkT and self.LHTimers[0].id ~= mHandle)) and hp < min then
            min = hp
            result = minion
            self.LHTimers[4].tick = Game.Timer() + 0.75
            self.LHTimers[4].id = mHandle
        end
    end
    return result
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoTS:_getTurret()
    local result = nil
    for i=1, #gsoAIO.OB.enemyTurrets do
        local turret = gsoAIO.OB.enemyTurrets[i]
        local range = myHero.range + myHero.boundingRadius + turret.boundingRadius
        if gsoAIO.Utils:_getDistance(myHero.pos, turret.pos) < range then
            result = turret
            break
        end
    end
    return result
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoTS:_laneClearT()
    local result	= self:_lastHitT()
    if not result then
        result = self:_comboT()
        if not result and #gsoAIO.Farm.almostLH == 0 and gsoAIO.Farm.shouldWait == false then
            result = self:_getTurret()
            if not result then
                local min = 10000000
                for i = 1, #gsoAIO.Farm.laneClear do
                    local minion = gsoAIO.Farm.laneClear[i]
                    local hp     = minion.health
                    if hp < min then
                        min = hp
                        result = minion
                    end
                end
            end
        end
    end
    return result
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoTS:_harassT()
    local result = self:_lastHitT()
    return result == nil and self:_comboT() or result
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoTS:_draw()
    if gsoAIO.Load.menu.gsodraw.circle1.seltar:Value() and gsoAIO.Utils:_valid(self.selectedTarget, true) then
        Draw.Circle(self.selectedTarget.pos, gsoAIO.Load.menu.gsodraw.circle1.seltarradius:Value(), gsoAIO.Load.menu.gsodraw.circle1.seltarwidth:Value(), gsoAIO.Load.menu.gsodraw.circle1.seltarcolor:Value())
    end
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoTS:_tick()
    if gsoAIO.TS.isTeemo == true then
        self.isBlinded = gsoAIO.Utils:_hasBuff(myHero, "blindingdart")
    end
    if self.loadedChamps == false then
        for i = 1, Game.HeroCount() do
            local hero = Game.Hero(i)
            if hero.team ~= gsoAIO.OB.meTeam then
                local eName = hero.charName
                if eName and #eName > 0 and not gsoAIO.Load.menu.ts.priority[eName] then
                    self.lastFound = Game.Timer()
                    local priority = gsoAIO.Utils.Priorities[eName] ~= nil and gsoAIO.Utils.Priorities[eName] or 5
                    gsoAIO.Load.menu.ts.priority:MenuElement({ id = eName, name = eName, value = priority, min = 1, max = 5, step = 1 })
                    if eName == "Teemo" then          self.isTeemo = true
                    elseif eName == "Kayle" then      gsoAIO.Utils.undyingBuffs["JudicatorIntervention"] = true
                    elseif eName == "Taric" then      gsoAIO.Utils.undyingBuffs["TaricR"] = true
                    elseif eName == "Kindred" then    gsoAIO.Utils.undyingBuffs["kindredrnodeathbuff"] = true
                    elseif eName == "Zilean" then     gsoAIO.Utils.undyingBuffs["ChronoShift"] = true; gsoAIO.Utils.undyingBuffs["chronorevive"] = true
                    elseif eName == "Tryndamere" then gsoAIO.Utils.undyingBuffs["UndyingRage"] = true
                    elseif eName == "Jax" then        gsoAIO.Utils.undyingBuffs["JaxCounterStrike"] = true
                    elseif eName == "Fiora" then      gsoAIO.Utils.undyingBuffs["FioraW"] = true
                    elseif eName == "Aatrox" then     gsoAIO.Utils.undyingBuffs["aatroxpassivedeath"] = true
                    elseif eName == "Vladimir" then   gsoAIO.Utils.undyingBuffs["VladimirSanguinePool"] = true
                    elseif eName == "KogMaw" then     gsoAIO.Utils.undyingBuffs["KogMawIcathianSurprise"] = true
                    elseif eName == "Karthus" then    gsoAIO.Utils.undyingBuffs["KarthusDeathDefiedBuff"] = true
                    end
                end
            end
        end
        if Game.Timer() > self.lastFound + 5 and Game.Timer() < self.lastFound + 10 then
            self.loadedChamps = true
        end
    end
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoTS:_onWndMsg(msg, wParam)
    local getTick = GetTickCount()
    if msg == WM_LBUTTONDOWN and gsoAIO.Load.menu.ts.selected.enable:Value() == true then
        if getTick > self.lastSelTick + 100 and getTick > gsoAIO.Spells.lastQ + 250 and getTick > gsoAIO.Spells.lastW + 250 and getTick > gsoAIO.Spells.lastE + 250 and getTick > gsoAIO.Spells.lastR + 250 then 
            local num = 10000000
            local enemy = nil
            for i = 1, #gsoAIO.OB.enemyHeroes do
                local hero = gsoAIO.OB.enemyHeroes[i]
                local heroPos = hero.pos
                if gsoAIO.Utils:_valid(hero, true) and gsoAIO.Utils:_getDistance(myHero.pos, heroPos) < 10000 then
                    local distance = gsoAIO.Utils:_getDistance(heroPos, mousePos)
                    if distance < 150 and distance < num then
                        enemy = hero
                        num = distance
                    end
                end
            end
            if enemy ~= nil then
                self.selectedTarget = enemy
            else
                self.selectedTarget = nil
            end
            self.lastSelTick = GetTickCount()
        end
    end
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
class "__gsoFarm"
--
--
--
function __gsoFarm:__init()
    self.aaDmg          = myHero.totalDamage
    self.lastHit        = {}
    self.almostLH       = {}
    self.laneClear      = {}
    self.aAttacks       = {}
    self.shouldWaitT    = 0
    self.shouldWait     = false
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoFarm:_tick()
    self.aaDmg   = myHero.totalDamage + gsoAIO.Vars._bonusDmg()
    if self.shouldWait == true and Game.Timer() > self.shouldWaitT + 0.5 then
        self.shouldWait = false
    end
    self:_setActiveAA()
    self:_handleActiveAA()
    self:_setEnemyMinions()
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoFarm:_predPos(speed, pPos, unit)
    local unitPath = unit.pathing
    if unitPath.hasMovePath == true then
        local uPos    = unit.pos
        local ePos    = unitPath.endPos
        local distUP  = gsoAIO.Utils:_getDistance(pPos, uPos)
        local distEP  = gsoAIO.Utils:_getDistance(pPos, ePos)
        local unitMS  = unit.ms
        if distEP > distUP then
            return uPos:Extended(ePos, 50+(unitMS*(distUP / (speed - unitMS))))
        else
            return uPos:Extended(ePos, 50+(unitMS*(distUP / (speed + unitMS))))
        end
    end
    return unit.pos
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoFarm:_possibleDmg(eMin, time)
    local result = 0
    for i = 1, #gsoAIO.OB.allyMinions do
        local aMin = gsoAIO.OB.allyMinions[i]
        local aaData  = aMin.attackData
        local aDmg    = (aMin.totalDamage*(1+aMin.bonusDamagePercent))
        if aaData.target == eMin.handle then
            local endT    = aaData.endTime
            local animT   = aaData.animationTime
            local windUpT = aaData.windUpTime
            local pSpeed  = aaData.projectileSpeed
            local pFlyT   = pSpeed > 0 and gsoAIO.Utils:_getDistance(aMin.pos, eMin.pos) / pSpeed or 0
            local pStartT = endT - animT
            local pEndT   = pStartT + pFlyT + windUpT
            local checkT  = Game.Timer()
            pEndT         = pEndT > checkT and pEndT or pEndT + animT + pFlyT
            while pEndT - checkT < time do
                result = result + aDmg
                pEndT = pEndT + animT + pFlyT
            end
        end
    end
    return result
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoFarm:_setEnemyMinions()
    for i=1, #self.lastHit do self.lastHit[i]=nil end
    for i=1, #self.almostLH do self.almostLH[i]=nil end
    for i=1, #self.laneClear do self.laneClear[i]=nil end
    local mLH = gsoAIO.Load.menu.orb.delays.lhDelay:Value()*0.001
    for i = 1, #gsoAIO.OB.enemyMinions do
        local eMinion = gsoAIO.OB.enemyMinions[i]
        local eMinion_handle	= eMinion.handle
        local distance = gsoAIO.Utils:_getDistance(myHero.pos, eMinion.pos)
        if distance < myHero.range + myHero.boundingRadius + eMinion.boundingRadius then
            local eMinion_health	= eMinion.health
            local myHero_aaData		= myHero.attackData
            local myHero_pFlyTime	= myHero_aaData.windUpTime + (distance / myHero_aaData.projectileSpeed) + 0.125 + mLH
            for k1,v1 in pairs(self.aAttacks) do
                for k2,v2 in pairs(self.aAttacks[k1]) do
                    if v2.canceled == false and eMinion_handle == v2.to.handle then
                        local checkT	= Game.Timer()
                        local pEndTime	= v2.startTime + v2.pTime
                        if pEndTime > checkT and  pEndTime - checkT < myHero_pFlyTime - mLH then
                            eMinion_health = eMinion_health - v2.dmg
                        end
                    end
                end
            end
            local myHero_dmg = self.aaDmg + gsoAIO.Vars._bonusDmgUnit(eMinion)
            if eMinion_health - myHero_dmg < 0 then
                self.lastHit[#self.lastHit+1] = { eMinion, eMinion_health }
            else
                if eMinion.health - self:_possibleDmg(eMinion, myHero.attackData.animationTime*3) - myHero_dmg < 0 then
                    self.shouldWait = true
                    self.shouldWaitT = Game.Timer()
                    self.almostLH[#self.almostLH+1] = eMinion
                else
                    self.laneClear[#self.laneClear+1] = eMinion
                end
            end
        end
    end
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoFarm:_setActiveAA()
    for i = 1, #gsoAIO.OB.allyMinions do
        local aMinion = gsoAIO.OB.allyMinions[i]
        local aHandle	= aMinion.handle
        local aAAData	= aMinion.attackData
        if aAAData.endTime > Game.Timer() then
            for i = 1, #gsoAIO.OB.enemyMinions do
                local eMinion = gsoAIO.OB.enemyMinions[i]
                local eHandle	= eMinion.handle
                if eHandle == aAAData.target then
                    local checkT		= Game.Timer()
                    -- p -> projectile
                    local pSpeed  = aAAData.projectileSpeed
                    local aMPos   = aMinion.pos
                    local eMPos   = eMinion.pos
                    local pFlyT		= pSpeed > 0 and gsoAIO.Utils:_getDistance(aMPos, eMPos) / pSpeed or 0
                    local pStartT	= aAAData.endTime - aAAData.windDownTime
                    if not self.aAttacks[aHandle] then
                      self.aAttacks[aHandle] = {}
                    end
                    local aaID = aAAData.endTime
                    if checkT < pStartT + pFlyT then
                        if pSpeed > 0 then
                            if checkT > pStartT then
                                if not self.aAttacks[aHandle][aaID] then
                                    self.aAttacks[aHandle][aaID] = {
                                        canceled  = false,
                                        speed     = pSpeed,
                                        startTime = pStartT,
                                        pTime     = pFlyT,
                                        pos       = aMPos:Extended(eMPos, pSpeed*(checkT-pStartT)),
                                        from      = aMinion,
                                        fromPos   = aMPos,
                                        to        = eMinion,
                                        dmg       = (aMinion.totalDamage*(1+aMinion.bonusDamagePercent))-eMinion.flatDamageReduction
                                    }
                                end
                            elseif aMinion.pathing.hasMovePath == true then
                              --print("attack canceled")
                              self.aAttacks[aHandle][aaID] = {
                                  canceled  = true,
                                  from      = aMinion
                              }
                            end
                          elseif not self.aAttacks[aHandle][aaID] then
                              self.aAttacks[aHandle][aaID] = {
                                  canceled  = false,
                                  speed     = pSpeed,
                                  startTime = pStartT - aAAData.windUpTime,
                                  pTime     = aAAData.windUpTime,
                                  pos       = aMPos,
                                  from      = aMinion,
                                  fromPos   = aMPos,
                                  to        = eMinion,
                                  dmg       = (aMinion.totalDamage*(1+aMinion.bonusDamagePercent))-eMinion.flatDamageReduction
                              }
                          end
                    end
                    break
                end
            end
        end
    end
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoFarm:_handleActiveAA()
    local aAttacks2 = self.aAttacks
    for k1,v1 in pairs(aAttacks2) do
        local count		= 0
        local checkT	= Game.Timer()
        for k2,v2 in pairs(aAttacks2[k1]) do
            count = count + 1
            if v2.speed == 0 and (not v2.from or v2.from.dead) then
                --print("dead")
                self.aAttacks[k1] = nil
                break
            end
            if v2.canceled == false then
                local ranged = v2.speed > 0
                if ranged == true then
                    self.aAttacks[k1][k2].pTime = gsoAIO.Utils:_getDistance(v2.fromPos, self:_predPos(v2.speed, v2.pos, v2.to)) / v2.speed
                end
                if checkT > v2.startTime + self.aAttacks[k1][k2].pTime - (Game.Latency()*0.0015) - 0.034 or not v2.to or v2.to.dead then
                    self.aAttacks[k1][k2] = nil
                elseif ranged == true then
                    self.aAttacks[k1][k2].pos = v2.fromPos:Extended(v2.to.pos, (checkT-v2.startTime)*v2.speed)
                end
            end
        end
        if count == 0 then
            --print("no active attacks")
            self.aAttacks[k1] = nil
        end
    end
end





-- http://gamingonsteroids.com/user/198940-trus/
--------------------|---------------------------------------------------------|--------------------
--------------------|---------------------------------------------------------|--------------------
--------------------|---------------------------------------------------------|--------------------
--------------------|---------------------------------------------------------|--------------------
--------------------|-----------------TRUS PREDICTION-------------------------|--------------------
--------------------|---------------------------------------------------------|--------------------
--------------------|---------------------------------------------------------|--------------------
--------------------|---------------------------------------------------------|--------------------
--------------------|---------------------------------------------------------|--------------------
class "__gsoTPred"

--------------------|---------------------------------------------------------|--------------------
--------------------|--------------------------init---------------------------|--------------------
--------------------|---------------------------------------------------------|--------------------
function __gsoTPred:CutWaypoints(Waypoints, distance, unit)
    local result = {}
    local remaining = distance
    if distance > 0 then
        for i = 1, #Waypoints -1 do
            local A, B = Waypoints[i], Waypoints[i + 1]
            if A and B then 
                local dist = self:GetDistance(A, B)
                if dist >= remaining then
                    result[1] = Vector(A) + remaining * (Vector(B) - Vector(A)):Normalized()

                    for j = i + 1, #Waypoints do
                        result[j - i + 1] = Waypoints[j]
                    end
                    remaining = 0
                    break
                else
                    remaining = remaining - dist
                end
            end
        end
    else
        local A, B = Waypoints[1], Waypoints[2]
        result = Waypoints
        result[1] = Vector(A) - distance * (Vector(B) - Vector(A)):Normalized()
    end
    return result
end
function __gsoTPred:VectorMovementCollision(startPoint1, endPoint1, v1, startPoint2, v2, delay)
    local sP1x, sP1y, eP1x, eP1y, sP2x, sP2y = startPoint1.x, startPoint1.z, endPoint1.x, endPoint1.z, startPoint2.x, startPoint2.z
    local d, e = eP1x-sP1x, eP1y-sP1y
    local dist, t1, t2 = mathSqrt(d*d+e*e), nil, nil
    local S, K = dist~=0 and v1*d/dist or 0, dist~=0 and v1*e/dist or 0
    local function GetCollisionPoint(t) return t and {x = sP1x+S*t, y = sP1y+K*t} or nil end
    if delay and delay~=0 then sP1x, sP1y = sP1x+S*delay, sP1y+K*delay end
    local r, j = sP2x-sP1x, sP2y-sP1y
    local c = r*r+j*j
    if dist>0 then
        if v1 == math.huge then
            local t = dist/v1
            t1 = v2*t>=0 and t or nil
        elseif v2 == math.huge then
            t1 = 0
        else
            local a, b = S*S+K*K-v2*v2, -r*S-j*K
            if a==0 then 
                if b==0 then --c=0->t variable
                    t1 = c==0 and 0 or nil
                else --2*b*t+c=0
                    local t = -c/(2*b)
                    t1 = v2*t>=0 and t or nil
                end
            else --a*t*t+2*b*t+c=0
                local sqr = b*b-a*c
                if sqr>=0 then
                    local nom = mathSqrt(sqr)
                    local t = (-nom-b)/a
                    t1 = v2*t>=0 and t or nil
                    t = (nom-b)/a
                    t2 = v2*t>=0 and t or nil
                end
            end
        end
    elseif dist==0 then
        t1 = 0
    end
    return t1, GetCollisionPoint(t1), t2, GetCollisionPoint(t2), dist
end
function __gsoTPred:GetCurrentWayPoints(object)
    local result = {}
    local objectPos = object.pos
    if object.pathing.hasMovePath then
        local objectPath = object.pathing
        table.insert(result, Vector(objectPos.x,objectPos.y, objectPos.z))
        for i = objectPath.pathIndex, objectPath.pathCount do
            path = object:GetPath(i)
            table.insert(result, Vector(path.x, path.y, path.z))
        end
    else
        table.insert(result, object and Vector(objectPos.x,objectPos.y, objectPos.z) or Vector(objectPos.x,objectPos.y, objectPos.z))
    end
    return result
end
function __gsoTPred:GetDistanceSqr(p1, p2)
    if not p1 or not p2 then return 999999999 end
    return (p1.x - p2.x) ^ 2 + ((p1.z or p1.y) - (p2.z or p2.y)) ^ 2
end
function __gsoTPred:GetDistance(p1, p2)
    return mathSqrt(self:GetDistanceSqr(p1, p2))
end
function __gsoTPred:GetWaypointsLength(Waypoints)
    local result = 0
    for i = 1, #Waypoints -1 do
        result = result + self:GetDistance(Waypoints[i], Waypoints[i + 1])
    end
    return result
end
function __gsoTPred:CanMove(unit, delay)
    for i = 0, unit.buffCount do
        local buff = unit:GetBuff(i);
        if buff and buff.count > 0 and buff.duration>=delay then
            if (buff.type == 5 or buff.type == 8 or buff.type == 21 or buff.type == 22 or buff.type == 24 or buff.type == 11) then
                return false -- block everything
            end
        end
    end
    return true
end
function __gsoTPred:IsImmobile(unit, delay, radius, speed, from, spelltype)
    local unitPos = unit.pos
    local ExtraDelay = speed == math.huge and 0 or from and unit and unitPos and (self:GetDistance(from, unitPos) / speed)
    if (self:CanMove(unit, delay + ExtraDelay) == false) then
        return true
    end
    return false
end
function __gsoTPred:CalculateTargetPosition(unit, delay, radius, speed, from, spelltype)
    local Waypoints = {}
    local unitPos = unit.pos
    local Position, CastPosition = Vector(unitPos), Vector(unitPos)
    local t
    Waypoints = self:GetCurrentWayPoints(unit)
    local Waypointslength = self:GetWaypointsLength(Waypoints)
    local movementspeed = unit.pathing.isDashing and unit.pathing.dashSpeed or unit.ms
    if #Waypoints == 1 then
        Position, CastPosition = Vector(Waypoints[1].x, Waypoints[1].y, Waypoints[1].z), Vector(Waypoints[1].x, Waypoints[1].y, Waypoints[1].z)
        return Position, CastPosition
    elseif (Waypointslength - delay * movementspeed + radius) >= 0 then
        local tA = 0
        Waypoints = self:CutWaypoints(Waypoints, delay * movementspeed - radius)
        if speed ~= math.huge then
            for i = 1, #Waypoints - 1 do
                local A, B = Waypoints[i], Waypoints[i+1]
                if i == #Waypoints - 1 then
                    B = Vector(B) + radius * Vector(B - A):Normalized()
                end

                local t1, p1, t2, p2, D = self:VectorMovementCollision(A, B, movementspeed, Vector(from.x,from.y,from.z), speed)
                local tB = tA + D / movementspeed
                t1, t2 = (t1 and tA <= t1 and t1 <= (tB - tA)) and t1 or nil, (t2 and tA <= t2 and t2 <= (tB - tA)) and t2 or nil
                t = t1 and t2 and math.min(t1, t2) or t1 or t2
                if t then
                    CastPosition = t==t1 and Vector(p1.x, 0, p1.y) or Vector(p2.x, 0, p2.y)
                    break
                end
                tA = tB
            end
        else
            t = 0
            CastPosition = Vector(Waypoints[1].x, Waypoints[1].y, Waypoints[1].z)
        end
        if t then
            if (self:GetWaypointsLength(Waypoints) - t * movementspeed - radius) >= 0 then
                Waypoints = self:CutWaypoints(Waypoints, radius + t * movementspeed)
                Position = Vector(Waypoints[1].x, Waypoints[1].y, Waypoints[1].z)
            else
                Position = CastPosition
            end
        elseif unit.type ~= myHero.type then
            CastPosition = Vector(Waypoints[#Waypoints].x, Waypoints[#Waypoints].y, Waypoints[#Waypoints].z)
            Position = CastPosition
        end
    elseif unit.type ~= myHero.type then
        CastPosition = Vector(Waypoints[#Waypoints].x, Waypoints[#Waypoints].y, Waypoints[#Waypoints].z)
        Position = CastPosition
    end
    return Position, CastPosition
end
function __gsoTPred:VectorPointProjectionOnLineSegment(v1, v2, v)
    local cx, cy, ax, ay, bx, by = v.x, (v.z or v.y), v1.x, (v1.z or v1.y), v2.x, (v2.z or v2.y)
    local rL = ((cx - ax) * (bx - ax) + (cy - ay) * (by - ay)) / ((bx - ax) ^ 2 + (by - ay) ^ 2)
    local pointLine = { x = ax + rL * (bx - ax), y = ay + rL * (by - ay) }
    local rS = rL < 0 and 0 or (rL > 1 and 1 or rL)
    local isOnSegment = rS == rL
    local pointSegment = isOnSegment and pointLine or { x = ax + rS * (bx - ax), y = ay + rS * (by - ay) }
    return pointSegment, pointLine, isOnSegment
end
function __gsoTPred:CheckCol(unit, minion, Position, delay, radius, range, speed, from, draw)
    if unit.networkID == minion.networkID then 
        return false
    end
    local waypoints = self:GetCurrentWayPoints(minion)
    local minionPos = minion.pos
    local MPos, CastPosition = #waypoints == 1 and Vector(minionPos) or self:CalculateTargetPosition(minion, delay, radius, speed, from, "line")
    if from and MPos and self:GetDistanceSqr(from, MPos) <= (range)^2 and self:GetDistanceSqr(from, minionPos) <= (range + 100)^2 then
        local buffer = (#waypoints > 1) and 8 or 0 
        if minion.type == myHero.type then
            buffer = buffer + minion.boundingRadius
        end
        if #waypoints > 1 then
            local proj1, pointLine, isOnSegment = self:VectorPointProjectionOnLineSegment(from, Position, Vector(MPos))
            if proj1 and isOnSegment and (self:GetDistanceSqr(MPos, proj1) <= (minion.boundingRadius + radius + buffer) ^ 2) then
                return true
            end
        end
        local proj2, pointLine, isOnSegment = self:VectorPointProjectionOnLineSegment(from, Position, Vector(minionPos))
        if proj2 and isOnSegment and (self:GetDistanceSqr(minionPos, proj2) <= (minion.boundingRadius + radius + buffer) ^ 2) then
            return true
        end
    end
end
function __gsoTPred:CheckMinionCollision(unit, Position, delay, radius, range, speed, from)
    Position = Vector(Position)
    from = from and Vector(from) or myHero.pos
    for i = 1, #gsoAIO.OB.enemyMinions do
        local minion = gsoAIO.OB.enemyMinions[i]
        if minion and not minion.dead and minion.isTargetable and minion.visible and minion.valid and self:CheckCol(unit, minion, Position, delay, radius, range, speed, from, draw) then
            return true
        end
    end
    return false
end
function __gsoTPred:isSlowed(unit, delay, speed, from)
    for i = 0, unit.buffCount do
        local buff = unit:GetBuff(i);
        if buff and from and buff.count > 0 and buff.duration>=(delay + self:GetDistance(unit.pos, from) / speed) then
            if (buff.type == 10) then
                return true
            end
        end
    end
    return false
end
function __gsoTPred:GetBestCastPosition(unit, delay, radius, range, speed, from, collision, spelltype)
    range = range and range - 4 or math.huge
    radius = radius == 0 and 1 or radius - 4
    speed = speed and speed or math.huge
    local mePos = myHero.pos
    local hePos = unit.pos
    if not from then
        from = Vector(mePos)
    end
    local IsFromMyHero = self:GetDistanceSqr(from, mePos) < 50*50 and true or false
    delay = delay + (0.07 + Game.Latency() / 2000)
    local Position, CastPosition = self:CalculateTargetPosition(unit, delay, radius, speed, from, spelltype)
    local HitChance = 1
    if (self:IsImmobile(unit, delay, radius, speed, from, spelltype)) then
        HitChance = 5
    end
    Waypoints = self:GetCurrentWayPoints(unit)
    if (#Waypoints == 1) then
        HitChance = 2
    end
    if self:isSlowed(unit, delay, speed, from) then
        HitChance = 2
    end
    if (unit.activeSpell and unit.activeSpell.valid) then
        HitChance = 2
    end
    if self:GetDistance(mePos, hePos) < 250 then
        HitChance = 2
        Position, CastPosition = self:CalculateTargetPosition(unit, delay*0.5, radius, speed*2, from, spelltype)
        Position = CastPosition
    end
    local angletemp = Vector(from):AngleBetween(Vector(hePos), Vector(CastPosition))
    if angletemp > 60 then
        HitChance = 1
    elseif angletemp < 30 then
        HitChance = 2
    end
    --[[Out of range]]
    if IsFromMyHero then
        if (spelltype == "line" and self:GetDistanceSqr(from, Position) >= range * range) then
            HitChance = 0
        end
        if (spelltype == "circular" and (self:GetDistanceSqr(from, Position) >= (range + radius)*(range + radius))) then
            HitChance = 0
        end
        if from and Position and (self:GetDistanceSqr(from, Position) > range * range) then
            HitChance = 0
        end
    end
    radius = radius*2
    if collision and HitChance > 0 then
        if collision and self:CheckMinionCollision(unit, hePos, delay, radius, range, speed, from) then
            HitChance = -1
        elseif self:CheckMinionCollision(unit, Position, delay, radius, range, speed, from) then
            HitChance = -1
        elseif self:CheckMinionCollision(unit, CastPosition, delay, radius, range, speed, from) then
            HitChance = -1
        end
    end
    if not CastPosition or not Position then
        HitChance = -1
    end
    return CastPosition, HitChance, Position
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
class "__gsoOrb"
--
--
--
function __gsoOrb:__init()
    
    --[[ move if stop holding orb key ]]
    self.lastKey      = 0
    self.loaded       = false
    
    --[[ orbwalker ]]
    self.canMove      = true
    self.canAA        = true
    self.aaReset      = false
    self.lAttack      = 0
    self.lMove        = 0
    self.lMovePath    = mousePos
    self.setCursor    = nil
    
    --[[ delayed actions ]]
    self.dActionsC    = 0
    self.dActions     = {}
    
    --[[ local aa data ]]
    self.baseAASpeed  = 0
    self.baseWindUp   = 0
    self.windUpT      = 0
    self.animT        = 0
    
    --[[ server aa data ]]
    self.serverStart = 0
    self.serverWindup = 0
    self.serverAnim = 0
    
    --[[ callbacks ]]
    gsoAIO.Vars:_setDraw(function() self:_draw() end)
    Callback.Add('Tick', function() self:_tick() end)
    Callback.Add('WndMsg', function(msg, wParam) self:_onWndMsg(msg, wParam) end)
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoOrb:_onWndMsg(msg, wParam)
    if wParam == HK_TCO then
        self.lAttack = Game.Timer()
    end
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoOrb:_orb(unit)
    
    local aaSpeed = gsoAIO.Vars._aaSpeed() * self.baseAASpeed
    local numAS   = aaSpeed >= 2.5 and 2.5 or aaSpeed
    local animT   = 1 / numAS
    local windUpT = animT * self.baseWindUp
    self.serverAnim = aaSpeed >= 2.5 and animT or self.serverAnim
    self.serverWindup = aaSpeed >= 2.5 and windUpT or self.serverWindup
    local extraWindUp = math.abs(windUpT-self.serverWindup) + (gsoAIO.Load.menu.orb.delays.windup:Value() * 0.001)
    local windUpAA = windUpT > self.serverWindup and self.serverWindup or windUpT
    self.windUpT = windUpT > self.serverWindup and windUpT or self.serverWindup
    self.animT = animT > self.serverAnim and animT or self.serverAnim
    if gsoAIO.Vars.meTristana then
        local hasQBuff = GetTickCount() - gsoAIO.Spells.lastQ < 1000 and gsoAIO.Utils:_hasBuff(myHero, "tristanaq")
        self.animT = hasQBuff and animT or self.animT
    end
    if gsoAIO.Vars.meSivir then
        local hasWBuff = GetTickCount() - gsoAIO.Spells.lastW < 1000 and gsoAIO.Utils:_hasBuff(myHero, "sivirwmarker")
        self.animT = hasWBuff and animT or self.animT
    end
    if gsoAIO.Vars.meTwitch then
        local hasQBuff = GetTickCount() - gsoAIO.Spells.lastQ < 3000 and gsoAIO.Utils:_hasBuff(myHero, "twitchhideinshadowsbuff")
        self.animT = hasQBuff and animT or self.animT
    end
    if gsoAIO.Vars.meAshe then
        local hasQBuff = GetTickCount() - gsoAIO.Spells.lastQ < 1000 and gsoAIO.Utils:_hasBuff(myHero, "asheqattack")
        self.animT = hasQBuff and animT or self.animT
    end
    if gsoAIO.Vars.meJinx then
        self.animT = animT
    end
    
    local unitValid = unit and not unit.dead and unit.isTargetable and unit.visible and unit.valid
    if unitValid and unit.type == Obj_AI_Hero then
        unitValid = gsoAIO.Utils:_isImmortal(unit, true) == false
    end
    local meExtended = unitValid and myHero.pos:Extended(self.lMovePath, (0.15+(gsoAIO.Utils.maxPing*1.5)) * myHero.ms) or nil
    local dist1 = unitValid and gsoAIO.Utils:_getDistance(myHero.pos, unit.pos) or 0
    local dist2 = unitValid and gsoAIO.Utils:_getDistance(meExtended, unit.pos) or 0
    local dist3 = dist2 > dist1 and dist2 or dist1
    local inAARange = unitValid and dist3 < myHero.range + myHero.boundingRadius + unit.boundingRadius
    if not unitValid or not inAARange then
        unit = nil
    end
    
    local canOrb  = self.dActionsC == 0
    self.canAA    = canOrb and gsoAIO.Vars._canAttack(unit) and not gsoAIO.TS.isBlinded
    self.canAA    = self.canAA and Game.Timer() > self.lAttack + self.windUpT and (self.aaReset or Game.Timer() > self.serverStart - windUpAA + self.animT - gsoAIO.Utils.minPing - 0.05 )
    self.canMove  = canOrb and gsoAIO.Vars._canMove()
    self.canMove  = self.canMove and Game.Timer() > self.lAttack + self.windUpT and Game.Timer() > self.serverStart + extraWindUp - (gsoAIO.Utils.minPing*0.5)
    
    if unit ~= nil and self.canAA then
        self:_attack(unit)
    elseif self.canMove then
        if unitValid and Game.Timer() > self.lAttack + ( gsoAIO.Orb.animT * 0.5 ) and Game.Timer() < self.lAttack + ( gsoAIO.Orb.animT * 0.8 ) and gsoAIO.Items:_botrk(unit) then
            return
        end
        if Game.Timer() > self.lMove + (gsoAIO.Load.menu.orb.delays.humanizer:Value()*0.001) and GetTickCount() > gsoAIO.Items.lastBotrk + 100 then
            self:_move()
        end
    end
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoOrb:_tick()

--  DISABLE IF LOAD :
    if not self.loaded and GetTickCount() < gsoAIO.Load.loadTime + 1250 then
        return
    elseif not self.loaded then
        self.loaded = true
    end

--  SET CURSOR POS :
    if self.setCursor then
        Control.SetCursorPos(self.setCursor)
    end

--  DISABLE IN EVADING TIME :
    if ExtLibEvade and ExtLibEvade.Evading then return end

--  OBJECT TICK :
    gsoAIO.OB:_tick()

--  FARM TICK :
    gsoAIO.Farm:_tick()

--  CHAMPIONS TICK :
    gsoAIO.Vars._onTick()

--  HANDLE DELAYED ACTIONS :
    local dActions = self.dActions
    local cDActions = 0
    for k,v in pairs(dActions) do
        cDActions = cDActions + 1
        if not v[3] and GetTickCount() - k > v[2] then
            v[1]()
            v[3] = true
            self.setCursor = nil
        elseif v[3] and GetTickCount() - k > v[2] + 25 then
            self.dActions[k] = nil
        end
    end
    self.dActionsC = cDActions

--  GET SERVER AA DATA :
    local aSpell = myHero.activeSpell
    local aSpellName = aSpell.name:lower()
    if not gsoAIO.Utils.noAttacks[aSpellName] and (aSpellName:find("attack") or gsoAIO.Utils.attacks[aSpellName]) and aSpell.startTime > self.serverStart then
        self.serverStart = aSpell.startTime
        self.serverWindup = aSpell.windup
        self.serverAnim = aSpell.animation
    end

--  EXECUTE MODES :
    local ck  = gsoAIO.Load.menu.orb.keys.combo:Value()
    local hk  = gsoAIO.Load.menu.orb.keys.harass:Value()
    local lhk = gsoAIO.Load.menu.orb.keys.lastHit:Value()
    local lck = gsoAIO.Load.menu.orb.keys.laneClear:Value()
    if Game.IsChatOpen() == false and (ck or hk or lhk or lck) then
        local AAtarget = nil
        if ck then
            AAtarget = gsoAIO.TS:_comboT()
        elseif hk then
            AAtarget = gsoAIO.TS:_harassT()
        elseif lhk then
            AAtarget = gsoAIO.TS:_lastHitT()
        elseif lck then
            AAtarget = gsoAIO.TS:_laneClearT()
        end
        if ExtLibEvade then
            if not ExtLibEvade.Evading then
                self:_orb(AAtarget)
            end
        else
            self:_orb(AAtarget)
        end
    elseif self.dActionsC == 0 and GetTickCount() < self.lastKey + 1000 then
        Control.mouse_event(MOUSEEVENTF_RIGHTDOWN)
        self.lastKey = 0
    end
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoOrb:_attack(unit)
    if ExtLibEvade and ExtLibEvade.Evading then return end
    self.aaReset = false
    self.lMove = 0
    local cPos = cursorPos
    local unitPos = unit.pos
    Control.SetCursorPos(unitPos)
    self.setCursor = unitPos
    Control.KeyDown(HK_TCO)
    Control.mouse_event(MOUSEEVENTF_RIGHTDOWN)
    Control.mouse_event(MOUSEEVENTF_RIGHTUP)
    Control.KeyUp(HK_TCO)
    self.dActions[GetTickCount()] = { function() Control.SetCursorPos(cPos.x, cPos.y) end, 50 }
    self.dActionsC = self.dActionsC + 1
    if gsoAIO.Vars.meTristana and gsoAIO.Vars.tristanaETar and gsoAIO.Vars.tristanaETar.id == unit.networkID then
        gsoAIO.Vars.tristanaETar.stacks = gsoAIO.Vars.tristanaETar.stacks + 1
        if gsoAIO.Vars.tristanaETar.stacks == 5 then
            gsoAIO.Utils.delayedActions[#gsoAIO.Utils.delayedActions+1] = { func = function() gsoAIO.Vars.tristanaETar = nil end, endTime = Game.Timer() + self.windUpT + (gsoAIO.Utils:_getDistance(myHero.pos, unit.pos) / 2000) }
        end
    end
    if gsoAIO.Vars.meSivir then
        if not gsoAIO.Vars.sivirCanW then gsoAIO.Vars.sivirCanW = true end
        if not gsoAIO.Vars.sivirCanQ then gsoAIO.Vars.sivirCanQ = true end
    end
    if gsoAIO.Vars.meVayne then
        if not gsoAIO.Vars.vayneCanQ then gsoAIO.Vars.vayneCanQ = true end
        if not gsoAIO.Vars.vayneCanE then gsoAIO.Vars.vayneCanE = true end
    end
    if gsoAIO.Vars.meKog then
        if not gsoAIO.Vars.kogCanQ then gsoAIO.Vars.kogCanQ = true end
        if not gsoAIO.Vars.kogCanE then gsoAIO.Vars.kogCanE = true end
        if not gsoAIO.Vars.kogCanR then gsoAIO.Vars.kogCanR = true end
    end
    if gsoAIO.Vars.meTwitch then
        if not gsoAIO.Vars.twitchCanW then gsoAIO.Vars.twitchCanW = true end
        if not gsoAIO.Vars.twitchCanE then gsoAIO.Vars.twitchCanE = true end
    end
    if gsoAIO.Vars.meAshe then
        if not gsoAIO.Vars.asheCanW then gsoAIO.Vars.asheCanW = true end
        if not gsoAIO.Vars.asheCanR then gsoAIO.Vars.asheCanR = true end
    end
    if gsoAIO.Vars.meEzreal then
        if not gsoAIO.Vars.ezrealCanQ then gsoAIO.Vars.ezrealCanQ = true end
        if not gsoAIO.Vars.ezrealCanW then gsoAIO.Vars.ezrealCanW = true end
    end
    if gsoAIO.Vars.meDraven then
        if not gsoAIO.Vars.dravenCanW then gsoAIO.Vars.dravenCanW = true end
        if not gsoAIO.Vars.dravenCanE then gsoAIO.Vars.dravenCanE = true end
        if not gsoAIO.Vars.dravenCanR then gsoAIO.Vars.dravenCanR = true end
    end
    self.lAttack = Game.Timer()
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoOrb:_move()
    local mPos = gsoAIO.Vars._mousePos()
    if mPos ~= nil then
        if ExtLibEvade and ExtLibEvade.Evading then return end
        if Control.IsKeyDown(2) then self.lastKey = GetTickCount() end
        local cPos = cursorPos
        Control.SetCursorPos(mPos)
        self.setCursor = mPos
        self.lMovePath = mPos
        Control.mouse_event(MOUSEEVENTF_RIGHTDOWN)
        Control.mouse_event(MOUSEEVENTF_RIGHTUP)
        self.dActions[GetTickCount()] = { function() Control.SetCursorPos(cPos.x, cPos.y) end, 50 }
        self.dActionsC = self.dActionsC + 1
        self.lMove = Game.Timer()
    else
        if ExtLibEvade and ExtLibEvade.Evading then return end
        if Control.IsKeyDown(2) then self.lastKey = GetTickCount() end
        self.lMovePath = mousePos
        Control.mouse_event(MOUSEEVENTF_RIGHTDOWN)
        Control.mouse_event(MOUSEEVENTF_RIGHTUP)
        self.lMove = Game.Timer()
    end
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoOrb:_draw()
    local mePos = myHero.pos
    local meBB = myHero.boundingRadius
    if gsoAIO.Load.menu.gsodraw.circle1.merange:Value() and mePos:ToScreen().onScreen then
        Draw.Circle(mePos, myHero.range + meBB + 75, gsoAIO.Load.menu.gsodraw.circle1.mewidth:Value(), gsoAIO.Load.menu.gsodraw.circle1.mecolor:Value())
    end
    if gsoAIO.Load.menu.gsodraw.circle1.herange:Value() then
        local countEH = #gsoAIO.OB.enemyHeroes
        for i = 1, countEH do
            local hero = gsoAIO.OB.enemyHeroes[i]
            local heroPos = hero.pos
            if gsoAIO.Utils:_getDistance(mePos, heroPos) < 2000 and heroPos:ToScreen().onScreen then
                Draw.Circle(heroPos, hero.range + hero.boundingRadius + meBB, gsoAIO.Load.menu.gsodraw.circle1.hewidth:Value(), gsoAIO.Load.menu.gsodraw.circle1.hecolor:Value())
            end
        end
    end
    if gsoAIO.Load.menu.gsodraw.circle1.cpos:Value() then
        Draw.Circle(mousePos, gsoAIO.Load.menu.gsodraw.circle1.cposradius:Value(), gsoAIO.Load.menu.gsodraw.circle1.cposwidth:Value(), gsoAIO.Load.menu.gsodraw.circle1.cposcolor:Value())
    end
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
class "__gsoAshe"
function __gsoAshe:__init()
    self.lastQ = 0
    self.lastW = 0
    self.lastR = 0
    self.QEndTime = 0
    self.hasQBuff = false
    self.asNoQ = myHero.attackSpeed
    gsoAIO.Orb.baseAASpeed = 0.658
    gsoAIO.Orb.baseWindUp = 0.2192982
    gsoAIO.Vars.drawRanges = { w = true, wrange = 1200 }
    gsoAIO.Mana.spellData = { q = true, qm = 50, w = true, wm = 50, r = true, rm = 100 }
    gsoAIO.Mana.priority = { [_R] = 1, [_Q] = 2, [_W] = 3 }
    gsoAIO.Vars:_setChampMenu(function() return self:_menu() end)
    gsoAIO.Vars:_setAASpeed(function() return self:_aaSpeed() end)
    gsoAIO.Vars:_setCanMove(function() return self:_canMove() end)
    gsoAIO.Vars:_setCanAttack(function(target) return self:_canAttack(target) end)
    gsoAIO.Vars:_setOnTick(function() self:_tick() end)
    gsoAIO.Vars:_setBonusDmgUnit(function(unit) return self:_dmgUnit(unit) end)
    gsoAIO.Vars:_setBonusDmg(function() return 3 end)
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoAshe:_menu()
    gsoAIO.Load.menu:MenuElement({id = "gsoashe", name = "Ashe", type = MENU, leftIcon = gsoAIO.Vars.Icons["ashe"] })
        gsoAIO.Load.menu.gsoashe:MenuElement({id = "rdist", name = "use R if enemy distance < X", value = 500, min = 250, max = 1000, step = 50})
        gsoAIO.Load.menu.gsoashe:MenuElement({id = "combo", name = "Combo", type = MENU})
            gsoAIO.Load.menu.gsoashe.combo:MenuElement({id = "qc", name = "UseQ", value = true})
            gsoAIO.Load.menu.gsoashe.combo:MenuElement({id = "wc", name = "UseW", value = true})
            gsoAIO.Load.menu.gsoashe.combo:MenuElement({id = "rcd", name = "UseR [enemy distance < X", value = true})
            gsoAIO.Load.menu.gsoashe.combo:MenuElement({id = "rci", name = "UseR [enemy IsImmobile]", value = true})
        gsoAIO.Load.menu.gsoashe:MenuElement({id = "harass", name = "Harass", type = MENU})
            gsoAIO.Load.menu.gsoashe.harass:MenuElement({id = "qh", name = "UseQ", value = true})
            gsoAIO.Load.menu.gsoashe.harass:MenuElement({id = "wh", name = "UseW", value = true})
            gsoAIO.Load.menu.gsoashe.harass:MenuElement({id = "rhd", name = "UseR [enemy distance < X]", value = false})
            gsoAIO.Load.menu.gsoashe.harass:MenuElement({id = "rhi", name = "UseR [enemy IsImmobile]", value = false})
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoAshe:_aaSpeed()
    local num1 = self.QEndTime - GetTickCount() - (gsoAIO.Utils.maxPing*1000)
    if num1 > -1500 and num1 < 0 then
        return self.asNoQ
    end
    return myHero.attackSpeed
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoAshe:_canMove()
    local getTick = GetTickCount() - (gsoAIO.Utils.maxPing*1000)
    local wMinus = getTick - self.lastW
    local wMinuss = getTick - gsoAIO.Spells.lastW
    local rMinus = getTick - self.lastR
    local rMinuss = getTick - gsoAIO.Spells.lastR
    if wMinus > 250 and wMinuss > 250 and rMinus > 250 and rMinuss > 250 then
        return true
    end
    return false
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoAshe:_canAttack(target)
    local isTarget = target and target.type == Obj_AI_Hero
    local getTick = GetTickCount()
    local qMinus = getTick - self.lastQ
    local qMinuss = getTick - gsoAIO.Spells.lastQ
    local wMinus = getTick - self.lastW
    local wMinuss = getTick - gsoAIO.Spells.lastW
    local rMinus = getTick - self.lastR
    local rMinuss = getTick - gsoAIO.Spells.lastR
    if Game.Timer() > gsoAIO.Orb.lAttack + gsoAIO.Orb.windUpT + 0.1 + gsoAIO.Utils.maxPing then
        local isCombo = gsoAIO.Load.menu.orb.keys.combo:Value()
        local isHarass = gsoAIO.Load.menu.orb.keys.harass:Value()
        local afterAttack = Game.Timer() < gsoAIO.Orb.lAttack + ( gsoAIO.Orb.animT * 0.85 )
        if not isTarget or afterAttack then
            
            -- USE R :
            local canRTime = wMinus > 350 and wMinuss > 350 and rMinus > 1000 and rMinuss > 1000
            local isComboRd = isCombo and gsoAIO.Load.menu.gsoashe.combo.rcd:Value()
            local isHarassRd = isHarass and gsoAIO.Load.menu.gsoashe.harass.rhd:Value()
            local isComboRi = isCombo and gsoAIO.Load.menu.gsoashe.combo.rci:Value()
            local isHarassRi = isHarass and gsoAIO.Load.menu.gsoashe.harass.rhi:Value()
            local isRdReady = (isComboRd or isHarassRd)
            local isRiReady = (isComboRi or isHarassRi)
            if (isRdReady or isRiReady) and canRTime == true and gsoAIO.Utils:_isReady(_R) == true and ( not isTarget or (isTarget and gsoAIO.Vars.asheCanR) ) then
                local mePos = myHero.pos
                local canRonTarget = false
                local rPos = nil
                if isRdReady then
                    local t = nil
                    local menuDist = gsoAIO.Load.menu.gsoashe.rdist:Value()
                    for i = 1, #gsoAIO.OB.enemyHeroes do
                        local hero = gsoAIO.OB.enemyHeroes[i]
                        local distance = gsoAIO.Utils:_getDistance(mePos, hero.pos)
                        if gsoAIO.Utils:_valid(hero, false) and distance < menuDist then
                            menuDist = distance
                            t = hero
                        end
                    end
                    if t then
                        local tPos = t.pos
                        local sR = { delay = 0.25, range = 1500, width = 125, speed = 1600, sType = "line", col = false }
                        local castpos,HitChance, pos = gsoAIO.TPred:GetBestCastPosition(t, sR.delay, sR.width*0.5, sR.range, sR.speed, mePos, sR.col, sR.sType)
                        local canRd = HitChance > 0 and castpos:ToScreen().onScreen and gsoAIO.Utils:_getDistance(t.pos, castpos) < 500
                              canRd = canRd and gsoAIO.Utils:_pointOnLineSegment(castpos.x, castpos.z, tPos.x, tPos.z, mePos.x, mePos.z)
                        if canRd then
                            canRonTarget = true
                            rPos = castpos
                        end
                    end
                end
                if not canRonTarget and isRiReady then
                    for i = 1, #gsoAIO.OB.enemyHeroes do
                        local unit = gsoAIO.OB.enemyHeroes[i]
                        local unitPos = unit and unit.pos or nil
                        if unitPos and gsoAIO.Utils:_valid(unit, false) and gsoAIO.Utils:_getDistance(mePos, unitPos) < 1000 and gsoAIO.Utils:_isImmobile(unit) then
                            local rPred = unitPos
                            if rPred and rPred:ToScreen().onScreen then
                                canRonTarget = true
                                rPos = rPred
                                break
                            end
                        end
                    end
                end
                if canRonTarget then
                    local cPos = cursorPos
                    self.lastR = GetTickCount()
                    Control.SetCursorPos(rPos)
                    gsoAIO.Orb.setCursor = rPos
                    Control.KeyDown(HK_R)
                    Control.KeyUp(HK_R)
                    gsoAIO.Orb.dActions[GetTickCount()] = { function() Control.SetCursorPos(cPos.x, cPos.y) end, 50 }
                    gsoAIO.Orb.dActionsC = gsoAIO.Orb.dActionsC + 1
                    gsoAIO.Vars.asheCanW = false
                    return false
                end
            end
            
            -- USE W :
            local canWTime = wMinus > 1000 and wMinuss > 1000 and rMinus > 700 and rMinuss > 700
            local isComboW = isCombo and gsoAIO.Load.menu.gsoashe.combo.wc:Value()
            local isHarassW = isHarass and gsoAIO.Load.menu.gsoashe.harass.wh:Value()
            local isWReady = (isComboW or isHarassW) and canWTime == true and gsoAIO.Utils:_isReady(_W) == true
            if isWReady and ( not isTarget or (isTarget and gsoAIO.Vars.asheCanW) ) then
                local wTarget = isTarget and target or gsoAIO.TS:_getTarget(1200, false, false)
                if wTarget ~= nil then
                    local mePos = myHero.pos
                    local sW = { delay = 0.25, range = 1200, width = 75, speed = 2000, sType = "line", col = true }
                    local castpos,HitChance, pos = gsoAIO.TPred:GetBestCastPosition(wTarget, sW.delay, sW.width*0.5, sW.range, sW.speed, mePos, sW.col, sW.sType)
                    if HitChance > 0 and castpos:ToScreen().onScreen and gsoAIO.Utils:_getDistance(mePos, castpos) < sW.range and gsoAIO.Utils:_getDistance(wTarget.pos, castpos) < 500 then
                        local cPos = cursorPos
                        Control.SetCursorPos(castpos)
                        gsoAIO.Orb.setCursor = castpos
                        Control.KeyDown(HK_W)
                        Control.KeyUp(HK_W)
                        self.lastW = GetTickCount()
                        gsoAIO.Orb.dActions[GetTickCount()] = { function() Control.SetCursorPos(cPos.x, cPos.y) end, 50 }
                        gsoAIO.Orb.dActionsC = gsoAIO.Orb.dActionsC + 1
                        gsoAIO.Vars.asheCanR = false
                        return false
                    end
                end
            end
            
            -- USE Q :
            local canQTime = qMinus > 1000 and qMinuss > 1000 and wMinus > 350 and wMinuss > 350 and rMinus > 350 and rMinuss > 350
            local isComboQ = isCombo and gsoAIO.Load.menu.gsoashe.combo.qc:Value()
            local isHarassQ = isHarass and gsoAIO.Load.menu.gsoashe.harass.qh:Value()
            local isQReady = (isComboQ or isHarassQ) and canQTime == true and gsoAIO.Utils:_isReady(_Q) == true
            if isQReady and Game.Timer() > gsoAIO.Orb.lAttack + gsoAIO.Orb.animT*0.5 then
                self.asNoQ = myHero.attackSpeed
                self.lastQ = GetTickCount()
                Control.KeyDown(HK_Q)
                Control.KeyUp(HK_Q)
                gsoAIO.Vars.asheCanW = false
                return false
            end
        end
    end
    if wMinus > 350 and wMinuss > 350 and rMinus > 350 and rMinuss > 350 then
        return true
    end
    return false
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoAshe:_tick()
    local hasQBuff = false
    for i = 0, myHero.buffCount do
        local buff = myHero:GetBuff(i)
        local buffName = buff and buff.name or nil
        if buffName and buff.count > 0 and buff.duration > 0 and buffName == "AsheQAttack" then
            hasQBuff = true
            self.QEndTime = GetTickCount() + (buff.duration*1000)
            break
        end
    end
    self.hasQBuff = hasQBuff
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoAshe:_dmgUnit(unit)
    local dmg = myHero.totalDamage
    local crit = 0.1 + myHero.critChance
    for i = 0, unit.buffCount do
        local buff = unit:GetBuff(i)
        if buff and buff.count > 0 and buff.name:lower() == "ashepassiveslow" then
            local aacompleteT = myHero.attackData.windUpTime + (gsoAIO.Utils:_getDistance(myHero.pos, unit.pos) / myHero.attackData.projectileSpeed)
            if aacompleteT + 0.1 < buff.duration then
                return dmg * crit
            end
        end
    end
    return 0
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
class "__gsoTwitch"
function __gsoTwitch:__init()
    self.hasQBuff = false
    self.qBuffTime = 0
    self.lastW  = 0
    self.lastE  = 0
    self.eBuffs = {}
    self.asNoQ = myHero.attackSpeed
    self.boolRecall = true
    self.QASBuff = false
    self.QASTime = 0
    gsoAIO.Orb.baseAASpeed = 0.679
    gsoAIO.Orb.baseWindUp = 0.2019159
    gsoAIO.Vars.drawRanges = { w = true, wrange = 950, e = true, erange = 1200, r = true, rfunc = function() return myHero.range + 300 + (myHero.boundingRadius*1.75) end }
    gsoAIO.Mana.spellData = { q = true, qm = 40, w = true, wm = 70, e = true, ef = function() return 40 + (10*myHero:GetSpellData(_E).level) end, r = true, rm = 100 }
    gsoAIO.Mana.priority = { [_R] = 1, [_Q] = 2, [_E] = 3, [_W] = 4 }
    gsoAIO.Vars:_setChampMenu(function() return self:_menu() end)
    gsoAIO.Vars:_setAASpeed(function() return self:_aaSpeed() end)
    gsoAIO.Vars:_setCanMove(function() return self:_canMove() end)
    gsoAIO.Vars:_setCanAttack(function(target) return self:_canAttack(target) end)
    gsoAIO.Vars:_setOnTick(function() self:_tick() end)
    gsoAIO.Vars:_setBonusDmg(function() return 3 end)
    gsoAIO.Vars:_setDraw(function() self:_draw() end)
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoTwitch:_menu()
    gsoAIO.Load.menu:MenuElement({name = "Twitch", id = "gsotwitch", type = MENU, leftIcon = gsoAIO.Vars.Icons["twitch"] })
        gsoAIO.Load.menu.gsotwitch:MenuElement({name = "Q settings", id = "qset", type = MENU })
            gsoAIO.Load.menu.gsotwitch.qset:MenuElement({id = "recallkey", name = "Invisible Recall Key", key = string.byte("T"), value = false, toggle = true})
            gsoAIO.Load.menu.gsotwitch.qset:MenuElement({id = "note1", name = "Note: Key should be diffrent than recall key", type = SPACE})
        gsoAIO.Load.menu.gsotwitch:MenuElement({name = "W settings", id = "wset", type = MENU })
            gsoAIO.Load.menu.gsotwitch.wset:MenuElement({id = "stopq", name = "Stop if Q invisible", value = true})
            gsoAIO.Load.menu.gsotwitch.wset:MenuElement({id = "stopult", name = "Stop if R", value = true})
            gsoAIO.Load.menu.gsotwitch.wset:MenuElement({id = "combo", name = "Use W Combo", value = true})
            gsoAIO.Load.menu.gsotwitch.wset:MenuElement({id = "harass", name = "Use W Harass", value = false})
        gsoAIO.Load.menu.gsotwitch:MenuElement({name = "E settings", id = "eset", type = MENU })
            gsoAIO.Load.menu.gsotwitch.eset:MenuElement({id = "combo", name = "Use E Combo", value = true})
            gsoAIO.Load.menu.gsotwitch.eset:MenuElement({id = "harass", name = "Use E Harass", value = false})
            gsoAIO.Load.menu.gsotwitch.eset:MenuElement({id = "stacks", name = "X stacks", value = 6, min = 1, max = 6, step = 1 })
            gsoAIO.Load.menu.gsotwitch.eset:MenuElement({id = "enemies", name = "X enemies", value = 1, min = 1, max = 5, step = 1 })
gsoAIO.Load.menu.gsotwitch.qset.recallkey:Value(false)
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoTwitch:_aaSpeed()
    local num1 = GetTickCount()-self.QASTime-(gsoAIO.Utils.maxPing*1000)
    if num1 > -150 and num1 < 1500 then
        return self.asNoQ
    end
    return myHero.attackSpeed
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoTwitch:_canMove()
    local getTick = GetTickCount() - (gsoAIO.Utils.maxPing*1000)
    local wMinus = getTick - self.lastW
    local wMinuss = getTick - gsoAIO.Spells.lastW
    local eMinus = getTick - self.lastE
    local eMinuss = getTick - gsoAIO.Spells.lastE
    if wMinus > 250 and wMinuss > 250 and eMinus > 250 and eMinuss > 250 then
        return true
    end
    return false
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoTwitch:_canAttack(target)
    local isTarget = target and target.type == Obj_AI_Hero
    local getTick = GetTickCount() - (gsoAIO.Utils.maxPing*1000)
    local num1 = 1350-(getTick-gsoAIO.Spells.lastQ)
    if num1 > -50 and num1 < (gsoAIO.Orb.windUpT*1000) + 250 then
        return false
    end
    local wMinus = getTick - self.lastW
    local wMinuss = getTick - gsoAIO.Spells.lastW
    local eMinus = getTick - self.lastE
    local eMinuss = getTick - gsoAIO.Spells.lastE
    if Game.Timer() > gsoAIO.Orb.lAttack + gsoAIO.Orb.windUpT + 0.1 + gsoAIO.Utils.maxPing then
        local isCombo = gsoAIO.Load.menu.orb.keys.combo:Value()
        local isHarass = gsoAIO.Load.menu.orb.keys.harass:Value()
        local afterAttack = Game.Timer() < gsoAIO.Orb.lAttack + ( gsoAIO.Orb.animT * 0.75 )
        
        local stopifQBuff = false
        local num1 = 1350-(getTick-gsoAIO.Spells.lastQ)
        if num1 > -50 and num1 < 550 then
            stopifQBuff = true
        end
        
        if not isTarget or afterAttack then
            
            -- USE W :
            local canWTime = wMinus > 1000 and wMinuss > 1000 and eMinus > 700 and eMinuss > 700
            local isComboW = isCombo and gsoAIO.Load.menu.gsotwitch.wset.combo:Value()
            local isHarassW = isHarass and gsoAIO.Load.menu.gsotwitch.wset.harass:Value()
            local stopWIfR = gsoAIO.Load.menu.gsotwitch.wset.stopult:Value() and GetTickCount() < gsoAIO.Spells.lastR + 5450
            local stopWIfQ = gsoAIO.Load.menu.gsotwitch.wset.stopq:Value() and self.hasQBuff
            local isWReady = (isComboW or isHarassW) and canWTime == true and gsoAIO.Utils:_isReady(_W) and not stopWIfR and not stopWIfQ and not stopifQBuff
            if isWReady and ( not isTarget or (isTarget and gsoAIO.Vars.twitchCanW) ) then
                local wTarget = isTarget and target or gsoAIO.TS:_getTarget(950, false, false)
                if wTarget ~= nil then
                    local mePos = myHero.pos
                    local sW = { delay = 0.25, range = 950, width = 275, speed = 1400, sType = "circular", col = false }
                    local castpos,HitChance, pos = gsoAIO.TPred:GetBestCastPosition(wTarget, sW.delay, sW.width*0.5, sW.range, sW.speed, mePos, sW.col, sW.sType)
                    if HitChance > 0 and castpos:ToScreen().onScreen and gsoAIO.Utils:_getDistance(mePos, castpos) < sW.range and gsoAIO.Utils:_getDistance(wTarget.pos, castpos) < 500 then
                        local cPos = cursorPos
                        Control.SetCursorPos(castpos)
                        gsoAIO.Orb.setCursor = castpos
                        Control.KeyDown(HK_W)
                        Control.KeyUp(HK_W)
                        self.lastW = GetTickCount()
                        gsoAIO.Orb.dActions[GetTickCount()] = { function() Control.SetCursorPos(cPos.x, cPos.y) end, 50 }
                        gsoAIO.Orb.dActionsC = gsoAIO.Orb.dActionsC + 1
                        gsoAIO.Vars.twitchCanE = false
                        return false
                    end
                end
            end
            
            -- USE E :
            local canETime = wMinus > 350 and wMinuss > 350 and eMinus > 1000 and eMinuss > 1000
            local isComboE = isCombo and gsoAIO.Load.menu.gsotwitch.eset.combo:Value()
            local isHarassE = isHarass and gsoAIO.Load.menu.gsotwitch.eset.harass:Value()
            local isEReady = (isComboE or isHarassE) and canETime and gsoAIO.Utils:_isReady(_E) and not stopifQBuff
            if isEReady and ( not isTarget or (isTarget and gsoAIO.Vars.twitchCanE) ) then
                local xStacks   = gsoAIO.Load.menu.gsotwitch.eset.stacks:Value()
                local xEnemies  = gsoAIO.Load.menu.gsotwitch.eset.enemies:Value()
                local countE    = 0
                for i = 1, #gsoAIO.OB.enemyHeroes do
                    local hero = gsoAIO.OB.enemyHeroes[i]
                    if gsoAIO.Utils:_getDistance(myHero.pos, hero.pos) < 1200 and gsoAIO.Utils:_valid(hero, false) then
                        local nID = hero.networkID
                        if self.eBuffs[nID] and self.eBuffs[nID].count >= xStacks then
                            countE = countE + 1
                        end
                    end
                end
                if countE >= xEnemies then
                    Control.KeyDown(HK_E)
                    Control.KeyUp(HK_E)
                    self.lastE = GetTickCount()
                    gsoAIO.Vars.twitchCanW = false
                    return false
                end
            end
        end
    end
    if wMinus > 450 and wMinuss > 450 and eMinus > 400 and eMinuss > 400 then
        return true
    end
    return false
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoTwitch:_tick()
    if GetTickCount() - gsoAIO.Spells.lastQ < 500 then
        self.asNoQ = myHero.attackSpeed
    end
    local boolRecall = gsoAIO.Load.menu.gsotwitch.qset.recallkey:Value()
    if boolRecall == self.boolRecall then
        Control.KeyDown(HK_Q)
        Control.KeyUp(HK_Q)
        Control.KeyDown(string.byte("B"))
        Control.KeyUp(string.byte("B"))
        self.boolRecall = not boolRecall
    end
    local hasQBuff = false
    local QASBuff = false
    for i = 0, myHero.buffCount do
        local buff = myHero:GetBuff(i)
        local buffName = buff and buff.name or nil
        if buffName and buff.count > 0 and buff.duration > 0 then
            if buffName == "globalcamouflage" or buffName == "TwitchHideInShadows" then
                hasQBuff = true
                self.qBuffTime = GetTickCount() + (buff.duration*1000)
                break
            end
            if buffName == "twitchhideinshadowsbuff" then
                QASBuff = true
                self.QASTime = GetTickCount() + (buff.duration*1000)
            end
        end
    end
    self.hasQBuff = hasQBuff
    self.QASBuff = QASBuff
    for i = 1, #gsoAIO.OB.enemyHeroes do
        local hero  = gsoAIO.OB.enemyHeroes[i]
        local nID   = hero.networkID
        if not self.eBuffs[nID] then
            self.eBuffs[nID] = { count = 0, durT = 0 }
        end
        if not hero.dead then
            local hasB = false
            local cB = self.eBuffs[nID].count
            local dB = self.eBuffs[nID].durT
            for i = 0, hero.buffCount do
                local buff = hero:GetBuff(i)
                if buff and buff.count > 0 and buff.name:lower() == "twitchdeadlyvenom" then
                    hasB = true
                    if cB < 6 and buff.duration > dB then
                        self.eBuffs[nID].count = cB + 1
                        self.eBuffs[nID].durT = buff.duration
                    else
                        self.eBuffs[nID].durT = buff.duration
                    end
                    break
                end
            end
            if not hasB then
                self.eBuffs[nID].count = 0
                self.eBuffs[nID].durT = 0
            end
        end
    end
    
    -- E KS :
    local getTick = GetTickCount() - (gsoAIO.Utils.maxPing*1000)
    local wMinus = getTick - self.lastW
    local wMinuss = getTick - gsoAIO.Spells.lastW
    local eMinus = getTick - self.lastE
    local eMinuss = getTick - gsoAIO.Spells.lastE
    local canETime = wMinus > 350 and wMinuss > 350 and eMinus > 1000 and eMinuss > 1000
    local isEReady = canETime and gsoAIO.Utils:_isReady(_E)
    if isEReady then
        for i = 1, #gsoAIO.OB.enemyHeroes do
            local hero  = gsoAIO.OB.enemyHeroes[i]
            local nID   = hero.networkID
            if self.eBuffs[nID] and self.eBuffs[nID].count > 0 and gsoAIO.Utils:_valid(hero, false) and gsoAIO.Utils:_getDistance(myHero.pos, hero.pos) < 1200 then
                local elvl = myHero:GetSpellData(_E).level
                local basedmg = 5 + ( elvl * 15 )
                local cstacks = self.eBuffs[nID].count
                local perstack = ( 10 + (5*elvl) ) * cstacks
                local bonusAD = myHero.bonusDamage * 0.25 * cstacks
                local bonusAP = myHero.ap * 0.2 * cstacks
                local edmg = basedmg + perstack + bonusAD + bonusAP
                local tarm = hero.armor - myHero.armorPen
                      tarm = tarm > 0 and myHero.armorPenPercent * tarm or tarm
                local DmgDealt = tarm > 0 and edmg * ( 100 / ( 100 + tarm ) ) or edmg * ( 2 - ( 100 / ( 100 - tarm ) ) )
                local HPRegen = hero.hpRegen * 1.5
                if hero.health + hero.shieldAD + HPRegen < DmgDealt then
                    Control.KeyDown(HK_E)
                    Control.KeyUp(HK_E)
                    self.lastE = GetTickCount()
                    gsoAIO.Vars.twitchCanW = false
                end
            end
        end
    end
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoTwitch:_draw()
    local mePos = myHero.pos
    if GetTickCount() < gsoAIO.Spells.lastQ + 16000 then
        local mePos2D = mePos:To2D()
        local posX = mePos2D.x - 50
        local posY = mePos2D.y
        local num1 = math.floor(1350+gsoAIO.Spells.qLatency-(GetTickCount()-gsoAIO.Spells.lastQ))
        local timerEnabled = gsoAIO.Load.menu.gsodraw.texts1.enabletime:Value()
        local timerColor = gsoAIO.Load.menu.gsodraw.texts1.colortime:Value()
        if num1 > 1 then
            if timerEnabled then
                local str1 = tostring(num1)
                local str2 = ""
                for i = 1, #str1 do
                    if #str1 <=2 then
                        str2 = 0
                        break
                    end
                    local char1 = i <= #str1-2 and str1:sub(i,i) or "0"
                    str2 = str2..char1
                end
                Draw.Text(str2, 50, posX+50, posY-15, timerColor)
            end
        elseif self.hasQBuff then
            local num2 = math.floor(self.qBuffTime-GetTickCount()+gsoAIO.Spells.qLatency)
            if num2 > 1 then
                if gsoAIO.Load.menu.gsodraw.circle1.invenable:Value() then
                    Draw.Circle(mePos, 500, 1, gsoAIO.Load.menu.gsodraw.circle1.invcolor:Value())
                end
                if gsoAIO.Load.menu.gsodraw.circle1.notenable:Value() then
                    Draw.Circle(mePos, 800, 1, gsoAIO.Load.menu.gsodraw.circle1.notcolor:Value())
                end
                if timerEnabled then
                    local str1 = tostring(num2)
                    local str2 = ""
                    for i = 1, #str1 do
                        if #str1 <=2 then
                            str2 = 0
                            break
                        end
                        local char1 = i <= #str1-2 and str1:sub(i,i) or "0"
                        str2 = str2..char1
                    end
                    Draw.Text(str2, 50, posX+50, posY-15, timerColor)
                end
            end
        end
    end
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
class "__gsoKogMaw"
--
--
--
function __gsoKogMaw:__init()
    gsoAIO.TS.apDmg = true
    self.lastQ = 0
    self.lastW = 0
    self.lastE = 0
    self.lastR = 0
    self.hasWBuff = false
    gsoAIO.Orb.baseAASpeed = 0.665
    gsoAIO.Orb.baseWindUp = 0.1662234
    gsoAIO.Vars.drawRanges = { q = true, qrange = 1175, e = true, erange = 1280, r = true, rfunc = function() return self:_rRange() end }
    gsoAIO.Mana.spellData = { q = true, qm = 40, w = true, wm = 40, e = true, ef = function() return 70 + (10*myHero:GetSpellData(_E).level) end, r = true, rf = function() return self:_rMana() end }
    gsoAIO.Mana.priority = { [_W] = 1, [_Q] = 2, [_E] = 3, [_R] = 4 }
    gsoAIO.Vars:_setChampMenu(function() return self:_menu() end)
    gsoAIO.Vars:_setCanMove(function() return self:_canMove() end)
    gsoAIO.Vars:_setCanAttack(function(target) return self:_canAttack(target) end)
    gsoAIO.Vars:_setOnTick(function() self:_tick() end)
    gsoAIO.Vars:_setBonusDmg(function() return 3 end)
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoKogMaw:_menu()
    gsoAIO.Load.menu:MenuElement({name = "Kog'Maw", id = "gsokog", type = MENU, leftIcon = gsoAIO.Vars.Icons["kog"] })
        gsoAIO.Load.menu.gsokog:MenuElement({name = "Q settings", id = "qset", type = MENU })
            gsoAIO.Load.menu.gsokog.qset:MenuElement({id = "combo", name = "Combo", value = true})
            gsoAIO.Load.menu.gsokog.qset:MenuElement({id = "harass", name = "Harass", value = false})
        gsoAIO.Load.menu.gsokog:MenuElement({name = "W settings", id = "wset", type = MENU })
            gsoAIO.Load.menu.gsokog.wset:MenuElement({id = "combo", name = "Combo", value = true})
            gsoAIO.Load.menu.gsokog.wset:MenuElement({id = "harass", name = "Harass", value = false})
            gsoAIO.Load.menu.gsokog.wset:MenuElement({id = "stopq", name = "Stop Q if has W buff", value = false})
            gsoAIO.Load.menu.gsokog.wset:MenuElement({id = "stope", name = "Stop E if has W buff", value = false})
            gsoAIO.Load.menu.gsokog.wset:MenuElement({id = "stopr", name = "Stop R if has W buff", value = false})
        gsoAIO.Load.menu.gsokog:MenuElement({name = "E settings", id = "eset", type = MENU })
            gsoAIO.Load.menu.gsokog.eset:MenuElement({id = "combo", name = "Combo", value = true})
            gsoAIO.Load.menu.gsokog.eset:MenuElement({id = "harass", name = "Harass", value = false})
        gsoAIO.Load.menu.gsokog:MenuElement({name = "R settings", id = "rset", type = MENU })
            gsoAIO.Load.menu.gsokog.rset:MenuElement({id = "combo", name = "Combo", value = true})
            gsoAIO.Load.menu.gsokog.rset:MenuElement({id = "harass", name = "Harass", value = false})
            gsoAIO.Load.menu.gsokog.rset:MenuElement({id = "stack", name = "Stop at x stacks", value = 3, min = 1, max = 9, step = 1 })
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoKogMaw:_rMana()
    local count = gsoAIO.Utils:_buffCount(myHero, "kogmawlivingartillerycost")
    if count >= gsoAIO.Load.menu.gsokog.rset.stack:Value() then return 0 end
    return count * 40
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoKogMaw:_rRange()
    local rlvl = myHero:GetSpellData(_R).level
    if rlvl == 0 then
        return 1200
    else
        return 900 + ( 300 * rlvl )
    end
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoKogMaw:_canMove()
    local getTick = GetTickCount() - (gsoAIO.Utils.maxPing*1000)
    local qMinus = getTick - self.lastQ
    local qMinuss = getTick - gsoAIO.Spells.lastQ
    local eMinus = getTick - self.lastE
    local eMinuss = getTick - gsoAIO.Spells.lastE
    local rMinus = getTick - self.lastR
    local rMinuss = getTick - gsoAIO.Spells.lastR
    if qMinus > 250 and qMinuss > 250 and eMinus > 250 and eMinuss > 250 and rMinus > 250 and rMinuss > 250 then
        return true
    end
    return false
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoKogMaw:_canAttack(target)
    local isTarget = target and target.type == Obj_AI_Hero
    local getTick = GetTickCount() - (gsoAIO.Utils.maxPing*1000)
    local qMinus = getTick - self.lastQ
    local qMinuss = getTick - gsoAIO.Spells.lastQ
    local wMinus = getTick - self.lastW
    local wMinuss = getTick - gsoAIO.Spells.lastW
    local eMinus = getTick - self.lastE
    local eMinuss = getTick - gsoAIO.Spells.lastE
    local rMinus = getTick - self.lastR
    local rMinuss = getTick - gsoAIO.Spells.lastR
    if Game.Timer() > gsoAIO.Orb.lAttack + gsoAIO.Orb.windUpT + 0.1 + gsoAIO.Utils.maxPing then
        local isCombo = gsoAIO.Load.menu.orb.keys.combo:Value()
        local isHarass = gsoAIO.Load.menu.orb.keys.harass:Value()
        local afterAttack = Game.Timer() < gsoAIO.Orb.lAttack + ( gsoAIO.Orb.animT * 0.75 )
        
        -- USE W :
        local mePos = myHero.pos
        local canWTime = qMinus > 550 and qMinuss > 550 and wMinus > 1000 and wMinuss > 1000 and eMinus > 550 and eMinuss > 550 and rMinus > 550 and rMinuss > 550
        local isComboW = isCombo and gsoAIO.Load.menu.gsokog.wset.combo:Value()
        local isHarassW = isHarass and gsoAIO.Load.menu.gsokog.wset.harass:Value()
        local isWReady = (isComboW or isHarassW) and canWTime and gsoAIO.Utils:_isReady(_W)
        if isWReady then
            for i = 1, #gsoAIO.OB.enemyHeroes do
                local hero = gsoAIO.OB.enemyHeroes[i]
                local wRange = 610 + ( 20 * myHero:GetSpellData(_W).level ) + myHero.boundingRadius + hero.boundingRadius
                if gsoAIO.Utils:_valid(hero, true) and gsoAIO.Utils:_getDistance(mePos, hero.pos) < wRange then
                    self.lastW = GetTickCount()
                    Control.KeyDown(HK_W)
                    Control.KeyUp(HK_W)
                    gsoAIO.Vars.kogCanQ = false
                    gsoAIO.Vars.kogCanE = false
                    gsoAIO.Vars.kogCanR = false
                    return false
                end
            end
        end
        
        if not isTarget or afterAttack then
            
            -- USE Q :
            local canQTime = qMinus > 1000 and qMinuss > 1000 and eMinus > 650 and eMinuss > 650 and rMinus > 650 and rMinuss > 650
            local isComboQ = isCombo and gsoAIO.Load.menu.gsokog.qset.combo:Value()
            local isHarassQ = isHarass and gsoAIO.Load.menu.gsokog.qset.harass:Value()
            local stopQIfW = gsoAIO.Load.menu.gsokog.wset.stopq:Value() and self.hasWBuff
            local isQReady = (isComboQ or isHarassQ) and canQTime and gsoAIO.Utils:_isReady(_Q) and not stopQIfW
            if isQReady and ( (not isTarget and wMinus > 500 and wMinuss > 500) or (isTarget and gsoAIO.Vars.kogCanQ) ) then
                local qTarget = isTarget and target or gsoAIO.TS:_getTarget(1175, false, false)
                local qTargetPos = qTarget and qTarget.pos or nil
                if qTargetPos then
                    local mePos = myHero.pos
                    local sQ = { delay = 0.25, range = 1175, width = 70, speed = 1650, sType = "line", col = true }
                    local castpos,HitChance,pos = gsoAIO.TPred:GetBestCastPosition(qTarget, sQ.delay, sQ.width*0.5, sQ.range, sQ.speed, mePos, sQ.col, sQ.sType)
                    local canQonTarget = HitChance > 0 and castpos:ToScreen().onScreen and gsoAIO.Utils:_getDistance(mePos, castpos) < sQ.range
                          canQonTarget = canQonTarget and gsoAIO.Utils:_getDistance(qTargetPos, castpos) < 500
                    if canQonTarget then
                        local cPos = cursorPos
                        Control.SetCursorPos(castpos)
                        gsoAIO.Orb.setCursor = castpos
                        Control.KeyDown(HK_Q)
                        Control.KeyUp(HK_Q)
                        self.lastQ = GetTickCount()
                        gsoAIO.Orb.dActions[GetTickCount()] = { function() Control.SetCursorPos(cPos.x, cPos.y) end, 50 }
                        gsoAIO.Orb.dActionsC = gsoAIO.Orb.dActionsC + 1
                        gsoAIO.Vars.kogCanE = false
                        gsoAIO.Vars.kogCanR = false
                        return false
                    end
                end
            end
            
            -- USE E :
            local canETime = qMinus > 650 and qMinuss > 650 and eMinus > 1000 and eMinuss > 1000 and rMinus > 650 and rMinuss > 650
            local isComboE = isCombo and gsoAIO.Load.menu.gsokog.eset.combo:Value()
            local isHarassE = isHarass and gsoAIO.Load.menu.gsokog.eset.harass:Value()
            local stopEIfW = gsoAIO.Load.menu.gsokog.wset.stope:Value() and self.hasWBuff
            local isEReady = (isComboE or isHarassE) and canETime and gsoAIO.Utils:_isReady(_E) and not stopEIfW
            if isEReady and ( (not isTarget and wMinus > 500 and wMinuss > 500) or (isTarget and gsoAIO.Vars.kogCanE) ) then
                local eTarget = isTarget and target or gsoAIO.TS:_getTarget(1280, false, false)
                if eTarget then
                    local mePos = myHero.pos
                    local sE = { delay = 0.25, range = 1280, width = 120, speed = 1350, sType = "line", col = false }
                    local castpos,HitChance, pos = gsoAIO.TPred:GetBestCastPosition(eTarget, sE.delay, sE.width*0.5, sE.range, sE.speed, mePos, sE.col, sE.sType)
                    if HitChance > 0 and castpos:ToScreen().onScreen and gsoAIO.Utils:_getDistance(mePos, castpos) < sE.range and gsoAIO.Utils:_getDistance(eTarget.pos, castpos) < 500 then
                        local cPos = cursorPos
                        Control.SetCursorPos(castpos)
                        gsoAIO.Orb.setCursor = castpos
                        Control.KeyDown(HK_E)
                        Control.KeyUp(HK_E)
                        self.lastE = GetTickCount()
                        gsoAIO.Orb.dActions[GetTickCount()] = { function() Control.SetCursorPos(cPos.x, cPos.y) end, 50 }
                        gsoAIO.Orb.dActionsC = gsoAIO.Orb.dActionsC + 1
                        gsoAIO.Vars.kogCanQ = false
                        gsoAIO.Vars.kogCanR = false
                        return false
                    end
                end
            end
            
            -- USE R :
            local canRTime = qMinus > 650 and qMinuss > 650 and eMinus > 650 and eMinuss > 650 and rMinus > 1000 and rMinuss > 1000
            local isComboR = isCombo and gsoAIO.Load.menu.gsokog.rset.combo:Value()
            local isHarassR = isHarass and gsoAIO.Load.menu.gsokog.rset.harass:Value()
            local rStacks = gsoAIO.Utils:_buffCount(myHero, "kogmawlivingartillerycost") < gsoAIO.Load.menu.gsokog.rset.stack:Value()
            local stopRIfW = gsoAIO.Load.menu.gsokog.wset.stopr:Value() and self.hasWBuff
            local isRReady = (isComboR or isHarassR) and canRTime and gsoAIO.Utils:_isReady(_R) and rStacks and not stopRIfW
            if isRReady and ( (not isTarget and wMinus > 500 and wMinuss > 500) or (isTarget and gsoAIO.Vars.kogCanR) ) then
                local sR = { delay = 1.2, range = 0, width = 225, speed = math.maxinteger, sType = "circular", col = false }
                sR.range = 900 + ( 300 * myHero:GetSpellData(_R).level )
                local rTarget = isTarget and target or gsoAIO.TS:_getTarget(sR.range + (sR.width*0.5), false, false)
                if rTarget then
                    local mePos = myHero.pos
                    local castpos,HitChance, pos = gsoAIO.TPred:GetBestCastPosition(rTarget, sR.delay, sR.width*0.5, sR.range, sR.speed, mePos, sR.col, sR.sType)
                    if HitChance > 0 and castpos:ToScreen().onScreen and gsoAIO.Utils:_getDistance(mePos, castpos) < sR.range and gsoAIO.Utils:_getDistance(rTarget.pos, castpos) < 500 then
                        local cPos = cursorPos
                        Control.SetCursorPos(castpos)
                        gsoAIO.Orb.setCursor = castpos
                        Control.KeyDown(HK_R)
                        Control.KeyUp(HK_R)
                        self.lastR = GetTickCount()
                        gsoAIO.Orb.dActions[GetTickCount()] = { function() Control.SetCursorPos(cPos.x, cPos.y) end, 50 }
                        gsoAIO.Orb.dActionsC = gsoAIO.Orb.dActionsC + 1
                        gsoAIO.Vars.kogCanQ = false
                        gsoAIO.Vars.kogCanE = false
                        return false
                    end
                end
            end
        end
    end
    if qMinus > 450 and qMinuss > 450 and eMinus > 450 and eMinuss > 450 and rMinus > 450 and rMinuss > 450 then
        return true
    end
    return false
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoKogMaw:_tick()
    local hasWBuff = false
    for i = 0, myHero.buffCount do
        local buff = myHero:GetBuff(i)
        local buffName = buff and buff.name or nil
        if buffName and buff.count > 0 and buff.duration > 0 then
            if buffName == "KogMawBioArcaneBarrage" then
                hasWBuff = true
                break
            end
        end
    end
    self.hasWBuff = hasWBuff
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
class "__gsoDraven"
--
--
--
function __gsoDraven:__init()
    self.qParticles = {}
    self.lastQ = 0
    self.lastW = 0
    self.lastE = 0
    self.lastR = 0
    self.lMove = 0
    gsoAIO.Orb.baseAASpeed = 0.679
    gsoAIO.Orb.baseWindUp = 0.1561439
    gsoAIO.Vars.drawRanges = { e = true, erange = 1050 }
    gsoAIO.Mana.spellData = { q = true, qm = 45, w = true, wf = function() return 45 - (5*myHero:GetSpellData(_W).level) end, e = true, em = 70, r = true, rm = 100 }
    gsoAIO.Mana.priority = { [_R] = 1, [_Q] = 2, [_E] = 3, [_W] = 4 }
    gsoAIO.Vars:_setChampMenu(function() return self:_menu() end)
    gsoAIO.Vars:_setMousePos(function() return self:_setMousePos() end)
    gsoAIO.Vars:_setCanMove(function() return self:_canMove() end)
    gsoAIO.Vars:_setCanAttack(function(target) return self:_canAttack(target) end)
    gsoAIO.Vars:_setOnTick(function() self:_tick() end)
    gsoAIO.Vars:_setBonusDmg(function() return 3 end)
    gsoAIO.Vars:_setDraw(function() self:_draw() end)
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoDraven:_menu()
    gsoAIO.Load.menu:MenuElement({name = "Draven", id = "gsodraven", type = MENU, leftIcon = gsoAIO.Vars.Icons["draven"] })
        gsoAIO.Load.menu.gsodraven:MenuElement({name = "AXE settings", id = "aset", type = MENU })
            gsoAIO.Load.menu.gsodraven.aset:MenuElement({id = "catch", name = "Catch axes", value = true})
            gsoAIO.Load.menu.gsodraven.aset:MenuElement({id = "catcht", name = "stop under turret", value = true})
            gsoAIO.Load.menu.gsodraven.aset:MenuElement({id = "catcho", name = "[combo] stop if no enemy in range", value = true})
            gsoAIO.Load.menu.gsodraven.aset:MenuElement({name = "Distance", id = "dist", type = MENU })
                gsoAIO.Load.menu.gsodraven.aset.dist:MenuElement({id = "mode", name = "Axe Mode", value = 1, drop = {"closest to mousePos", "closest to heroPos"} })
                gsoAIO.Load.menu.gsodraven.aset.dist:MenuElement({id = "extradur", name = "extra axe duration time", value = 100, min = 0, max = 300, step = 10 })
                gsoAIO.Load.menu.gsodraven.aset.dist:MenuElement({id = "stopmove", name = "axePos in distance < X | Hold radius", value = 75, min = 50, max = 125, step = 5 })
                gsoAIO.Load.menu.gsodraven.aset.dist:MenuElement({id = "cdist", name = "max distance from axePos to cursorPos", value = 750, min = 500, max = 1500, step = 50 })
        gsoAIO.Load.menu.gsodraven:MenuElement({name = "Q settings", id = "qset", type = MENU })
            gsoAIO.Load.menu.gsodraven.qset:MenuElement({id = "combo", name = "Combo", value = true})
            gsoAIO.Load.menu.gsodraven.qset:MenuElement({id = "harass", name = "Harass", value = false})
        gsoAIO.Load.menu.gsodraven:MenuElement({name = "W settings", id = "wset", type = MENU })
            gsoAIO.Load.menu.gsodraven.wset:MenuElement({id = "combo", name = "Combo", value = true})
            gsoAIO.Load.menu.gsodraven.wset:MenuElement({id = "harass", name = "Harass", value = false})
            gsoAIO.Load.menu.gsodraven.wset:MenuElement({id = "hdist", name = "max enemy distance", value = 750, min = 500, max = 2000, step = 50 })
        gsoAIO.Load.menu.gsodraven:MenuElement({name = "E settings", id = "eset", type = MENU })
            gsoAIO.Load.menu.gsodraven.eset:MenuElement({id = "combo", name = "Combo", value = true})
            gsoAIO.Load.menu.gsodraven.eset:MenuElement({id = "harass", name = "Harass", value = false})
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoDraven:_canMove()
    local getTick = GetTickCount() - (gsoAIO.Utils.maxPing*1000)
    local wMinus = getTick - self.lastW
    local wMinuss = getTick - gsoAIO.Spells.lastW
    local eMinus = getTick - self.lastE
    local eMinuss = getTick - gsoAIO.Spells.lastE
    if wMinus > 250 and wMinuss > 250 and eMinus > 250 and eMinuss > 250 then
        return true
    end
    return false
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoDraven:_canAttack(target)
    local isTarget = target and target.type == Obj_AI_Hero
    local getTick = GetTickCount() - (gsoAIO.Utils.maxPing*1000)
    local qMinus = getTick - self.lastQ
    local qMinuss = getTick - gsoAIO.Spells.lastQ
    local wMinus = getTick - self.lastW
    local wMinuss = getTick - gsoAIO.Spells.lastW
    local eMinus = getTick - self.lastE
    local eMinuss = getTick - gsoAIO.Spells.lastE
    if Game.Timer() > gsoAIO.Orb.lAttack + gsoAIO.Orb.windUpT + 0.1 + gsoAIO.Utils.maxPing then
        local isCombo = gsoAIO.Load.menu.orb.keys.combo:Value()
        local isHarass = gsoAIO.Load.menu.orb.keys.harass:Value()
        local afterAttack = Game.Timer() < gsoAIO.Orb.lAttack + ( gsoAIO.Orb.animT * 0.85 )
        if not isTarget or afterAttack then
            
            -- USE W :
            local canWTime = wMinus > 1000 and wMinuss > 1000 and eMinus > 250 and eMinuss > 250
            local isComboW = isCombo and gsoAIO.Load.menu.gsodraven.wset.combo:Value()
            local isHarassW = isHarass and gsoAIO.Load.menu.gsodraven.wset.harass:Value()
            local isWReady = (isComboW or isHarassW) and canWTime and gsoAIO.Utils:_isReady(_W)
            if isWReady and (not isTarget or (isTarget and gsoAIO.Vars.dravenCanW)) then
                for i = 1, #gsoAIO.OB.enemyHeroes do
                    local hero  = gsoAIO.OB.enemyHeroes[i]
                    local heroPos = hero and hero.pos or nil
                    local canWifEnemy = heroPos and gsoAIO.Utils:_valid(hero, false)
                          canWifEnemy = isTarget or (not isTarget and gsoAIO.Utils:_getDistance(myHero.pos, heroPos) < gsoAIO.Load.menu.gsodraven.wset.hdist:Value())
                    if canWifEnemy then
                        Control.KeyDown(HK_W)
                        Control.KeyUp(HK_W)
                        self.lastW = GetTickCount()
                        gsoAIO.Vars.dravenCanE = false
                        return false
                    end
                end
            end
            
            -- USE E :
            local canETime = wMinus > 250 and wMinuss > 250 and eMinus > 1000 and eMinuss > 1000
            local isComboE = isCombo and gsoAIO.Load.menu.gsodraven.eset.combo:Value()
            local isHarassE = isHarass and gsoAIO.Load.menu.gsodraven.eset.harass:Value()
            local isEReady = (isComboE or isHarassE) and canETime and gsoAIO.Utils:_isReady(_E)
            if isEReady and (not isTarget or (isTarget and gsoAIO.Vars.dravenCanE)) then
                local eTarget = isTarget and target or gsoAIO.TS:_getTarget(1050, false, false)
                if eTarget then
                    local sE = { delay = 0.25, range = 1050, width = 150, speed = 1400, sType = "line", col = false }
                    local mePos = myHero.pos
                    local targetPos = eTarget.pos
                    local castpos,HitChance, pos = gsoAIO.TPred:GetBestCastPosition(eTarget, sE.delay, sE.width*0.5, sE.range, sE.speed, mePos, sE.col, sE.sType)
                    local distToPred = gsoAIO.Utils:_getDistance(mePos, castpos)
                    local distToTarget = gsoAIO.Utils:_getDistance(mePos, targetPos)
                    local isOnLine = gsoAIO.Utils:_pointOnLineSegment(castpos.x, castpos.z, mePos.x, mePos.z, targetPos.x, targetPos.z)
                    if HitChance > 0 and castpos:ToScreen().onScreen and distToPred < sE.range and distToPred > 125 and distToTarget > 125 and gsoAIO.Utils:_getDistance(targetPos, castpos) < 250 and isOnLine then
                        local cPos = cursorPos
                        Control.SetCursorPos(castpos)
                        gsoAIO.Orb.setCursor = castpos
                        Control.KeyDown(HK_E)
                        Control.KeyUp(HK_E)
                        self.lastE = GetTickCount()
                        gsoAIO.Orb.dActions[GetTickCount()] = { function() Control.SetCursorPos(cPos.x, cPos.y) end, 50 }
                        gsoAIO.Orb.dActionsC = gsoAIO.Orb.dActionsC + 1
                        gsoAIO.Vars.dravenCanW = false
                        return false
                    end
                end
            end
        end
        if isTarget then
            
            -- USE Q :
            local canQTime = qMinus > 1000 and qMinuss > 1000 and eMinus > 250 and eMinuss > 250
            local isComboQ = isCombo and gsoAIO.Load.menu.gsodraven.qset.combo:Value()
            local isHarassQ = isHarass and gsoAIO.Load.menu.gsodraven.qset.harass:Value()
            local isQReady = (isComboQ or isHarassQ) and canQTime and gsoAIO.Utils:_isReady(_Q)
            if isQReady and Game.Timer() > gsoAIO.Orb.lAttack + gsoAIO.Orb.animT*0.5 then
                Control.KeyDown(HK_Q)
                Control.KeyUp(HK_Q)
                self.lastQ = GetTickCount()
                gsoAIO.Vars.dravenCanW = false
                gsoAIO.Vars.dravenCanE = false
                gsoAIO.Vars.dravenCanR = false
                return false
            end
        end
    end
    if qMinus > 75 and qMinuss > 75 and wMinus > 150 and wMinuss > 150 and eMinus > 400 and eMinuss > 400 then
        return true
    end
    return false
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoDraven:_setMousePos()
    if not gsoAIO.Load.menu.gsodraven.aset.catch:Value() then return qPos end
    local qPos = nil
    local kID = nil
    local num = 1000000000
    for k,v in pairs(self.qParticles) do
        if not v.success then
            local mePos = myHero.pos
            local distanceToHero = gsoAIO.Utils:_getDistance(v.pos, mePos)
            local distanceToMouse = gsoAIO.Utils:_getDistance(v.pos, mousePos)
            local qMode = gsoAIO.Load.menu.gsodraven.aset.dist.mode:Value()
            if qMode == 1 and distanceToMouse < num then
                qPos = v.pos
                num = distanceToMouse
                kID = k
            elseif qMode == 2 and distanceToHero < num then
                qPos = v.pos
                num = distanceToHero
                kID = k
            else
                self.qParticles[k].active = false
            end
        end
    end
    if qPos ~= nil then
        qPos = qPos:Extended(mousePos, gsoAIO.Load.menu.gsodraven.aset.dist.stopmove:Value())
        local stopNearUnit = gsoAIO.Utils:_nearTurret(qPos, 0, true) or gsoAIO.Utils:_nearHeroes(qPos, 0, true) or gsoAIO.Utils:_nearMinions(qPos, 0, true)
        local stopUnderTurret = gsoAIO.Load.menu.gsodraven.aset.catcht:Value() and gsoAIO.Utils:_nearTurret(qPos, 775, false)
        local stopOutOfAARange = gsoAIO.Load.menu.gsodraven.aset.catcho:Value() and not gsoAIO.Utils:_nearHeroes(qPos, myHero.range + myHero.boundingRadius + 30, false)
        if qPos and ( stopNearUnit or stopUnderTurret or stopOutOfAARange ) then
            qPos = nil
            self.qParticles[kID].active = false
        else
            self.qParticles[kID].active = true
        end
    end
    return qPos
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoDraven:_tick()
    local mePos = myHero.pos
    for i = 1, Game.ParticleCount() do
        local particle = Game.Particle(i)
        if particle then
            local particlePos = particle.pos
            if gsoAIO.Utils:_getDistance(mePos, particlePos) < 500 and particle.name == "Draven_Base_Q_reticle" then
                local particleID = particle.handle
                if not self.qParticles[particleID] then
                    self.qParticles[particleID] = { pos = particlePos, tick = GetTickCount(), success = false, active = false }
                    gsoAIO.Orb.lMove = 0
                end
            end
        end
    end
    for k,v in pairs(self.qParticles) do
        local timerMinus = GetTickCount() - v.tick
        local numMenu = 900 + gsoAIO.Load.menu.gsodraven.aset.dist.extradur:Value() - (gsoAIO.Utils.minPing*1000)
        if not v.success and timerMinus > numMenu then
            self.qParticles[k].success = true
            gsoAIO.Orb.lMove = 0
        end
        if timerMinus > numMenu and timerMinus < numMenu + 100 then
            gsoAIO.Orb.lMove = 0
        end
        if timerMinus > 2000 then
            self.qParticles[k] = nil
        end
    end
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoDraven:_draw()
    if gsoAIO.Load.menu.gsodraven.aset.catch:Value() then
        local aenabled = gsoAIO.Load.menu.gsodraw.circle1.aaxeenable:Value()
        local ienabled = gsoAIO.Load.menu.gsodraw.circle1.iaxeenable:Value()
        if aenabled or ienabled then
            for k,v in pairs(self.qParticles) do
                if not v.success then
                    if v.active and aenabled then
                        local acol = gsoAIO.Load.menu.gsodraw.circle1.aaxecolor:Value()
                        local arad = gsoAIO.Load.menu.gsodraw.circle1.aaxeradius:Value()
                        local awid = gsoAIO.Load.menu.gsodraw.circle1.aaxewidth:Value()
                        Draw.Circle(v.pos, arad, awid, acol)
                    elseif ienabled then
                        local icol = gsoAIO.Load.menu.gsodraw.circle1.iaxecolor:Value()
                        local irad = gsoAIO.Load.menu.gsodraw.circle1.iaxeradius:Value()
                        local iwid = gsoAIO.Load.menu.gsodraw.circle1.iaxewidth:Value()
                        Draw.Circle(v.pos, irad, iwid, icol)
                    end
                end
            end
        end
    end
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
class "__gsoEzreal"
--
--
--
function __gsoEzreal:__init()
    self.lastQ        = 0
    self.lastW        = 0
    self.lastE        = 0
    self.shouldWaitT  = 0
    self.shouldWait   = false
    gsoAIO.Orb.baseAASpeed = 0.625
    gsoAIO.Orb.baseWindUp = 0.18838652
    gsoAIO.Vars.drawRanges = { q = true, qrange = 1150, w = true, wrange = 1000, e = true, erange = 475 }
    gsoAIO.Mana.spellData = { q = true, qf = function() return 25 + (3*myHero:GetSpellData(_Q).level) end, w = true, wf = function() return 40 + (10*myHero:GetSpellData(_W).level) end, e = true, em = 90, r = true, rm = 100 }
    gsoAIO.Mana.priority = { [_E] = 1, [_Q] = 2, [_R] = 3, [_W] = 4 }
    gsoAIO.Vars:_setChampMenu(function() return self:_menu() end)
    gsoAIO.Vars:_setCanMove(function() return self:_canMove() end)
    gsoAIO.Vars:_setCanAttack(function(target) return self:_canAttack(target) end)
    gsoAIO.Vars:_setOnTick(function() self:_tick() end)
    gsoAIO.Vars:_setBonusDmg(function() return 3 end)
    gsoAIO.Vars:_setDraw(function() self:_draw() end)
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoEzreal:_menu()
    gsoAIO.Load.menu:MenuElement({name = "Ezreal", id = "gsoezreal", type = MENU, leftIcon = gsoAIO.Vars.Icons["ezreal"] })
        gsoAIO.Load.menu.gsoezreal:MenuElement({name = "Auto Q", id = "autoq", type = MENU })
            gsoAIO.Load.menu.gsoezreal.autoq:MenuElement({id = "enable", name = "Enable", value = true, key = string.byte("T"), toggle = true})
            gsoAIO.Load.menu.gsoezreal.autoq:MenuElement({id = "mana", name = "Q Auto min. mana percent", value = 50, min = 0, max = 100, step = 1 })
        gsoAIO.Load.menu.gsoezreal:MenuElement({name = "Q settings", id = "qset", type = MENU })
            gsoAIO.Load.menu.gsoezreal.qset:MenuElement({id = "hitchance", name = "Hitchance", value = 1, drop = { "normal", "high" } })
            gsoAIO.Load.menu.gsoezreal.qset:MenuElement({id = "combo", name = "Combo", value = true})
            gsoAIO.Load.menu.gsoezreal.qset:MenuElement({id = "harass", name = "Harass", value = false})
            gsoAIO.Load.menu.gsoezreal.qset:MenuElement({id = "laneclear", name = "LaneClear", value = false})
            gsoAIO.Load.menu.gsoezreal.qset:MenuElement({id = "lasthit", name = "LastHit", value = true})
            gsoAIO.Load.menu.gsoezreal.qset:MenuElement({id = "qlh", name = "Q LastHit min. mana percent", value = 10, min = 0, max = 100, step = 1 })
            gsoAIO.Load.menu.gsoezreal.qset:MenuElement({id = "qlc", name = "Q LaneClear min. mana percent", value = 50, min = 0, max = 100, step = 1 })
        gsoAIO.Load.menu.gsoezreal:MenuElement({name = "W settings", id = "wset", type = MENU })
            gsoAIO.Load.menu.gsoezreal.wset:MenuElement({id = "hitchance", name = "Hitchance", value = 1, drop = { "normal", "high" } })
            gsoAIO.Load.menu.gsoezreal.wset:MenuElement({id = "combo", name = "Combo", value = true})
            gsoAIO.Load.menu.gsoezreal.wset:MenuElement({id = "harass", name = "Harass", value = false})
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoEzreal:_canMove()
    local getTick = GetTickCount() - (gsoAIO.Utils.maxPing*1000)
    local qMinus = getTick - self.lastQ
    local qMinuss = getTick - gsoAIO.Spells.lastQ
    local wMinus = getTick - self.lastW
    local wMinuss = getTick - gsoAIO.Spells.lastW
    local eMinuss = getTick - gsoAIO.Spells.lastE
    local rMinuss = getTick - gsoAIO.Spells.lastR
    if qMinus > 250 and qMinuss > 250 and wMinus > 250 and wMinuss > 250 and eMinuss > 250 and rMinuss > 1000 then
        return true
    end
    return false
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoEzreal:_canAttack(target)
    local isTarget = target and target.type == Obj_AI_Hero
    local getTick = GetTickCount() - (gsoAIO.Utils.maxPing*1000)
    local qMinus = getTick - self.lastQ
    local qMinuss = getTick - gsoAIO.Spells.lastQ
    local wMinus = getTick - self.lastW
    local wMinuss = getTick - gsoAIO.Spells.lastW
    local eMinus = getTick - self.lastE
    local eMinuss = getTick - gsoAIO.Spells.lastE
    local rMinuss = getTick - gsoAIO.Spells.lastR
    if Game.Timer() > gsoAIO.Orb.lAttack + gsoAIO.Orb.windUpT + 0.1 + gsoAIO.Utils.maxPing then
        local isCombo = gsoAIO.Load.menu.orb.keys.combo:Value()
        local isHarass = gsoAIO.Load.menu.orb.keys.harass:Value()
        local afterAttack = Game.Timer() < gsoAIO.Orb.lAttack + ( gsoAIO.Orb.animT * 0.75 )
        if not isTarget or afterAttack then
            
            -- Q :
            local canQTime = qMinus > 1000 and qMinuss > 1000 and wMinus > 450 and wMinuss > 450 and eMinus > 650 and eMinuss > 650 and rMinuss > 1500
            local isComboQ = isCombo and gsoAIO.Load.menu.gsoezreal.qset.combo:Value()
            local isHarassQ = isHarass and gsoAIO.Load.menu.gsoezreal.qset.harass:Value()
            local isQReady = canQTime and gsoAIO.Utils:_isReady(_Q)
            local isQReadyCombo = isQReady and (isComboQ or isHarassQ)
            
            -- Q FARM :
            if isQReady and ( not isTarget or (isTarget and gsoAIO.Vars.ezrealCanQ) ) and self:_castQFarm() then
                gsoAIO.Vars.ezrealCanW = false
                return false
            end
            
            -- USE Q :
            if isQReadyCombo and ( not isTarget or (isTarget and gsoAIO.Vars.ezrealCanQ) ) then
                local qTarget = isTarget and target or gsoAIO.TS:_getTarget(1150, true, false)
                if qTarget ~= nil then
                    local sQ = { delay = 0.25, range = 1150, width = 60, speed = 2000, sType = "line", col = true }
                    local mePos = myHero.pos
                    local castpos,HitChance, pos = gsoAIO.TPred:GetBestCastPosition(qTarget, sQ.delay, sQ.width*0.5, sQ.range, sQ.speed, mePos, sQ.col, sQ.sType)
                    local distMeToPredPos = gsoAIO.Utils:_getDistance(mePos, castpos)
                    local distUnitToPredPos = gsoAIO.Utils:_getDistance(qTarget.pos, castpos)
                    if HitChance > gsoAIO.Load.menu.gsoezreal.qset.hitchance:Value()-1 and castpos:ToScreen().onScreen and distMeToPredPos < sQ.range and distUnitToPredPos < 500 then
                        local cPos = cursorPos
                        Control.SetCursorPos(castpos)
                        gsoAIO.Orb.setCursor = castpos
                        Control.KeyDown(HK_Q)
                        Control.KeyUp(HK_Q)
                        self.lastQ = GetTickCount()
                        gsoAIO.Orb.dActions[GetTickCount()] = { function() Control.SetCursorPos(cPos.x, cPos.y) end, 50 }
                        gsoAIO.Orb.dActionsC = gsoAIO.Orb.dActionsC + 1
                        gsoAIO.Vars.ezrealCanW = false
                        return false
                    end
                end
            end
            
            -- USE W :
            local canWTime = qMinus > 650 and qMinuss > 650 and wMinus > 1000 and wMinuss > 1000 and eMinus > 650 and eMinuss > 650 and rMinuss > 1500
            local isComboW = isCombo and gsoAIO.Load.menu.gsoezreal.wset.combo:Value()
            local isHarassW = isHarass and gsoAIO.Load.menu.gsoezreal.wset.harass:Value()
            local isWReady = (isComboW or isHarassW) and canWTime and gsoAIO.Utils:_isReady(_W)
            if isWReady and ( not isTarget or (isTarget and gsoAIO.Vars.ezrealCanW) ) then
                local wTarget = isTarget and target or gsoAIO.TS:_getTarget(1000, false, false)
                if wTarget ~= nil then
                    local mePos = myHero.pos
                    local sW = { delay = 0.25, range = 1000, width = 80, speed = 1550, sType = "line", col = false }
                    local castpos,HitChance, pos = gsoAIO.TPred:GetBestCastPosition(wTarget, sW.delay, sW.width*0.5, sW.range, sW.speed, mePos, sW.col, sW.sType)
                    local distMeToPredPos = gsoAIO.Utils:_getDistance(mePos, castpos)
                    local distUnitToPredPos = gsoAIO.Utils:_getDistance(wTarget.pos, castpos)
                    if HitChance > gsoAIO.Load.menu.gsoezreal.wset.hitchance:Value()-1 and castpos:ToScreen().onScreen and distMeToPredPos < sW.range and distUnitToPredPos < 500 then
                        local cPos = cursorPos
                        Control.SetCursorPos(castpos)
                        gsoAIO.Orb.setCursor = castpos
                        Control.KeyDown(HK_W)
                        Control.KeyUp(HK_W)
                        self.lastW = GetTickCount()
                        gsoAIO.Orb.dActions[GetTickCount()] = { function() Control.SetCursorPos(cPos.x, cPos.y) end, 50 }
                        gsoAIO.Orb.dActionsC = gsoAIO.Orb.dActionsC + 1
                        gsoAIO.Vars.ezrealCanQ = false
                        return false
                    end
                end
            end
        end
    end
    if qMinus > 350 and qMinuss > 350 and wMinus > 350 and wMinuss > 350 and eMinus > 350 and eMinuss > 350 and rMinuss > 1100 then
        return true
    end
    return false
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoEzreal:_castQ(t, tPos, mePos)
    local sQ = { delay = 0.25, range = 1150, width = 60, speed = 2000, sType = "line", col = true }
    local castpos,HitChance, pos = gsoAIO.TPred:GetBestCastPosition(t, sQ.delay, sQ.width*0.5, sQ.range, sQ.speed, mePos, sQ.col, sQ.sType)
    local distMeToPredPos = gsoAIO.Utils:_getDistance(mePos, castpos)
    local distUnitToPredPos = gsoAIO.Utils:_getDistance(tPos, castpos)
    if HitChance > gsoAIO.Load.menu.gsoezreal.qset.hitchance:Value()-1 and castpos:ToScreen().onScreen and distMeToPredPos < sQ.range and distUnitToPredPos < 500 then
        local cPos = cursorPos
        Control.SetCursorPos(castpos)
        gsoAIO.Orb.setCursor = castpos
        Control.KeyDown(HK_Q)
        Control.KeyUp(HK_Q)
        self.lastQ = GetTickCount()
        gsoAIO.Orb.dActions[GetTickCount()] = { function() Control.SetCursorPos(cPos.x, cPos.y) end, 50 }
        gsoAIO.Orb.dActionsC = gsoAIO.Orb.dActionsC + 1
        gsoAIO.Vars.ezrealCanW = false
        return true
    end
    return false
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoEzreal:_castQFarm()
    local meRange = myHero.range + myHero.boundingRadius
    local manaPercent = 100 * myHero.mana / myHero.maxMana
    local isLH = gsoAIO.Load.menu.gsoezreal.qset.lasthit:Value() and (gsoAIO.Load.menu.orb.keys.lastHit:Value() or gsoAIO.Load.menu.orb.keys.harass:Value())
    local isLC = gsoAIO.Load.menu.gsoezreal.qset.laneclear:Value() and gsoAIO.Load.menu.orb.keys.laneClear:Value()
    if isLH or isLC then
        local canLH = manaPercent > gsoAIO.Load.menu.gsoezreal.qset.qlh:Value()
        local canLC = manaPercent > gsoAIO.Load.menu.gsoezreal.qset.qlc:Value()
        if not canLH and not canLC then return false end
        if self.shouldWait == true and Game.Timer() > self.shouldWaitT + 0.5 then
            self.shouldWait = false
        end
        local almostLH = false
        local laneClearT = {}
        local lastHitT = {}
        
        -- [[ set enemy minions ]]
        local mLH = gsoAIO.Load.menu.orb.delays.lhDelay:Value()*0.001
        for i = 1, #gsoAIO.OB.enemyMinions do
            local eMinion = gsoAIO.OB.enemyMinions[i]
            local eMinion_handle	= eMinion.handle
            local eMinion_health	= eMinion.health
            local myHero_aaData		= myHero.attackData
            local myHero_pFlyTime	= gsoAIO.Utils:_getDistance(myHero.pos, eMinion.pos) / 2000
            for k1,v1 in pairs(gsoAIO.Farm.aAttacks) do
                for k2,v2 in pairs(gsoAIO.Farm.aAttacks[k1]) do
                    if v2.canceled == false and eMinion_handle == v2.to.handle then
                        local checkT	= Game.Timer()
                        local pEndTime	= v2.startTime + v2.pTime
                        if pEndTime > checkT and  pEndTime - checkT < myHero_pFlyTime - mLH then
                            eMinion_health = eMinion_health - v2.dmg
                        end
                    end
                end
            end
            local myHero_dmg = ((25 * myHero:GetSpellData(_Q).level) - 10) + (1.1 * myHero.totalDamage) + (0.4 * myHero.ap)
            if eMinion_health - myHero_dmg < 0 then
                lastHitT[#lastHitT+1] = eMinion
            else
                if eMinion.health - gsoAIO.Farm:_possibleDmg(eMinion, 2.5) - myHero_dmg < 0 then
                    almostLH = true
                    self.shouldWait = true
                    self.shouldWaitT = Game.Timer()
                else
                    laneClearT[#laneClearT+1] = eMinion
                end
            end
        end

        -- [[ lasthit ]]
        if isLH and canLH then
            local canCheckT = false
            for i = 1, #lastHitT do
                local unit = lastHitT[i]
                local unitPos = unit.pos
                local mePos = myHero.pos
                local checkT = Game.Timer() < gsoAIO.TS.LHTimers[4].tick
                local mHandle = unit.handle
                if not checkT or (checkT and gsoAIO.TS.LHTimers[4].id ~= mHandle) then
                    if gsoAIO.Utils:_getDistance(mePos, unitPos) < meRange + unit.boundingRadius then
                        canCheckT = true
                        break
                    end
                end
            end
            if not canCheckT or (canCheckT and Game.Timer() < gsoAIO.Orb.lAttack + gsoAIO.Orb.animT) then
                for i = 1, #lastHitT do
                    local minion = lastHitT[i]
                    local minionPos = minion.pos
                    local mePos = myHero.pos
                    local checkT = Game.Timer() < gsoAIO.TS.LHTimers[4].tick
                    local mHandle = minion.handle
                    if not checkT or (checkT and gsoAIO.TS.LHTimers[4].id ~= mHandle) then
                        local distance = gsoAIO.Utils:_getDistance(mePos, minionPos)
                        if distance < 1150 and self:_castQ(minion, minionPos, mePos) then
                            gsoAIO.TS.LHTimers[0].tick = Game.Timer() + 0.75
                            gsoAIO.TS.LHTimers[0].id = mHandle
                            return true
                        end
                    end
                end
            end

        -- [[ laneclear ]]
        elseif isLC and canLC then

            local canCheckT = false
            for i = 1, #lastHitT do
                local unit = lastHitT[i]
                local unitPos = unit.pos
                local mePos = myHero.pos
                local checkT = Game.Timer() < gsoAIO.TS.LHTimers[4].tick
                local mHandle = unit.handle
                if not checkT or (checkT and gsoAIO.TS.LHTimers[4].id ~= mHandle) then
                    if gsoAIO.Utils:_getDistance(mePos, unitPos) < meRange + unit.boundingRadius then
                        canCheckT = true
                        break
                    end
                end
            end
            if not canCheckT or (canCheckT and Game.Timer() < gsoAIO.Orb.lAttack + gsoAIO.Orb.animT) then
                for i = 1, #lastHitT do
                    local minion = lastHitT[i]
                    local minionPos = minion.pos
                    local mePos = myHero.pos
                    local checkT = Game.Timer() < gsoAIO.TS.LHTimers[4].tick
                    local mHandle = minion.handle
                    if not checkT or (checkT and gsoAIO.TS.LHTimers[4].id ~= mHandle) then
                        local distance = gsoAIO.Utils:_getDistance(mePos, minionPos)
                        if distance < 1150 and self:_castQ(minion, minionPos, mePos) then
                            gsoAIO.TS.LHTimers[0].tick = Game.Timer() + 0.75
                            gsoAIO.TS.LHTimers[0].id = mHandle
                            return true
                        end
                    end
                end
            end
            if not almostLH and not self.shouldWait then
                canCheckT = false
                for i = 1, #gsoAIO.OB.enemyHeroes do
                    local unit = gsoAIO.OB.enemyHeroes[i]
                    local unitPos = unit.pos
                    local mePos = myHero.pos
                    if gsoAIO.Utils:_getDistance(mePos, unitPos) < meRange + unit.boundingRadius then
                        canCheckT = true
                        break
                    end
                end
                if not canCheckT or (canCheckT and Game.Timer() < gsoAIO.Orb.lAttack + gsoAIO.Orb.animT) then
                    for i = 1, #gsoAIO.OB.enemyHeroes do
                        local unit = gsoAIO.OB.enemyHeroes[i]
                        local unitPos = unit.pos
                        local mePos = myHero.pos
                        local distance = gsoAIO.Utils:_getDistance(mePos, unitPos)
                        if gsoAIO.Utils:_valid(unit, true) and distance < 1150 and self:_castQ(unit, unitPos, mePos) then return true end
                    end
                end
                canCheckT = false
                for i = 1, #laneClearT do
                    local unit = laneClearT[i]
                    local unitPos = unit.pos
                    local mePos = myHero.pos
                    if gsoAIO.Utils:_getDistance(mePos, unitPos) < meRange + unit.boundingRadius then
                        canCheckT = true
                        break
                    end
                end
                if not canCheckT or (canCheckT and Game.Timer() < gsoAIO.Orb.lAttack + gsoAIO.Orb.animT) then
                    for i = 1, #laneClearT do
                        local minion = laneClearT[i]
                        local minionPos = minion.pos
                        local mePos = myHero.pos
                        local distance = gsoAIO.Utils:_getDistance(myHero.pos, minionPos)
                        if distance < 1150 and self:_castQ(minion, minionPos, mePos) then return true end
                    end
                end
            end
        end
    end
    return false
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoEzreal:_tick()
    local getTick = GetTickCount()
    if getTick - self.lastE > 1000 and Game.CanUseSpell(_E) == 0 then
        local dActions = gsoAIO.Spells.delayedSpell
        for k,v in pairs(dActions) do
            if k == 2 then
                if gsoAIO.Orb.dActionsC == 0 then
                    v[1]()
                    gsoAIO.Orb.dActions[GetTickCount()] = { function() return 0 end, 50 }
                    gsoAIO.Orb.enableAA = false
                    gsoAIO.Orb.dActionsC = gsoAIO.Orb.dActionsC + 1
                    self.lastE = GetTickCount()
                    gsoAIO.Spells.delayedSpell[k] = nil
                    break
                end
                if GetTickCount() - v[2] > 125 then
                    gsoAIO.Spells.delayedSpell[k] = nil
                end
                break
            end
        end
    end
    
    -- AUTO Q :
    local qMinus = getTick - self.lastQ
    local qMinuss = getTick - gsoAIO.Spells.lastQ
    local wMinus = getTick - self.lastW
    local wMinuss = getTick - gsoAIO.Spells.lastW
    local eMinus = getTick - self.lastE
    local eMinuss = getTick - gsoAIO.Spells.lastE
    local rMinuss = getTick - gsoAIO.Spells.lastR
    local canQTime = qMinus > 1000 and qMinuss > 1000 and wMinus > 450 and wMinuss > 450 and eMinus > 650 and eMinuss > 650 and rMinuss > 1500
    local isComboQ = isCombo and gsoAIO.Load.menu.gsoezreal.qset.combo:Value()
    local isHarassQ = isHarass and gsoAIO.Load.menu.gsoezreal.qset.harass:Value()
    local isQReady = canQTime and gsoAIO.Utils:_isReady(_Q)
    if isQReady and not isComboQ and not isHarassQ then
        local manaPercent = 100 * myHero.mana / myHero.maxMana
        local isAutoQ = gsoAIO.Load.menu.gsoezreal.autoq.enable:Value() and manaPercent > gsoAIO.Load.menu.gsoezreal.autoq.mana:Value()
        local meRange = myHero.range + myHero.boundingRadius
        if isAutoQ then
            for i = 1, #gsoAIO.OB.enemyHeroes do
                local unit = gsoAIO.OB.enemyHeroes[i]
                local unitPos = unit.pos
                local mePos = myHero.pos
                local distance = gsoAIO.Utils:_getDistance(mePos, unitPos)
                local isTargetAA = distance < meRange + unit.boundingRadius
                if gsoAIO.Utils:_valid(unit, true) and distance < 1150 and ( not isTargetAA or (isTargetAA and gsoAIO.Vars.ezrealCanQ) ) then
                    local sQ = { delay = 0.25, range = 1150, width = 60, speed = 2000, sType = "line", col = true }
                    local castpos,HitChance, pos = gsoAIO.TPred:GetBestCastPosition(unit, sQ.delay, sQ.width*0.5, sQ.range, sQ.speed, mePos, sQ.col, sQ.sType)
                    local distMeToPredPos = gsoAIO.Utils:_getDistance(mePos, castpos)
                    local distUnitToPredPos = gsoAIO.Utils:_getDistance(unitPos, castpos)
                    if HitChance > 0 and castpos:ToScreen().onScreen and distMeToPredPos < sQ.range and distUnitToPredPos < 200 then
                        local cPos = cursorPos
                        Control.SetCursorPos(castpos)
                        gsoAIO.Orb.setCursor = castpos
                        Control.KeyDown(HK_Q)
                        Control.KeyUp(HK_Q)
                        self.lastQ = GetTickCount()
                        gsoAIO.Orb.dActions[GetTickCount()] = { function() Control.SetCursorPos(cPos.x, cPos.y) end, 50 }
                        gsoAIO.Orb.dActionsC = gsoAIO.Orb.dActionsC + 1
                        gsoAIO.Vars.ezrealCanW = false
                        break
                    end
                end
            end
        end
    end
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoEzreal:_draw()
    if gsoAIO.Load.menu.gsodraw.texts1.enableautoq:Value() then
        local mePos = myHero.pos:To2D()
        local isCustom = gsoAIO.Load.menu.gsodraw.texts1.customautoq:Value()
        local posX = isCustom and gsoAIO.Load.menu.gsodraw.texts1.xautoq:Value() or mePos.x - 50
        local posY = isCustom and gsoAIO.Load.menu.gsodraw.texts1.yautoq:Value() or mePos.y
        if gsoAIO.Load.menu.gsoezreal.autoq.enable:Value() then
            Draw.Text("Auto Q Enabled", gsoAIO.Load.menu.gsodraw.texts1.sizeautoq:Value(), posX, posY, gsoAIO.Load.menu.gsodraw.texts1.colorautoqe:Value()) 
        else
            Draw.Text("Auto Q Disabled", gsoAIO.Load.menu.gsodraw.texts1.sizeautoq:Value(), posX, posY, gsoAIO.Load.menu.gsodraw.texts1.colorautoqd:Value()) 
        end
    end
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
class "__gsoVayne"
--
--
--
function __gsoVayne:__init()
    require "MapPositionGOS"
    self.lastQ = 0
    self.lastE = 0
    self.lastReset = 0
    gsoAIO.Orb.baseAASpeed = 0.658
    gsoAIO.Orb.baseWindUp = 0.1754385
    gsoAIO.Vars.drawRanges = { q = true, qrange = 300, e = true, erange = 550 }
    gsoAIO.Mana.spellData = { q = true, qm = 30, e = true, em = 90, r = true, rm = 80 }
    gsoAIO.Mana.priority = { [_R] = 1, [_Q] = 2, [_E] = 3 }
    gsoAIO.Vars:_setChampMenu(function() return self:_menu() end)
    gsoAIO.Vars:_setCanAttack(function(target) return self:_canAttack(target) end)
    gsoAIO.Vars:_setOnTick(function() self:_tick() end)
    gsoAIO.Vars:_setBonusDmg(function() return 3 end)
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoVayne:_menu()
    gsoAIO.Load.menu:MenuElement({name = "Vayne", id = "gsovayne", type = MENU, leftIcon = gsoAIO.Vars.Icons["vayne"] })
        gsoAIO.Load.menu.gsovayne:MenuElement({name = "Q settings", id = "qset", type = MENU })
            gsoAIO.Load.menu.gsovayne.qset:MenuElement({id = "combo", name = "Combo", value = true})
            gsoAIO.Load.menu.gsovayne.qset:MenuElement({id = "harass", name = "Harass", value = false})
        gsoAIO.Load.menu.gsovayne:MenuElement({name = "E settings", id = "eset", type = MENU })
            gsoAIO.Load.menu.gsovayne.eset:MenuElement({id = "combo", name = "Combo", value = true})
            gsoAIO.Load.menu.gsovayne.eset:MenuElement({id = "harass", name = "Harass", value = false})
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoVayne:_canMove()
    local getTick = GetTickCount() - (gsoAIO.Utils.maxPing*1000)
    local qMinus = getTick - self.lastQ
    local qMinuss = getTick - gsoAIO.Spells.lastQ
    local eMinus = checkTick - self.lastE
    local eMinuss = checkTick - gsoAIO.Spells.lastE
    if qMinus > 250 and qMinuss > 250 and eMinus > 500 and eMinuss > 500 then
        return true
    end
    return false
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoVayne:_canAttack(target)
    local isTarget = target and target.type == Obj_AI_Hero
    local checkTick = GetTickCount() - (gsoAIO.Utils.maxPing*1000)
    local qMinus = checkTick - self.lastQ
    local qMinuss = checkTick - gsoAIO.Spells.lastQ
    local eMinus = checkTick - self.lastE
    local eMinuss = checkTick - gsoAIO.Spells.lastE
    if Game.Timer() > gsoAIO.Orb.lAttack + gsoAIO.Orb.windUpT + 0.1 + gsoAIO.Utils.maxPing then
        local isCombo = gsoAIO.Load.menu.orb.keys.combo:Value()
        local isHarass = gsoAIO.Load.menu.orb.keys.harass:Value()
        local afterAttack = Game.Timer() < gsoAIO.Orb.lAttack + ( gsoAIO.Orb.animT * 0.75 )
        if isTarget and afterAttack then
            
            -- USE E :
            local canETime = eMinus > 1000 and eMinuss > 1000
            local isComboE = isCombo and gsoAIO.Load.menu.gsovayne.eset.combo:Value()
            local isHarassE = isHarass and gsoAIO.Load.menu.gsovayne.eset.harass:Value()
            local isEReady = (isComboE or isHarassE) and canETime and gsoAIO.Utils:_isReady(_E)
            if isEReady and gsoAIO.Vars.vayneCanE then
                local targetPos = target.pos
                local mePos = myHero.pos
                local ePred = target:GetPrediction(2000,0.15)
                local canEonTarget = ePred and gsoAIO.Utils:_getDistance(ePred, targetPos) < 500 and not gsoAIO.Utils:_nearUnit(targetPos, target.networkID)
                if canEonTarget and gsoAIO.Utils:_checkWall(mePos, ePred, 475) and gsoAIO.Utils:_checkWall(mePos, targetPos, 475) then
                    self.lastE = GetTickCount()
                    Control.KeyDown(83)
                    Control.KeyUp(83)
                    local cPos = cursorPos
                    Control.SetCursorPos(targetPos)
                    gsoAIO.Orb.setCursor = targetPos
                    Control.KeyDown(HK_E)
                    Control.KeyUp(HK_E)
                    gsoAIO.Orb.dActions[GetTickCount()] = { function() Control.SetCursorPos(cPos.x, cPos.y) end, 50 }
                    gsoAIO.Orb.dActionsC = gsoAIO.Orb.dActionsC + 1
                    gsoAIO.Vars.vayneCanQ = false
                    return false
                end
            end
        end
        if not isTarget or afterAttack then
        
            -- USE Q :
            local canQTime = qMinus > 1000 and qMinuss > 1000
            local isComboQ = isCombo and gsoAIO.Load.menu.gsovayne.qset.combo:Value()
            local isHarassQ = isHarass and gsoAIO.Load.menu.gsovayne.qset.harass:Value()
            local isQReady = (isComboQ or isHarassQ) and canQTime and gsoAIO.Utils:_isReady(_Q)
            if isQReady and (gsoAIO.Vars.vayneCanQ or ( eMinus > 500 and eMinuss > 500 ) ) then
                local mePos = myHero.pos
                local meRange = myHero.range + myHero.boundingRadius
                for i = 1, #gsoAIO.OB.enemyHeroes do
                    local hero = gsoAIO.OB.enemyHeroes[i]
                    local heroPos = hero.pos
                    local distToMouse = gsoAIO.Utils:_getDistance(mePos, mousePos)
                    local distToHero = gsoAIO.Utils:_getDistance(mePos, heroPos)
                    local distToEndPos = gsoAIO.Utils:_getDistance(mePos, hero.pathing.endPos)
                    local extRange
                    if distToEndPos > distToHero then
                        extRange = distToMouse > 200 and 200 or distToMouse
                    else
                        extRange = distToMouse > 300 and 300 or distToMouse
                    end
                    local extPos = mePos + (mousePos-mePos):Normalized() * extRange
                    local distEnemyToExt = gsoAIO.Utils:_getDistance(extPos, heroPos)
                    if gsoAIO.Utils:_valid(hero, true) and distEnemyToExt < meRange + hero.boundingRadius then
                        canQtoPos = true
                        Control.KeyDown(HK_Q)
                        Control.KeyUp(HK_Q)
                        self.lastQ = GetTickCount()
                        gsoAIO.Vars.vayneCanE = false
                        return false
                    end
                end
            end
        end
    end
    if qMinus > 450 and qMinuss > 450 and eMinus > 650 and eMinuss > 650 then
        return true
    end
    return false
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoVayne:_tick()
    for i = 0, myHero.buffCount do
        local buff = myHero:GetBuff(i)
        if buff and buff.count > 0 and buff.name == "vaynetumblebonus" and Game.Timer() > self.lastReset + 1.2 and buff.duration > 5.8 then
            self.lastReset = Game.Timer()
            gsoAIO.Orb.aaReset = true
        end
    end
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
class "__gsoTeemo"
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoTeemo:__init()
    self.lastQ = 0
    self.lastW = 0
    gsoAIO.Orb.baseAASpeed = 0.69
    gsoAIO.Orb.baseWindUp = 0.215743
    gsoAIO.Vars.drawRanges = { q = true, qrange = 680, r = true, rfunc = function() return self:_rRange() end }
    gsoAIO.Mana.spellData = { q = true, qf = function() return 65 + (5*myHero:GetSpellData(_Q).level) end, w = true, wm = 40, r = true, rm = 75 }
    gsoAIO.Mana.priority = { [_Q] = 1, [_W] = 2, [_R] = 3 }
    gsoAIO.Vars:_setBonusDmg(function() return 3 end)
    gsoAIO.Vars:_setChampMenu(function() return self:_menu() end)
    gsoAIO.Vars:_setCanMove(function() return self:_canMove() end)
    gsoAIO.Vars:_setCanAttack(function(target) return self:_canAttack(target) end)
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoTeemo:_rRange()
    local rLvl = myHero:GetSpellData(_R).level
    if rLvl == 0 then rLvl = 1 end
    return 150 + ( 250 * rLvl )
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoTeemo:_menu()
    gsoAIO.Load.menu:MenuElement({name = "Teemo", id = "gsoteemo", type = MENU, leftIcon = gsoAIO.Vars.Icons["teemo"] })
        gsoAIO.Load.menu.gsoteemo:MenuElement({name = "Q settings", id = "qset", type = MENU })
            gsoAIO.Load.menu.gsoteemo.qset:MenuElement({id = "combo", name = "Combo", value = true})
            gsoAIO.Load.menu.gsoteemo.qset:MenuElement({id = "harass", name = "Harass", value = false})
        gsoAIO.Load.menu.gsoteemo:MenuElement({name = "W settings", id = "wset", type = MENU })
            gsoAIO.Load.menu.gsoteemo.wset:MenuElement({id = "mindist", name = "Min. distance to enemy", value = 850, min = 680, max = 1250, step = 10 })
            gsoAIO.Load.menu.gsoteemo.wset:MenuElement({id = "combo", name = "Combo", value = true})
            gsoAIO.Load.menu.gsoteemo.wset:MenuElement({id = "harass", name = "Harass", value = false})
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoTeemo:_canMove()
    local getTick = GetTickCount() - (gsoAIO.Utils.maxPing*1000)
    local qMinus = getTick - self.lastQ
    local qMinuss = getTick - gsoAIO.Spells.lastQ
    if qMinus > 250 and qMinuss > 250 then
        return true
    end
    return false
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoTeemo:_canAttack(target)
    local isTarget = target and target.type == Obj_AI_Hero
    local getTick = GetTickCount() - (gsoAIO.Utils.maxPing*1000)
    local qMinus = getTick - self.lastQ
    local qMinuss = getTick - gsoAIO.Spells.lastQ
    local wMinus = getTick - self.lastW
    local wMinuss = getTick - gsoAIO.Spells.lastW
    local rMinuss = getTick - gsoAIO.Spells.lastR
    if Game.Timer() > gsoAIO.Orb.lAttack + gsoAIO.Orb.windUpT + 0.1 + gsoAIO.Utils.maxPing then
        local isCombo = gsoAIO.Load.menu.orb.keys.combo:Value()
        local isHarass = gsoAIO.Load.menu.orb.keys.harass:Value()
        local afterAttack = Game.Timer() < gsoAIO.Orb.lAttack + ( gsoAIO.Orb.animT * 0.9 )
        if not isTarget or afterAttack then
            
            -- USE Q :
            local canQTime = qMinus > 1000 and qMinuss > 1000 and rMinuss > 1050
            local isComboQ = isCombo and gsoAIO.Load.menu.gsoteemo.qset.combo:Value()
            local isHarassQ = isHarass and gsoAIO.Load.menu.gsoteemo.qset.harass:Value()
            local isQReady = (isComboQ or isHarassQ) and canQTime and gsoAIO.Utils:_isReady(_Q)
            if isQReady then
                local qTarget = isTarget and target or gsoAIO.TS:_getTarget(680, false, false)
                local qTargetPos = qTarget and qTarget.pos or nil
                if qTargetPos and not gsoAIO.Utils:_nearUnit(qTargetPos, qTarget.networkID) then
                    local cPos = cursorPos
                    self.lastQ = GetTickCount()
                    Control.SetCursorPos(qTargetPos)
                    gsoAIO.Orb.setCursor = qTargetPos
                    Control.KeyDown(HK_Q)
                    Control.KeyUp(HK_Q)
                    gsoAIO.Orb.dActions[GetTickCount()] = { function() Control.SetCursorPos(cPos.x, cPos.y) end, 50 }
                    gsoAIO.Orb.dActionsC = gsoAIO.Orb.dActionsC + 1
                    return false
                end
            end
            
            -- USE W :
            local canWTime = wMinus > 1000 and wMinuss > 1000
            local isComboW = isCombo and gsoAIO.Load.menu.gsoteemo.wset.combo:Value()
            local isHarassW = isHarass and gsoAIO.Load.menu.gsoteemo.wset.harass:Value()
            local isWReady = (isComboW or isHarassW) and canWTime and gsoAIO.Utils:_isReady(_W)
            if isWReady then
                local mePos = myHero.pos
                for i = 1, #gsoAIO.OB.enemyHeroes do
                    local unit = gsoAIO.OB.enemyHeroes[i]
                    local unitPos = unit.pos
                    if gsoAIO.Utils:_getDistance(mePos, unitPos) < gsoAIO.Load.menu.gsoteemo.wset.mindist:Value() then
                        self.lastW = GetTickCount()
                        Control.KeyDown(HK_W)
                        Control.KeyUp(HK_W)
                    end
                end
            end
        end
    end
    if qMinus > 350 and qMinuss > 350 and rMinuss > 700 then
        return true
    end
    return false
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
class "__gsoSivir"
--
--
--
function __gsoSivir:__init()
    self.lastQ = 0
    self.lastW = 0
    self.lastReset = 0
    self.asNoW = myHero.attackSpeed
    gsoAIO.Orb.baseAASpeed = 0.625
    gsoAIO.Orb.baseWindUp = 0.1199999
    gsoAIO.Vars.drawRanges = { q = true, qrange = 1250, r = true, rrange = 1000 }
    gsoAIO.Mana.spellData = { q = true, qf = function() return 60 + (10*myHero:GetSpellData(_Q).level) end, w = true, wm = 60, r = true, rm = 100 }
    gsoAIO.Mana.priority = { [_R] = 1, [_W] = 2, [_Q] = 3 }
    gsoAIO.Vars:_setChampMenu(function() return self:_menu() end)
    gsoAIO.Vars:_setAASpeed(function() return self:_aaSpeed() end)
    gsoAIO.Vars:_setCanMove(function() return self:_canMove() end)
    gsoAIO.Vars:_setCanAttack(function(target) return self:_canAttack(target) end)
    gsoAIO.Vars:_setOnTick(function() self:_tick() end)
    gsoAIO.Vars:_setBonusDmg(function() return 3 end)
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoSivir:_menu()
    gsoAIO.Load.menu:MenuElement({name = "Sivir", id = "gsosivir", type = MENU, leftIcon = gsoAIO.Vars.Icons["sivir"] })
        gsoAIO.Load.menu.gsosivir:MenuElement({name = "Q settings", id = "qset", type = MENU })
            gsoAIO.Load.menu.gsosivir.qset:MenuElement({id = "combo", name = "Combo", value = true})
            gsoAIO.Load.menu.gsosivir.qset:MenuElement({id = "harass", name = "Harass", value = false})
        gsoAIO.Load.menu.gsosivir:MenuElement({name = "W settings", id = "wset", type = MENU })
            gsoAIO.Load.menu.gsosivir.wset:MenuElement({id = "combo", name = "Combo", value = true})
            gsoAIO.Load.menu.gsosivir.wset:MenuElement({id = "harass", name = "Harass", value = false})
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoSivir:_aaSpeed()
    local wDiff = GetTickCount() - gsoAIO.Spells.lastW - (gsoAIO.Utils.maxPing*1000)
    if wDiff > 3500 and wDiff < 4500 then
        return self.asNoW
    end
    return myHero.attackSpeed
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoSivir:_canMove()
    local getTick = GetTickCount() - (gsoAIO.Utils.maxPing*1000)
    local qMinus = getTick - self.lastQ
    local qMinuss = getTick - gsoAIO.Spells.lastQ
    if qMinus > 250 and qMinuss > 250 then
        return true
    end
    return false
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoSivir:_canAttack(target)
    local isTarget = target and target.type == Obj_AI_Hero
    local getTick = GetTickCount() - (gsoAIO.Utils.maxPing*1000)
    local qMinus = getTick - self.lastQ
    local qMinuss = getTick - gsoAIO.Spells.lastQ
    local wMinus = getTick - self.lastW
    local wMinuss = getTick - gsoAIO.Spells.lastW
    if Game.Timer() > gsoAIO.Orb.lAttack + gsoAIO.Orb.windUpT + 0.1 + gsoAIO.Utils.maxPing then
        local isCombo = gsoAIO.Load.menu.orb.keys.combo:Value()
        local isHarass = gsoAIO.Load.menu.orb.keys.harass:Value()
        local afterAttack = Game.Timer() < gsoAIO.Orb.lAttack + ( gsoAIO.Orb.animT * 0.75 )
        if isTarget and afterAttack then
            
            -- USE W:
            local canWTime = wMinus > 1000 and wMinuss > 1000
            local isComboW = isCombo and gsoAIO.Load.menu.gsosivir.wset.combo:Value()
            local isHarassW = isHarass and gsoAIO.Load.menu.gsosivir.wset.harass:Value()
            local isWReady = (isComboW or isHarassW) and canWTime and gsoAIO.Utils:_isReady(_W)
                  isWReady = isWReady and ( not isTarget or (isTarget and gsoAIO.Vars.sivirCanW) )
            if isWReady then
                self.asNoW = myHero.attackSpeed
                Control.KeyDown(HK_W)
                Control.KeyUp(HK_W)
                self.lastW = GetTickCount()
                gsoAIO.Vars.sivirCanQ = false
                return false
            end
        end
        if not isTarget or afterAttack then
            
            -- USE Q :
            local canQTime = qMinus > 1000 and qMinuss > 1000
            local isComboQ = isCombo and gsoAIO.Load.menu.gsosivir.qset.combo:Value()
            local isHarassQ = isHarass and gsoAIO.Load.menu.gsosivir.qset.harass:Value()
            local isQReady = (isComboQ or isHarassQ) and canQTime and gsoAIO.Utils:_isReady(_Q)
                  isQReady = isQReady and ( not isTarget or (isTarget and gsoAIO.Vars.sivirCanQ) )
            if isQReady then
                local qTarget = isTarget and target or gsoAIO.TS:_getTarget(1250, false, false)
                local qTargetPos = qTarget and qTarget.pos or nil
                if qTargetPos then
                    local sQ = { delay = 0.25, range = 1250, width = 60, speed = 1350, sType = "line", col = false }
                    local mePos = myHero.pos
                    local castpos,HitChance,pos = gsoAIO.TPred:GetBestCastPosition(qTarget, sQ.delay, sQ.width*0.5, sQ.range, sQ.speed, mePos, sQ.col, sQ.sType)
                    if HitChance > 0 and castpos:ToScreen().onScreen and gsoAIO.Utils:_getDistance(mePos, castpos) < sQ.range and gsoAIO.Utils:_getDistance(qTargetPos, castpos) < 500 then
                        local cPos = cursorPos
                        Control.SetCursorPos(castpos)
                        gsoAIO.Orb.setCursor = castpos
                        Control.KeyDown(HK_Q)
                        Control.KeyUp(HK_Q)
                        self.lastQ = GetTickCount()
                        gsoAIO.Orb.dActions[GetTickCount()] = { function() Control.SetCursorPos(cPos.x, cPos.y) end, 50 }
                        gsoAIO.Orb.dActionsC = gsoAIO.Orb.dActionsC + 1
                        gsoAIO.Vars.sivirCanW = false
                        return false
                    end
                end
            end
        end
    end
    if qMinus > 350 and qMinuss > 350 then
        return true
    end
    return false
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoSivir:_tick()
    for i = 0, myHero.buffCount do
        local buff = myHero:GetBuff(i)
        if buff and buff.count > 0 and buff.name == "SivirWMarker" and Game.Timer() > self.lastReset + 3 and buff.duration > 3 then
            self.lastReset = Game.Timer()
            gsoAIO.Orb.aaReset = true
        end
    end
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
class "__gsoTristana"
--
--
--
function __gsoTristana:__init()
    self.lastQ = 0
    self.lastW = 0
    self.lastE = 0
    self.lastR = 0
    self.asNoQ = 0
    self.eData = gsoAIO.Dmg.Damages["Tristana"].e
    self.rData = gsoAIO.Dmg.Damages["Tristana"].r
    self.getEData =
        function(stacks)
            return
            {
                dmgAP = self.eData.dmgAP(),
                dmgAD = self.eData.dmgAD(stacks),
                dmgType = self.eData.dmgType
            }
        end
    self.getRData =
        function()
            return
            {
                dmgAP = self.rData.dmgAP(),
                dmgType = self.rData.dmgType
            }
        end
    gsoAIO.Orb.baseAASpeed = 0.656
    gsoAIO.Orb.baseWindUp = 0.1480066
    gsoAIO.Vars.drawRanges = { w = true, wrange = 900 }
    gsoAIO.Mana.spellData = { w = true, wm = 60, e = true, ef = function() return 65 + (5*myHero:GetSpellData(_E).level) end, r = true, rm = 100 }
    gsoAIO.Mana.priority = { [_W] = 1, [_R] = 2, [_E] = 3 }
    gsoAIO.Vars:_setChampMenu(function() return self:_menu() end)
    gsoAIO.Vars:_setAASpeed(function() return self:_aaSpeed() end)
    gsoAIO.Vars:_setCanMove(function() return self:_canMove() end)
    gsoAIO.Vars:_setCanAttack(function(target) return self:_canAttack(target) end)
    gsoAIO.Vars:_setOnTick(function() self:_tick() end)
    gsoAIO.Vars:_setBonusDmg(function() return 3 end)
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoTristana:_menu()
    gsoAIO.Load.menu:MenuElement({name = "Tristana", id = "gsotristana", type = MENU, leftIcon = gsoAIO.Vars.Icons["tristana"] })
        gsoAIO.Load.menu.gsotristana:MenuElement({name = "Q settings", id = "qset", type = MENU })
            gsoAIO.Load.menu.gsotristana.qset:MenuElement({id = "combo", name = "Combo", value = true})
            gsoAIO.Load.menu.gsotristana.qset:MenuElement({id = "harass", name = "Harass", value = false})
        gsoAIO.Load.menu.gsotristana:MenuElement({name = "E settings", id = "eset", type = MENU })
            gsoAIO.Load.menu.gsotristana.eset:MenuElement({id = "combo", name = "Combo", value = true})
            gsoAIO.Load.menu.gsotristana.eset:MenuElement({id = "harass", name = "Harass", value = false})
        gsoAIO.Load.menu.gsotristana:MenuElement({name = "R settings", id = "rset", type = MENU })
            gsoAIO.Load.menu.gsotristana.rset:MenuElement({id = "ks", name = "KS", value = true})
            gsoAIO.Load.menu.gsotristana.rset:MenuElement({id = "kse", name = "KS only E + R", value = false})
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoTristana:_aaSpeed()
    local qDiff = GetTickCount() - gsoAIO.Spells.lastQ
    if qDiff > 7000 and qDiff < 8000 then
        return self.asNoQ
    end
    return myHero.attackSpeed
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoTristana:_canMove()
    local getTick = GetTickCount() - (gsoAIO.Utils.maxPing*1000)
    local eMinus = getTick - self.lastE
    local rMinus = getTick - self.lastR
    local wMinuss = getTick - gsoAIO.Spells.lastW
    local eMinuss = getTick - gsoAIO.Spells.lastE
    local rMinuss = getTick - gsoAIO.Spells.lastR
    if wMinuss > 500 then
        return true
    end
    return false
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoTristana:_canAttack(target)
    local isTarget = target and target.type == Obj_AI_Hero
    local getTick = GetTickCount() - (gsoAIO.Utils.maxPing*1000)
    local qMinus = getTick - self.lastQ
    local eMinus = getTick - self.lastE
    local rMinus = getTick - self.lastR
    local qMinuss = getTick - gsoAIO.Spells.lastQ
    local wMinuss = getTick - gsoAIO.Spells.lastW
    local eMinuss = getTick - gsoAIO.Spells.lastE
    local rMinuss = getTick - gsoAIO.Spells.lastR
    if isTarget and Game.Timer() > gsoAIO.Orb.lAttack + gsoAIO.Orb.windUpT + 0.1 + gsoAIO.Utils.maxPing then
        
        local isCombo = gsoAIO.Load.menu.orb.keys.combo:Value()
        local isHarass = gsoAIO.Load.menu.orb.keys.harass:Value()
        
        -- USE R :
        local canRTime = wMinuss > 250 and eMinus > 450 and eMinuss > 450 and rMinus > 1000 and rMinuss > 1000
        local isRReady = (isCombo or isHarass) and canRTime and gsoAIO.Load.menu.gsotristana.rset.ks:Value() and gsoAIO.Utils:_isReady(_R)
        if isRReady then
            local mePos = myHero.pos
            local meRange = myHero.range + ( myHero.boundingRadius * 0.5 )
            for i = 1, #gsoAIO.OB.enemyHeroes do
                local unit = gsoAIO.OB.enemyHeroes[i]
                local unitPos = unit and unit.pos or nil
                local canRonUnit = unitPos and gsoAIO.Utils:_valid(unit, false) and gsoAIO.Utils:_getDistance(unitPos, mePos) < meRange + ( unit.boundingRadius * 0.5 )
                      canRonUnit = canRonUnit and not gsoAIO.Utils:_nearUnit(unitPos, unit.networkID)
                if canRonUnit then
                    local rDmg = gsoAIO.Dmg.PredHP(unit, self.getRData())
                    local checkEDmg = gsoAIO.Vars.tristanaETar and gsoAIO.Vars.tristanaETar.unit.networkID == unit.networkID
                    local eDmg = checkEDmg and gsoAIO.Dmg.PredHP(unit, self.getEData(gsoAIO.Vars.tristanaETar.stacks)) or 0
                    local unitKillable = eDmg + rDmg > unit.health + (unit.hpRegen * 2)
                    if unitKillable then
                        local cPos = cursorPos
                        Control.SetCursorPos(unitPos)
                        gsoAIO.Orb.setCursor = unitPos
                        Control.KeyDown(HK_R)
                        Control.KeyUp(HK_R)
                        self.lastR = GetTickCount()
                        gsoAIO.Orb.dActions[GetTickCount()] = { function() Control.SetCursorPos(cPos.x, cPos.y) end, 50 }
                        gsoAIO.Orb.dActionsC = gsoAIO.Orb.dActionsC + 1
                        gsoAIO.Orb.lMove = 0
                        return false
                    end
                end
            end
        end
        
        -- USE E :
        local canETime = wMinuss > 250 and eMinus > 1000 and eMinuss > 1000 and rMinus > 600 and rMinuss > 600
        local isComboE = isCombo and gsoAIO.Load.menu.gsotristana.eset.combo:Value()
        local isHarassE = isHarass and gsoAIO.Load.menu.gsotristana.eset.harass:Value()
        local isEReady = (isComboE or isHarassE) and canETime and gsoAIO.Utils:_isReady(_E) and Game.Timer() > gsoAIO.Orb.lAttack + (gsoAIO.Orb.animT * 0.5)
        if isEReady then
            local targetPos = target.pos
            local targetID = target.networkID
            if not gsoAIO.Utils:_nearUnit(targetPos, targetID) then
                local cPos = cursorPos
                self.lastE = GetTickCount()
                Control.SetCursorPos(targetPos)
                gsoAIO.Orb.setCursor = targetPos
                Control.KeyDown(HK_E)
                Control.KeyUp(HK_E)
                gsoAIO.Orb.dActions[GetTickCount()] = { function() Control.SetCursorPos(cPos.x, cPos.y) end, 50 }
                gsoAIO.Orb.dActionsC = gsoAIO.Orb.dActionsC + 1
                gsoAIO.Vars.tristanaETar = { id = targetID, stacks = 1, unit = target }
                gsoAIO.Orb.lMove = 0
                return false
            end
        end
        
        -- USE Q :
        local canQTime = qMinus > 1000 and qMinuss > 1000 and wMinuss > 750
        local isComboQ = isCombo and gsoAIO.Load.menu.gsotristana.qset.combo:Value()
        local isHarassQ = isHarass and gsoAIO.Load.menu.gsotristana.qset.harass:Value()
        local isQReady = (isComboQ or isHarassQ) and canQTime and gsoAIO.Utils:_isReady(_Q)
        if isQReady then
            self.asNoQ = myHero.attackSpeed
            self.lastQ = GetTickCount()
            Control.KeyDown(HK_Q)
            Control.KeyUp(HK_Q)
        end
    end
    
    -- CHECK IF CAN ATTACK :
    if wMinuss > 800 then
        return true
    end
    
    -- CAN NOT ATTACK IN SPELL WINDUP TIME :
    return false
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoTristana:_tick()
    for i = 1, #gsoAIO.OB.enemyHeroes do
        local hero  = gsoAIO.OB.enemyHeroes[i]
        for i = 0, hero.buffCount do
            local buff = hero:GetBuff(i)
            if buff and buff.count > 0 and buff.duration > 1 and buff.name:lower() == "tristanaechargesound" and gsoAIO.Vars.tristanaETar and not gsoAIO.Vars.tristanaETar.endTime then
                gsoAIO.Vars.tristanaETar.endTime = Game.Timer() + buff.duration - gsoAIO.Utils.minPing
            end
        end
    end
    if gsoAIO.Vars.tristanaETar and gsoAIO.Vars.tristanaETar.endTime and Game.Timer() > gsoAIO.Vars.tristanaETar.endTime then
        gsoAIO.Vars.tristanaETar = nil
    end
    local getTick = GetTickCount()
    if getTick - self.lastW > 1000 and Game.CanUseSpell(_W) == 0 then
        local dActions = gsoAIO.Spells.delayedSpell
        for k,v in pairs(dActions) do
            if k == 1 then
                if gsoAIO.Orb.dActionsC == 0 then
                    v[1]()
                    gsoAIO.Orb.dActions[GetTickCount()] = { function() return 0 end, 50 }
                    gsoAIO.Orb.dActionsC = gsoAIO.Orb.dActionsC + 1
                    self.lastW = GetTickCount()
                    gsoAIO.Spells.delayedSpell[k] = nil
                    gsoAIO.Orb.lMove = 0
                    break
                end
                if GetTickCount() - v[2] > 125 then
                    gsoAIO.Spells.delayedSpell[k] = nil
                end
                break
            end
        end
    end
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
class "__gsoJinx"
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoJinx:__init()
    self.lastQ = 0
    self.lastW = 0
    self.lastE = 0
    self.hasQBuff = false
    gsoAIO.Orb.baseAASpeed = 0.625
    gsoAIO.Orb.baseWindUp = 0.17708122
    gsoAIO.Vars.drawRanges = { q = true, qfunc = function() return self:_qRange() end, w = true, wrange = 1450, e = true, erange = 900 }
    gsoAIO.Mana.spellData = { w = true, wf = function() return 40 + (10*myHero:GetSpellData(_W).level) end, e = true, em = 70, r = true, rm = 100 }
    gsoAIO.Mana.priority = { [_E] = 1, [_R] = 2, [_W] = 3 }
    gsoAIO.Vars:_setOnTick(function() self:_tick() end)
    gsoAIO.Vars:_setBonusDmg(function() return 3 end)
    gsoAIO.Vars:_setChampMenu(function() return self:_menu() end)
    gsoAIO.Vars:_setCanMove(function() return self:_canMove() end)
    gsoAIO.Vars:_setCanAttack(function(target) return self:_canAttack(target) end)
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoJinx:_menu()
    gsoAIO.Load.menu:MenuElement({name = "Jinx", id = "gsojinx", type = MENU, leftIcon = gsoAIO.Vars.Icons["jinx"] })
        gsoAIO.Load.menu.gsojinx:MenuElement({name = "Q settings", id = "qset", type = MENU })
            gsoAIO.Load.menu.gsojinx.qset:MenuElement({id = "combo", name = "Combo", value = true})
            gsoAIO.Load.menu.gsojinx.qset:MenuElement({id = "harass", name = "Harass", value = false})
        gsoAIO.Load.menu.gsojinx:MenuElement({name = "W settings", id = "wset", type = MENU })
            gsoAIO.Load.menu.gsojinx.wset:MenuElement({id = "combo", name = "Combo", value = true})
            gsoAIO.Load.menu.gsojinx.wset:MenuElement({id = "harass", name = "Harass", value = false})
        gsoAIO.Load.menu.gsojinx:MenuElement({name = "E settings", id = "eset", type = MENU })
            gsoAIO.Load.menu.gsojinx.eset:MenuElement({id = "combo", name = "Combo", value = true})
            gsoAIO.Load.menu.gsojinx.eset:MenuElement({id = "harass", name = "Harass", value = false})
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoJinx:_qRange()
    if self.hasQBuff then
        return 525 + myHero.boundingRadius + 75
    else
        return 575 + ( 25 * myHero:GetSpellData(_Q).level ) + myHero.boundingRadius + 75
    end
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoJinx:_tick()
    self.hasQBuff = gsoAIO.Utils:_hasBuff(myHero, "jinxq")
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoJinx:_canMove()
    local getTick = GetTickCount() - (gsoAIO.Utils.maxPing*1000)
    local wMinus = getTick - self.lastW
    local wMinuss = getTick - gsoAIO.Spells.lastW
    local rMinuss = getTick - gsoAIO.Spells.lastR
    if wMinus > 500 and wMinuss > 500 and rMinuss > 500 then
        return true
    end
    return false
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoJinx:_canAttack(target)
    local isTarget = target and target.type == Obj_AI_Hero
    local getTick = GetTickCount() - (gsoAIO.Utils.maxPing*1000)
    local qMinus = getTick - self.lastQ
    local qMinuss = getTick - gsoAIO.Spells.lastQ
    local wMinus = getTick - self.lastW
    local wMinuss = getTick - gsoAIO.Spells.lastW
    local eMinus = getTick - self.lastE
    local eMinuss = getTick - gsoAIO.Spells.lastE
    local rMinuss = getTick - gsoAIO.Spells.lastR
    
    if Game.Timer() > gsoAIO.Orb.lAttack + gsoAIO.Orb.windUpT + 0.1 + gsoAIO.Utils.maxPing then
        local mePos = myHero.pos
        local meBB = myHero.boundingRadius
        local afterAttack = Game.Timer() < gsoAIO.Orb.lAttack + ( gsoAIO.Orb.animT * 0.9 )
        local isCombo = gsoAIO.Load.menu.orb.keys.combo:Value()
        local isHarass = gsoAIO.Load.menu.orb.keys.harass:Value()
        
        -- USE E :
        local canETime = wMinus > 550 and wMinuss > 550 and eMinus > 1000 and eMinuss > 1000 and rMinuss > 550
        local isComboE = isCombo and gsoAIO.Load.menu.gsojinx.eset.combo:Value()
        local isHarassE = isHarass and gsoAIO.Load.menu.gsojinx.eset.harass:Value()
        local isEReady = (isComboE or isHarassE) and canETime and gsoAIO.Utils:_isReady(_E)
        if isEReady then
            for i = 1, #gsoAIO.OB.enemyHeroes do
                local unit = gsoAIO.OB.enemyHeroes[i]
                local unitPos = unit and unit.pos or nil
                if unitPos and gsoAIO.Utils:_getDistance(mePos, unitPos) < 900 and gsoAIO.Utils:_isImmobile(unit) and unitPos:ToScreen().onScreen then
                    local cPos = cursorPos
                    Control.SetCursorPos(unitPos)
                    gsoAIO.Orb.setCursor = unitPos
                    Control.KeyDown(HK_E)
                    Control.KeyUp(HK_E)
                    self.lastE = GetTickCount()
                    gsoAIO.Orb.dActions[GetTickCount()] = { function() Control.SetCursorPos(cPos.x, cPos.y) end, 50 }
                    gsoAIO.Orb.dActionsC = gsoAIO.Orb.dActionsC + 1
                    return false
                end
            end
        end
        
        -- USE Q :
        local canQTime = qMinus > 650 and qMinuss > 650 and wMinus > 550 and wMinuss > 550 and rMinuss > 550
        local isComboQ = isCombo and gsoAIO.Load.menu.gsojinx.qset.combo:Value()
        local isHarassQ = isHarass and gsoAIO.Load.menu.gsojinx.qset.harass:Value()
        local isQReady = (isComboQ or isHarassQ) and canQTime and gsoAIO.Utils:_isReady(_Q)
        if isQReady then
            local canCastQ = false
            local hasQBuff = self.hasQBuff
            local qRange = 575 + ( 25 * myHero:GetSpellData(_Q).level )
            if not isTarget and not hasQBuff and gsoAIO.Utils:_countEnemyHeroesInRange(mePos, qRange + 300) > 0 then
                canCastQ = true
            end
            if isTarget and hasQBuff and gsoAIO.Utils:_getDistance(mePos, target.pos) < 525 + 75 then
                canCastQ = true
            end
            if canCastQ then
                Control.KeyDown(HK_Q)
                Control.KeyUp(HK_Q)
                self.lastQ = GetTickCount()
            end
        end
        
        if not isTarget or afterAttack then

            -- USE W :
            local canWTime = wMinus > 1000 and wMinuss > 1000 and rMinuss > 1100
            local isComboW = isCombo and gsoAIO.Load.menu.gsojinx.wset.combo:Value()
            local isHarassW = isHarass and gsoAIO.Load.menu.gsojinx.wset.harass:Value()
            local isWReady = (isComboW or isHarassW) and canWTime and gsoAIO.Utils:_isReady(_W)
            if isWReady then
                local wTarget = isTarget and target or gsoAIO.TS:_getTarget(1175, false, false)
                local wTargetPos = wTarget and wTarget.pos or nil
                if wTargetPos then
                    local mePos = myHero.pos
                    local sW = { delay = 0.5, range = 1450, width = 70, speed = 3200, sType = "line", col = true }
                    local castpos,HitChance,pos = gsoAIO.TPred:GetBestCastPosition(wTarget, sW.delay, sW.width*0.5, sW.range, sW.speed, mePos, sW.col, sW.sType)
                    local canWonTarget = HitChance > 0 and castpos:ToScreen().onScreen and gsoAIO.Utils:_getDistance(mePos, castpos) < sW.range
                          canWonTarget = canWonTarget and gsoAIO.Utils:_getDistance(wTargetPos, castpos) < 500
                    if canWonTarget then
                        local cPos = cursorPos
                        Control.SetCursorPos(castpos)
                        gsoAIO.Orb.setCursor = castpos
                        Control.KeyDown(HK_W)
                        Control.KeyUp(HK_W)
                        self.lastW = GetTickCount()
                        gsoAIO.Orb.dActions[GetTickCount()] = { function() Control.SetCursorPos(cPos.x, cPos.y) end, 50 }
                        gsoAIO.Orb.dActionsC = gsoAIO.Orb.dActionsC + 1
                        return false
                    end
                end
            end
        end
    end
    if wMinus > 600 and wMinuss > 600 and rMinuss > 600 then
        return true
    end
    return false
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
class "__gsoLoad"
--
--
--
function __gsoLoad:__init()
    self.res = Game.Resolution()
    self.resX = self.res.x
    self.resY = self.res.y
    self.menu = MenuElement({name = "Gamsteron AIO", id = "gamsteronaio", type = MENU, leftIcon = gsoAIO.Vars.Icons["gsoaio"] })
    self.loadTime = GetTickCount()
    Callback.Add('Load', function() self:_load() end)
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoLoad:_menu()
    
    self.menu:MenuElement({name = "Target Selector", id = "ts", type = MENU, leftIcon = gsoAIO.Vars.Icons["ts"] })
        self.menu.ts:MenuElement({ id = "Mode", name = "Mode", value = 1, drop = { "Auto", "Closest", "Least Health", "Least Priority" } })
        if gsoAIO.Vars.meTristana then
            self.menu.ts:MenuElement({ id = "tristE", name = "Tristana E Target", type = MENU })
                self.menu.ts.tristE:MenuElement({ id = "enable", name = "Enable", value = true })
                self.menu.ts.tristE:MenuElement({ id = "stacks", name = "Min. Stacks", value = 3, min = 1, max = 4})
        end
        self.menu.ts:MenuElement({ id = "priority", name = "Priorities", type = MENU })
        self.menu.ts:MenuElement({ id = "selected", name = "Selected Target", type = MENU })
            self.menu.ts.selected:MenuElement({ id = "enable", name = "Enable", value = true })
            self.menu.ts.selected:MenuElement({ id = "only", name = "Only Selected Target", value = false })
    
    self.menu:MenuElement({name = "Orbwalker", id = "orb", type = MENU, leftIcon = gsoAIO.Vars.Icons["orb"] })
        self.menu.orb:MenuElement({name = "Delays", id = "delays", type = MENU})
            self.menu.orb.delays:MenuElement({name = "Extra Kite Delay", id = "windup", value = 0, min = 0, max = 50, step = 1 })
            self.menu.orb.delays:MenuElement({name = "Extra LastHit Delay", id = "lhDelay", value = 0, min = 0, max = 50, step = 1 })
            self.menu.orb.delays:MenuElement({name = "Extra Move Delay", id = "humanizer", value = 200, min = 120, max = 300, step = 10 })
        self.menu.orb:MenuElement({name = "Keys", id = "keys", type = MENU})
            self.menu.orb.keys:MenuElement({name = "Combo Key", id = "combo", key = string.byte(" ")})
            self.menu.orb.keys:MenuElement({name = "Harass Key", id = "harass", key = string.byte("C")})
            self.menu.orb.keys:MenuElement({name = "LastHit Key", id = "lastHit", key = string.byte("X")})
            self.menu.orb.keys:MenuElement({name = "LaneClear Key", id = "laneClear", key = string.byte("V")})
    
    self.menu:MenuElement({name = "Items", id = "gsoitem", type = MENU, leftIcon = gsoAIO.Vars.Icons["item"] })
        self.menu.gsoitem:MenuElement({id = "botrk", name = "        botrk", value = true, leftIcon = gsoAIO.Vars.Icons["botrk"] })
    
    self.menu:MenuElement({name = "Drawings", id = "gsodraw", leftIcon = gsoAIO.Vars.Icons["circles"], type = MENU })
        self.menu.gsodraw:MenuElement({name = "Enabled",  id = "enabled", value = true})
    
    if self.menu.orb.delays.windup:Value() < 0 then self.menu.orb.delays.windup:Value(0) end
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoLoad:_menuDrawRanges()
    self.menu.gsodraw:MenuElement({name = "Circles", id = "circle1", type = MENU,
        onclick = function()
            self.menu.gsodraw.circle1.merange:Hide(true)
            self.menu.gsodraw.circle1.mecolor:Hide(true)
            self.menu.gsodraw.circle1.mewidth:Hide(true)
            self.menu.gsodraw.circle1.herange:Hide(true)
            self.menu.gsodraw.circle1.hecolor:Hide(true)
            self.menu.gsodraw.circle1.hewidth:Hide(true)
            self.menu.gsodraw.circle1.cpos:Hide(true)
            self.menu.gsodraw.circle1.cposcolor:Hide(true)
            self.menu.gsodraw.circle1.cposwidth:Hide(true)
            self.menu.gsodraw.circle1.cposradius:Hide(true)
            self.menu.gsodraw.circle1.seltar:Hide(true)
            self.menu.gsodraw.circle1.seltarcolor:Hide(true)
            self.menu.gsodraw.circle1.seltarwidth:Hide(true)
            self.menu.gsodraw.circle1.seltarradius:Hide(true)
            if gsoAIO.Vars.meTwitch then
                self.menu.gsodraw.circle1.invenable:Hide(true)
                self.menu.gsodraw.circle1.invcolor:Hide(true)
                self.menu.gsodraw.circle1.notenable:Hide(true)
                self.menu.gsodraw.circle1.notcolor:Hide(true)
            end
            if gsoAIO.Vars.meDraven then
                self.menu.gsodraw.circle1.aaxeenable:Hide(true)
                self.menu.gsodraw.circle1.aaxecolor:Hide(true)
                self.menu.gsodraw.circle1.aaxewidth:Hide(true)
                self.menu.gsodraw.circle1.aaxeradius:Hide(true)
                self.menu.gsodraw.circle1.iaxeenable:Hide(true)
                self.menu.gsodraw.circle1.iaxecolor:Hide(true)
                self.menu.gsodraw.circle1.iaxewidth:Hide(true)
                self.menu.gsodraw.circle1.iaxeradius:Hide(true)
            end
            if gsoAIO.Vars.drawRanges.q then
                self.menu.gsodraw.circle1.qrange:Hide(true)
                self.menu.gsodraw.circle1.qrangecolor:Hide(true)
                self.menu.gsodraw.circle1.qrangewidth:Hide(true)
            end
            if gsoAIO.Vars.drawRanges.w then
                self.menu.gsodraw.circle1.wrange:Hide(true)
                self.menu.gsodraw.circle1.wrangecolor:Hide(true)
                self.menu.gsodraw.circle1.wrangewidth:Hide(true)
            end
            if gsoAIO.Vars.drawRanges.e then
                self.menu.gsodraw.circle1.erange:Hide(true)
                self.menu.gsodraw.circle1.erangecolor:Hide(true)
                self.menu.gsodraw.circle1.erangewidth:Hide(true)
            end
            if gsoAIO.Vars.drawRanges.r then
                self.menu.gsodraw.circle1.rrange:Hide(true)
                self.menu.gsodraw.circle1.rrangecolor:Hide(true)
                self.menu.gsodraw.circle1.rrangewidth:Hide(true)
            end
        end
    })
        self.menu.gsodraw.circle1:MenuElement({name = "MyHero attack range", id = "note1", icon = gsoAIO.Vars.Icons["arrow"], type = SPACE,
            onclick = function()
                self.menu.gsodraw.circle1.merange:Hide()
                self.menu.gsodraw.circle1.mecolor:Hide()
                self.menu.gsodraw.circle1.mewidth:Hide()
            end
        })
            self.menu.gsodraw.circle1:MenuElement({name = "        Enabled",  id = "merange", value = true})
            self.menu.gsodraw.circle1:MenuElement({name = "        Color",  id = "mecolor", color = Draw.Color(150, 49, 210, 0)})
            self.menu.gsodraw.circle1:MenuElement({name = "        Width",  id = "mewidth", value = 1, min = 1, max = 10})

        self.menu.gsodraw.circle1:MenuElement({name = "Enemy attack range", id = "note2", icon = gsoAIO.Vars.Icons["arrow"], type = SPACE,
            onclick = function()
                self.menu.gsodraw.circle1.herange:Hide()
                self.menu.gsodraw.circle1.hecolor:Hide()
                self.menu.gsodraw.circle1.hewidth:Hide()
            end
        })
            self.menu.gsodraw.circle1:MenuElement({name = "        Enabled",  id = "herange", value = true})
            self.menu.gsodraw.circle1:MenuElement({name = "        Color",  id = "hecolor", color = Draw.Color(150, 255, 0, 0)})
            self.menu.gsodraw.circle1:MenuElement({name = "        Width",  id = "hewidth", value = 1, min = 1, max = 10})

        self.menu.gsodraw.circle1:MenuElement({name = "Cursor Position", id = "note3", icon = gsoAIO.Vars.Icons["arrow"], type = SPACE,
            onclick = function()
                self.menu.gsodraw.circle1.cpos:Hide()
                self.menu.gsodraw.circle1.cposcolor:Hide()
                self.menu.gsodraw.circle1.cposwidth:Hide()
                self.menu.gsodraw.circle1.cposradius:Hide()
            end
        })
            self.menu.gsodraw.circle1:MenuElement({name = "        Enabled",  id = "cpos", value = true})
            self.menu.gsodraw.circle1:MenuElement({name = "        Color",  id = "cposcolor", color = Draw.Color(150, 153, 0, 76)})
            self.menu.gsodraw.circle1:MenuElement({name = "        Width",  id = "cposwidth", value = 5, min = 1, max = 10})
            self.menu.gsodraw.circle1:MenuElement({name = "        Radius",  id = "cposradius", value = 250, min = 1, max = 300})

        self.menu.gsodraw.circle1:MenuElement({name = "Selected Target", id = "note4", icon = gsoAIO.Vars.Icons["arrow"], type = SPACE,
            onclick = function()
                self.menu.gsodraw.circle1.seltar:Hide()
                self.menu.gsodraw.circle1.seltarcolor:Hide()
                self.menu.gsodraw.circle1.seltarwidth:Hide()
                self.menu.gsodraw.circle1.seltarradius:Hide()
            end
        })
            self.menu.gsodraw.circle1:MenuElement({name = "        Enabled",  id = "seltar", value = true})
            self.menu.gsodraw.circle1:MenuElement({name = "        Color",  id = "seltarcolor", color = Draw.Color(255, 204, 0, 0)})
            self.menu.gsodraw.circle1:MenuElement({name = "        Width",  id = "seltarwidth", value = 3, min = 1, max = 10})
            self.menu.gsodraw.circle1:MenuElement({name = "        Radius",  id = "seltarradius", value = 150, min = 1, max = 300})
        
        if gsoAIO.Vars.meTwitch then
            self.menu.gsodraw.circle1:MenuElement({name = "Q Invisible Range", id = "note9", icon = gsoAIO.Vars.Icons["arrow"], type = SPACE,
                onclick = function()
                    self.menu.gsodraw.circle1.invenable:Hide()
                    self.menu.gsodraw.circle1.invcolor:Hide()
                end
            })
                self.menu.gsodraw.circle1:MenuElement({id = "invenable", name = "        Enabled", value = true})
                self.menu.gsodraw.circle1:MenuElement({id = "invcolor", name = "        Color ", color = Draw.Color(200, 255, 0, 0)})

            self.menu.gsodraw.circle1:MenuElement({name = "Q Notification Range", id = "note10", icon = gsoAIO.Vars.Icons["arrow"], type = SPACE,
                onclick = function()
                    self.menu.gsodraw.circle1.notenable:Hide()
                    self.menu.gsodraw.circle1.notcolor:Hide()
                end
            })
                self.menu.gsodraw.circle1:MenuElement({id = "notenable", name = "        Enabled", value = true})
                self.menu.gsodraw.circle1:MenuElement({id = "notcolor", name = "        Color", color = Draw.Color(200, 188, 77, 26)})
        end
        
        if gsoAIO.Vars.drawRanges.q then
            self.menu.gsodraw.circle1:MenuElement({name = "Q Range", id = "note5", icon = gsoAIO.Vars.Icons["arrow"], type = SPACE,
                onclick = function()
                    self.menu.gsodraw.circle1.qrange:Hide()
                    self.menu.gsodraw.circle1.qrangecolor:Hide()
                    self.menu.gsodraw.circle1.qrangewidth:Hide()
                end
            })
                self.menu.gsodraw.circle1:MenuElement({id = "qrange", name = "        Enabled", value = true})
                self.menu.gsodraw.circle1:MenuElement({id = "qrangecolor", name = "        Color", color = Draw.Color(255, 66, 134, 244)})
                self.menu.gsodraw.circle1:MenuElement({id = "qrangewidth", name = "        Width", value = 1, min = 1, max = 10})
        end
        
        if gsoAIO.Vars.drawRanges.w then
            self.menu.gsodraw.circle1:MenuElement({name = "W Range", id = "note6", icon = gsoAIO.Vars.Icons["arrow"], type = SPACE,
                onclick = function()
                    self.menu.gsodraw.circle1.wrange:Hide()
                    self.menu.gsodraw.circle1.wrangecolor:Hide()
                    self.menu.gsodraw.circle1.wrangewidth:Hide()
                end
            })
                self.menu.gsodraw.circle1:MenuElement({id = "wrange", name = "        Enabled", value = true})
                self.menu.gsodraw.circle1:MenuElement({id = "wrangecolor", name = "        Color", color = Draw.Color(255, 92, 66, 244)})
                self.menu.gsodraw.circle1:MenuElement({id = "wrangewidth", name = "        Width", value = 1, min = 1, max = 10})
        end
        
        if gsoAIO.Vars.drawRanges.e then
            self.menu.gsodraw.circle1:MenuElement({name = "E Range", id = "note7", icon = gsoAIO.Vars.Icons["arrow"], type = SPACE,
                onclick = function()
                    self.menu.gsodraw.circle1.erange:Hide()
                    self.menu.gsodraw.circle1.erangecolor:Hide()
                    self.menu.gsodraw.circle1.erangewidth:Hide()
                end
            })
                self.menu.gsodraw.circle1:MenuElement({id = "erange", name = "        Enabled", value = true})
                self.menu.gsodraw.circle1:MenuElement({id = "erangecolor", name = "        Color", color = Draw.Color(255, 66, 244, 149)})
                self.menu.gsodraw.circle1:MenuElement({id = "erangewidth", name = "        Width", value = 1, min = 1, max = 10})
        end
        
        if gsoAIO.Vars.drawRanges.r then
            self.menu.gsodraw.circle1:MenuElement({name = "R Range", id = "note8", icon = gsoAIO.Vars.Icons["arrow"], type = SPACE,
                onclick = function()
                    self.menu.gsodraw.circle1.rrange:Hide()
                    self.menu.gsodraw.circle1.rrangecolor:Hide()
                    self.menu.gsodraw.circle1.rrangewidth:Hide()
                end
            })
                self.menu.gsodraw.circle1:MenuElement({id = "rrange", name = "        Enabled", value = true})
                self.menu.gsodraw.circle1:MenuElement({id = "rrangecolor", name = "        Color", color = Draw.Color(255, 244, 182, 66)})
                self.menu.gsodraw.circle1:MenuElement({id = "rrangewidth", name = "        Width", value = 1, min = 1, max = 10})
        end
        
        if gsoAIO.Vars.meDraven then
            self.menu.gsodraw.circle1:MenuElement({name = "Active Axe", id = "note9", icon = gsoAIO.Vars.Icons["arrow"], type = SPACE,
                onclick = function()
                    self.menu.gsodraw.circle1.aaxeenable:Hide()
                    self.menu.gsodraw.circle1.aaxecolor:Hide()
                    self.menu.gsodraw.circle1.aaxewidth:Hide()
                    self.menu.gsodraw.circle1.aaxeradius:Hide()
                end
            })
                self.menu.gsodraw.circle1:MenuElement({name = "        Enabled",  id = "aaxeenable", value = true})
                self.menu.gsodraw.circle1:MenuElement({name = "        Color",  id = "aaxecolor", color = Draw.Color(255, 49, 210, 0)})
                self.menu.gsodraw.circle1:MenuElement({name = "        Width",  id = "aaxewidth", value = 1, min = 1, max = 10})
                self.menu.gsodraw.circle1:MenuElement({name = "        Radius",  id = "aaxeradius", value = 170, min = 50, max = 300, step = 10})
            
            self.menu.gsodraw.circle1:MenuElement({name = "InActive Axes", id = "note10", icon = gsoAIO.Vars.Icons["arrow"], type = SPACE,
                onclick = function()
                    self.menu.gsodraw.circle1.iaxeenable:Hide()
                    self.menu.gsodraw.circle1.iaxecolor:Hide()
                    self.menu.gsodraw.circle1.iaxewidth:Hide()
                    self.menu.gsodraw.circle1.iaxeradius:Hide()
                end
            })
                self.menu.gsodraw.circle1:MenuElement({name = "        Enabled",  id = "iaxeenable", value = true})
                self.menu.gsodraw.circle1:MenuElement({name = "        Color",  id = "iaxecolor", color = Draw.Color(255, 153, 0, 0)})
                self.menu.gsodraw.circle1:MenuElement({name = "        Width",  id = "iaxewidth", value = 1, min = 1, max = 10})
                self.menu.gsodraw.circle1:MenuElement({name = "        Radius",  id = "iaxeradius", value = 170, min = 50, max = 300, step = 10})
        end
    if gsoAIO.Vars.meTwitch or gsoAIO.Vars.meEzreal then
        self.menu.gsodraw:MenuElement({name = "Texts", id = "texts1", type = MENU,
            onclick = function()
                if gsoAIO.Vars.meTwitch then
                    self.menu.gsodraw.texts1.enabletime:Hide(true)
                    self.menu.gsodraw.texts1.colortime:Hide(true)
                end
                if gsoAIO.Vars.meEzreal then
                    self.menu.gsodraw.texts1.enableautoq:Hide(true)
                    self.menu.gsodraw.texts1.colorautoqe:Hide(true)
                    self.menu.gsodraw.texts1.colorautoqd:Hide(true)
                    self.menu.gsodraw.texts1.sizeautoq:Hide(true)
                    self.menu.gsodraw.texts1.customautoq:Hide(true)
                    self.menu.gsodraw.texts1.xautoq:Hide(true)
                    self.menu.gsodraw.texts1.yautoq:Hide(true)
                end
            end
        })
            if gsoAIO.Vars.meTwitch then
                self.menu.gsodraw.texts1:MenuElement({name = "Q Timer", id = "note11", icon = gsoAIO.Vars.Icons["arrow"], type = SPACE,
                    onclick = function()
                        self.menu.gsodraw.texts1.enabletime:Hide()
                        self.menu.gsodraw.texts1.colortime:Hide()
                    end
                })
                    self.menu.gsodraw.texts1:MenuElement({id = "enabletime", name = "        Enabled", value = true})
                    self.menu.gsodraw.texts1:MenuElement({id = "colortime", name = "        Color", color = Draw.Color(200, 65, 255, 100)})
                    
            end
            if gsoAIO.Vars.meEzreal then
                self.menu.gsodraw.texts1:MenuElement({name = "Auto Q", id = "note9", icon = gsoAIO.Vars.Icons["arrow"], type = SPACE,
                    onclick = function()
                        self.menu.gsodraw.texts1.enableautoq:Hide()
                        self.menu.gsodraw.texts1.colorautoqe:Hide()
                        self.menu.gsodraw.texts1.colorautoqd:Hide()
                        self.menu.gsodraw.texts1.sizeautoq:Hide()
                        self.menu.gsodraw.texts1.customautoq:Hide()
                        self.menu.gsodraw.texts1.xautoq:Hide()
                        self.menu.gsodraw.texts1.yautoq:Hide()
                    end
                })
                    self.menu.gsodraw.texts1:MenuElement({id = "enableautoq", name = "        Enabled", value = true})
                    self.menu.gsodraw.texts1:MenuElement({id = "colorautoqe", name = "        Color If Enabled", color = Draw.Color(255, 000, 255, 000)})
                    self.menu.gsodraw.texts1:MenuElement({id = "colorautoqd", name = "        Color If Disabled", color = Draw.Color(255, 255, 000, 000)})
                    self.menu.gsodraw.texts1:MenuElement({id = "sizeautoq", name = "        Text Size", value = 25, min = 1, max = 64, step = 1 })
                    self.menu.gsodraw.texts1:MenuElement({id = "customautoq", name = "        Custom Text Position", value = false})
                    self.menu.gsodraw.texts1:MenuElement({id = "xautoq", name = "        Custom Width", value = self.resX * 0.5 - 150, min = 1, max = self.resX, step = 1 })
                    self.menu.gsodraw.texts1:MenuElement({id = "yautoq", name = "        Custom Height", value = self.resY * 0.5, min = 1, max = self.resY, step = 1 })
            end
                    
    end
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoLoad:_load()
    self:_menu()
    gsoAIO.Dmg = __gsoDmg()
    gsoAIO.Items = __gsoItems()
    gsoAIO.Spells = __gsoSpells()
    gsoAIO.Utils = __gsoUtils()
    gsoAIO.OB = __gsoOB()
    gsoAIO.TS = __gsoTS()
    gsoAIO.Farm = __gsoFarm()
    gsoAIO.TPred = __gsoTPred()
    gsoAIO.Orb = __gsoOrb()
    if _G.Orbwalker then
        GOS.BlockMovement = true
        GOS.BlockAttack = true
        _G.Orbwalker.Enabled:Value(false)
    end
    if _G.SDK and _G.SDK.Orbwalker then
        _G.SDK.Orbwalker:SetMovement(false)
        _G.SDK.Orbwalker:SetAttack(false)
    end
    if _G.EOW then
        _G.EOW:SetMovements(false)
        _G.EOW:SetAttacks(false)
    end
    if gsoAIO.Vars.hName == "Draven" then
        __gsoDraven()
    elseif gsoAIO.Vars.hName == "Ezreal" then
        __gsoEzreal()
    elseif gsoAIO.Vars.hName == "Ashe" then
        __gsoAshe()
    elseif gsoAIO.Vars.hName == "Twitch" then
        __gsoTwitch()
    elseif gsoAIO.Vars.hName == "KogMaw" then
        __gsoKogMaw()
    elseif gsoAIO.Vars.hName == "Vayne" then
        __gsoVayne()
    elseif gsoAIO.Vars.hName == "Teemo" then
        __gsoTeemo()
    elseif gsoAIO.Vars.hName == "Sivir" then
        __gsoSivir()
    elseif gsoAIO.Vars.hName == "Tristana" then
        __gsoTristana()
    elseif gsoAIO.Vars.hName == "Jinx" then
        __gsoJinx()
    end
    gsoAIO.Vars._champMenu()
    Callback.Add('Draw', function() self:_draw() end)
    self:_menuDrawRanges()
    print("gamsteronAIO "..gsoAIO.Vars.version.." | loaded!")
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
function __gsoLoad:_draw()
    if not self.menu.gsodraw.enabled:Value() or GetTickCount() < self.loadTime + 500 then
        return
    end
    for i = 1, #gsoAIO.Vars._draw do
        gsoAIO.Vars._draw[i]()
    end
    local mePos = myHero.pos
    if gsoAIO.Vars.drawRanges.q and self.menu.gsodraw.circle1.qrange:Value() then
        local qrange = gsoAIO.Vars.drawRanges.qrange and gsoAIO.Vars.drawRanges.qrange or gsoAIO.Vars.drawRanges.qfunc()
        Draw.Circle(mePos, qrange, self.menu.gsodraw.circle1.qrangewidth:Value(), self.menu.gsodraw.circle1.qrangecolor:Value())
    end
    if gsoAIO.Vars.drawRanges.w and self.menu.gsodraw.circle1.wrange:Value() then
        local wrange = gsoAIO.Vars.drawRanges.wrange and gsoAIO.Vars.drawRanges.wrange or gsoAIO.Vars.drawRanges.wfunc()
        Draw.Circle(mePos, wrange, self.menu.gsodraw.circle1.wrangewidth:Value(), self.menu.gsodraw.circle1.wrangecolor:Value())
    end
    if gsoAIO.Vars.drawRanges.e and self.menu.gsodraw.circle1.erange:Value() then
        local erange = gsoAIO.Vars.drawRanges.erange and gsoAIO.Vars.drawRanges.erange or gsoAIO.Vars.drawRanges.efunc()
        Draw.Circle(mePos, erange, self.menu.gsodraw.circle1.erangewidth:Value(), self.menu.gsodraw.circle1.erangecolor:Value())
    end
    if gsoAIO.Vars.drawRanges.r and self.menu.gsodraw.circle1.rrange:Value() then
        local rrange = gsoAIO.Vars.drawRanges.rrange and gsoAIO.Vars.drawRanges.rrange or gsoAIO.Vars.drawRanges.rfunc()
        Draw.Circle(mePos, rrange, self.menu.gsodraw.circle1.rrangewidth:Value(), self.menu.gsodraw.circle1.rrangecolor:Value())
    end
end
--   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
--
--
--
gsoAIO.Load = __gsoLoad()
