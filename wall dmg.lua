--Incase some people don't know how to edit the text, here's the tutorial of how to changing the text size :) msg by SaiyanObject#0001

--// How to change the text size / DPI
--"+" for large text, "-" for small text, "c" for centered text, "r" for right-aligned text, "b" for bold text, "d" for high DPI support.
--"c" can be combined with other flags. nil can be specified for normal sized uncentered text.

local apdmg = ui.new_checkbox("Visuals", "Other ESP", "Penetration damage")
local textcolor = ui.new_color_picker("Visuals", "Other ESP", 255, 255, 255, 255) --Color box for changing the color of text
local xpos = ui.new_slider("Visuals", "Other ESP", "X Position", -40, 40, 0, true, "px", 1)
local ypos = ui.new_slider("Visuals", "Other ESP", "Y Position", -20, 20, 0, true, "px", 1)

client.set_event_callback("paint", function()
	if not ui.get(apdmg) then return end

	if entity.get_local_player() == nil then
		return
	end

	local weap_classname = entity.get_classname(entity.get_player_weapon(entity.get_local_player()))

	--disable the function when holding knife / nades, molly etc.
	if weap_classname == "CKnife" or weap_classname == "CSmokeGrenade" or weap_classname == "CFlashbang" or weap_classname == "CHEGrenade" or weap_classname == "CDecoyGrenade" or weap_classname == "CIncendiaryGrenade" then
		return
	end

	local screenX, screenY = client.screen_size()
	local xPos = screenX / 2 + 1 * ui.get(xpos)
	local yPos = screenY / 2 + 20 - 15 * ui.get(ypos)
	local saiyanbigdick = 30--cm
	
	local eyeX, eyeY, eyeZ = client.eye_position()
	local pitch, yaw = client.camera_angles()
	local ent_exists = false
	local wall_dmg = 0

	local sin_pitch = math.sin(math.rad(pitch))
	local cos_pitch = math.cos(math.rad(pitch))
	local sin_yaw = math.sin(math.rad(yaw))
	local cos_yaw = math.cos(math.rad(yaw))

	local dirVector = { cos_pitch * cos_yaw, cos_pitch * sin_yaw, -sin_pitch }
	
	local fraction, entindex = client.trace_line(entity.get_local_player(), eyeX, eyeY, eyeZ, eyeX + (dirVector[1] * 8192), eyeY + (dirVector[2] * 8192), eyeZ + (dirVector[3] * 8192))

	local r, g, b, a = ui.get(textcolor)
	if fraction < 1 then
		local entindex_1, dmg = client.trace_bullet(entity.get_local_player(), eyeX, eyeY, eyeZ, eyeX + (dirVector[1] * (8192 * fraction + 128)), eyeY + (dirVector[2] * (8192 * fraction + 128)), eyeZ + (dirVector[3] * (8192 * fraction + 128)))

		if entindex_1 ~= nil then
			ent_exists = true
		end

		if wall_dmg < dmg then
			wall_dmg = dmg
		end
	end

	if wall_dmg > 0 then
		if ent_exists then
			renderer.text(xPos, yPos, r, g, b, a, "-cbd", 0, wall_dmg) --text
			renderer.indicator(r, g, b, a, "AP: " ,wall_dmg) --indicators     //you could edit this line if you think it's ugly etc. whatever, you could delete this line.
		else
			renderer.text(xPos, yPos, r, g, b, a, "-cbd", 0, wall_dmg) --text
			renderer.indicator(r, g, b, a, "AP: " ,wall_dmg) --indicators     //you could edit this line if you think it's ugly etc. whatever, you could delete this line.
		end
	end
end)