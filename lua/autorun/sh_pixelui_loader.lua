--[[
	PIXEL UI - Copyright Notice
	© 2023 Thomas O'Sullivan - All rights reserved

	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>.
--]]

PIXEL = PIXEL or {}
PIXEL.UI = PIXEL.UI or {}
PIXEL.UI.Version = "1.0.3"

function PIXEL.Print(...)
	MsgC(
		Color(236, 240, 241), "(",
		Color(54, 114, 244), "PIXEL_UI",
		Color(236, 240, 241), ") ",
		Color(236, 240, 241), ...
	) Msg("\n")
end

function PIXEL.LoadDirectory(path)
	local files, folders = file.Find(path .. "/*", "LUA")

	for _, fileName in ipairs(files) do
		local filePath = path .. "/" .. fileName

		if CLIENT then
			include(filePath)
		else
			if fileName:StartWith("cl_") then
				AddCSLuaFile(filePath)
			elseif fileName:StartWith("sh_") then
				AddCSLuaFile(filePath)
				include(filePath)
			else
				include(filePath)
			end
		end
	end

	return files, folders
end

function PIXEL.LoadDirectoryRecursive(basePath)
	local _, folders = PIXEL.LoadDirectory(basePath)
	for _, folderName in ipairs(folders) do
		PIXEL.LoadDirectoryRecursive(basePath .. "/" .. folderName)
	end
end

PIXEL.Print("Loading...")
PIXEL.LoadDirectoryRecursive("pixel_ui")
hook.Run("PIXEL.UI.FullyLoaded")
PIXEL.Print("Loaded!")

if (SERVER) then
	resource.AddWorkshop("2468112758")
	if (PIXEL.CheckForUpdates) then 
		hook.Add("Think", "PIXEL.UI.VersionChecker", function()
			hook.Remove("Think", "PIXEL.UI.VersionChecker")
			http.Fetch("https://raw.githubusercontent.com/SirPlancake/PIXEL-UI/master/VERSION", function(Body)
				if (PIXEL.UI.Version ~= string.Trim(Body)) then
					PIXEL.Print("------------------------------------------------------------------")
					PIXEL.Print(string.format("There is an update available. (%s -> %s)", PIXEL.UI.Version, Body))
					PIXEL.Print("You can download it here: https://github.com/SirPlancake/PIXEL-UI")
					PIXEL.Print("------------------------------------------------------------------")
					return
				end
			end)
		end)
	end
end