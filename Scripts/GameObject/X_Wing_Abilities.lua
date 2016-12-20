--@author: Kad_Venku
--@created for Yuuzhan Vong at War
require("PGBase")
require("PGStateMachine")
require("PGStoryMode")
require("PGSpawnUnits")

function Definitions()

    ServiceRate = 1

    Define_State("State_Init", State_Init);
    Define_State("Activate_Ability_State", Activate_Ability_State)

    lock_dummy_ability=false
    dummy_ability = "SPOILER_LOCK"
    dependent_ability="HUNT"
    ability_1="TURBO"

end

function State_Init(message)
    if message == OnEnter then
        -- prevent this from doing anything in galactic mode
        if Get_Game_Mode() ~= "Space" then
            ScriptExit()
        end

        if Object.Get_Owner().Is_Human() then
                Set_Next_State("Activate_Ability_State")
        end
        --[[
                would need additional stages for AI interactivity,
                but I'm honestly not even sure if the AI uses SPOILER_LOCK at all
        ]]
    end
end

function Activate_Abilities()
    Object.Activate_Ability(ability_1, true)
end

function Deactivate_Abilities()
    Object.Activate_Ability(ability_1, false)
end

function Activate_Ability_State(message)
    if message == OnUpdate then

        if Object.Is_Ability_Active(dependent_ability) then
            lock_dummy_ability=true
        else
            lock_dummy_ability=false
        end


        if lock_dummy_ability then
            Deactivate_Abilities()
            Object.Activate_Ability(dummy_ability, false)
        else
            if Object.Is_Ability_Active(dummy_ability) then
                Activate_Abilities()
            else
                Deactivate_Abilities()
                Object.Activate_Ability(dummy_ability, false)
            end
        end
    end
end