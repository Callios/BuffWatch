_addon.name = 'BuffWatch'
_addon.author = 'Callios/Sefadin'
_addon.version = '0.02'
_addon.command = 'bw'
_addon.commands = {'bw', 'buffwatch',}

require('pack')
require('lists')
require('tables')
require('strings')
texts = require('texts')
config = require('config')


shihei = 0 
utsubuff = "\\cs(255,0,0)0"
phalanxyn = "\\cs(255,127,0)No"
reprisalyn = "\\cs(255,127,0)No"
cocoonyn = "\\cs(255,127,0)No" 

-- local display_box = function()
--     return 'BuffWatch \nPhalanx \nReprisal \nCrusade'
-- end

display_box = function()
    str = '           \\cs(130,130,130)BuffWatcher\\cr\n'
    str = str.."\\cs(255,255,255) Shihei(U): "..shihei.."\\cr\n"
    str = str..'Utsusemi Shadows: '..utsubuff.."\\cr\n"
    str = str..'Phalanx: '..phalanxyn.."\\cr\n"
    str = str..'Reprisal: '..reprisalyn.."\\cr\n"
    str = str..'Cocoon:  '..cocoonyn.."\\cr\n"
    return str
     end

display_box_config = {pos={x=20,y=240},padding=8,text={font='sans-serif',size=10,stroke={width=2,alpha=255},Fonts={'sans-serif'},},bg={alpha=0},flags={}}
    display_jobbox = texts.new(display_box_config)
    
     function user_setup()
         check_tool_count()
         gearswap_jobbox:text(display_box())		
         gearswap_jobbox:show()
     end
    
    
     function check_tool_count()
        ctool = {'Shikanofuda',
            'Shihei',
            'Chonofuda',
            'Inoshishinofuda'}
    
        for t =1,4  do
    
            if not player.inventory[ctool[t]] then
                curCount = 0
            elseif player.inventory[ctool[t]].count then
                curCount = player.inventory[ctool[t]].count
            end
            a = ''
    
            --defined green = 99
            cMax = 99
            cColorR = 0
            if curCount > cMax then
                cColorR = 0
                cColorG = 255
            else
                percent = (curCount/cMax * 100)
                if percent >=50 then
                    cColorG = 255
                    cColorR =math.floor(5 * (100-percent))
                else 
                    cColorR = 255
                    cColorG = 255-math.floor(5 * (50-percent))
                end
            end
            if curCount == 0 then
                a = "\\cs(255,0,0)" .. '0'
            else 
                a = "\\cs("..cColorR..","..cColorG..",0)" .. (curCount) 
            end
    
            if t == 1 then
                shika = a
            elseif t == 2 then
                shihei = a
            elseif t == 3 then
                chono = a 
            elseif t == 4 then
                inofu = a 
            end
        end
    end
     function buff_change(buff, gain)
         if buffactive['Copy Image'] then
             utsubuff = "\\cs(255,127,0)1"	
         elseif buffactive['Copy Image (2)'] then 
             utsubuff = "\\cs(255,255,0)2"
         elseif buffactive['Copy Image (3)'] then
             utsubuff = "\\cs(127,255,0)3"
         elseif buffactive['Copy Image (4+)'] then
             utsubuff = "\\cs(0,255,0)4+"
         else 
             utsubuff = "\\cs(255,0,0)0"
         end
         if buffactive['Phalanx'] then
             phalanxyn = "\\cs(0,255,0)Yes"
         else
             phalanxyn ="\\cs(255,127,0)No"
         end
         if buffactive['Reprisal'] then
             reprisalyn = "\\cs(0,255,0)Yes"
         else
             reprisalyn ="\\cs(255,127,0)No"
         end
         if buffactive['Defense Boost'] then
             cocoonyn = "\\cs(0,255,0)Yes"
         else
             cocoonyn ="\\cs(255,127,0)No"
        end
    
         gearswap_jobbox:text(display_box())
         gearswap_jobbox:show()
     end	
    --  function aftercast(spell, act, spellMap, eventArgs)
    --     check_tool_count()
    --     buff_change()
    --     gearswap_jobbox:text(display_box())
    --     gearswap_jobbox:show()
    -- end 

bw_status = texts.new(display_box())
bw_status:show()
