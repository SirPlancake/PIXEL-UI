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

PIXEL.RegisterFont("UI.OverheadTitle", "Roboto Medium", 60, 300)
PIXEL.RegisterFont("UI.OverheadDescription", "Roboto Medium", 50, 200)

function PIXEL.DrawOverhead(ent, title, description, imgurID)
    local entpos = ent:GetPos()
    local ply = LocalPlayer()

    if (ply:GetPos():DistToSqr(entpos) >= 150 * 500) then return end

    local pos = entpos + Vector(0, 0, 83)
    local ang = (ply:EyePos() - pos):Angle()

    ang.p = 0
    ang:RotateAroundAxis(ang:Right(), 90)
    ang:RotateAroundAxis(ang:Up(), 90)
    ang:RotateAroundAxis(ang:Forward(), 180)

    cam.Start3D2D(pos, ang, 0.04)
        local hasIcon = imgurID ~= nil

        local titleWidth = PIXEL.GetTextSize(title, "UI.OverheadTitle")
        local descriptionWidth = PIXEL.GetTextSize(description, "UI.OverheadDescription")

        local iconWidth = hasIcon and (PIXEL.Scale(72)) or 0
        local topWidth = iconWidth + titleWidth
        local width = math.max(topWidth, descriptionWidth) + PIXEL.Scale(50) * 2
        local startX = -width / 2

        PIXEL.DrawRoundedBoxEx(PIXEL.Scale(30), startX, 98, width, 100, Color(0, 0, 0, 150), false, false, true, true)
        PIXEL.DrawRoundedBoxEx(PIXEL.Scale(30), startX, 0, width, 100, Color(0, 0, 0, 200), true, true, false, false)

        local contentStart = startX + (width - topWidth) / 2

        if hasIcon then
            PIXEL.DrawImgur(contentStart, PIXEL.Scale(25), PIXEL.Scale(48), PIXEL.Scale(48), imgurID, color_white)
        end

        PIXEL.DrawSimpleText(title, "UI.OverheadTitle", contentStart + iconWidth, PIXEL.Scale(50), PIXEL.Colors.PrimaryText, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        PIXEL.DrawSimpleText(description, "UI.OverheadDescription", 0, PIXEL.Scale(145), PIXEL.Colors.SecondaryText, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    cam.End3D2D()
end