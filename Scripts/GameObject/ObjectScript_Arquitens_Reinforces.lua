-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/GameObject/ObjectScript_MC30.lua#7 $
--/////////////////////////////////////////////////////////////////////////////////////////////////
--
-- (C) Petroglyph Games, Inc.
-- ____    ____  __    __   __    __   ________   __    __       ___      .__   __.    
-- \   \  /   / |  |  |  | |  |  |  | |       /  |  |  |  |     /   \     |  \ |  |    
--  \   \/   /  |  |  |  | |  |  |  | `---/  /   |  |__|  |    /  ^  \    |   \|  |    
--   \_    _/   |  |  |  | |  |  |  |    /  /    |   __   |   /  /_\  \   |  . `  |    
--     |  |     |  `--'  | |  `--'  |   /  /----.|  |  |  |  /  _____  \  |  |\   |    
--     |__|      \______/   \______/   /________||__|  |__| /__/     \__\ |__| \__|    
--                                                                                     
-- ____    ____  ______   .__   __.   _______                                          
-- \   \  /   / /  __  \  |  \ |  |  /  _____|                                         
--  \   \/   / |  |  |  | |   \|  | |  |  __                                           
--   \      /  |  |  |  | |  . `  | |  | |_ |                                          
--    \    /   |  `--'  | |  |\   | |  |__| |                                          
--     \__/     \______/  |__| \__|  \______|                                          
--                                                                                     
--      ___   .___________.   ____    __    ____  ___      .______                     
--     /   \  |           |   \   \  /  \  /   / /   \     |   _  \                    
--    /  ^  \ `---|  |----`    \   \/    \/   / /  ^  \    |  |_)  |                   
--   /  /_\  \    |  |          \            / /  /_\  \   |      /                    
--  /  _____  \   |  |           \    /\    / /  _____  \  |  |\  \----.               
-- /__/     \__\  |__|            \__/  \__/ /__/     \__\ | _| `._____|          
--
--/////////////////////////////////////////////////////////////////////////////////////////////////
-- C O N F I D E N T I A L   S O U R C E   C O D E -- D O   N O T   D I S T R I B U T E
--/////////////////////////////////////////////////////////////////////////////////////////////////
--
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/GameObject/ObjectScript_MC30.lua $
--
--    Original Author: Sidious Invader
--
--            $Author: Sacer
--
--            $Change: 49079 $
--
--          $DateTime: 2006/07/18 15:43:12 $
--
--          $Revision: #7 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("PGStateMachine")
require("PGStoryMode")
require("PGSpawnUnits")


function Definitions()

DebugMessage("%s -- In Definitions", tostring(Script))

Define_State("State_Init", State_Init)

unit_list = { "Imperial_Gozanti", "Imperial_Gozanti" }

end

function State_Init(message)
		if not Get_Game_Mode() == "Space" then
				ScriptExit()
			end 
				interdictor_table = Find_All_Objects_Of_Type("Corvette | Frigate | Capital | Structure | Super")
				any_active = false
				for i,interdictor in pairs(interdictor_table) do
					if TestValid(interdictor) and interdictor.Is_Ability_Active("INTERDICT") then
						any_active = true
						if any_active then
						Game_Message("TEXT_MESSAGE_INTERDICTOR_ACTIVE_REINFORCES")
							ScriptExit()
						end
					end
				end
        if message == OnEnter then
                spawn_marker = Find_First_Object("Arquitens_Marker")
				player = spawn_marker.Get_Owner()
                Sleep(1)
                ReinforceList(unit_list, spawn_marker, player, true, true, false, nil)
                Sleep(5)
        end
end

