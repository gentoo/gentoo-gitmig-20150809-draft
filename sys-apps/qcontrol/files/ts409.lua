--[[
	Debian configuration file for qcontrol (LUA syntax)
	Supports QNAP TS-409.
--]]

register("ts409")

-- Requires CONFIG_KEYBOARD_GPIO enabled in the kernel and
-- the kernel module gpio_keys to be loaded.
register("evdev", "/dev/input/by-path/platform-gpio-keys-event-",
	408, "restart_button",
	133, "media_button")

function power_button( time )
	os.execute("poweroff")
end

function restart_button( time )
	os.execute("reboot")
end

function media_button( time )
	piccmd("usbled", "8hz")
end

--[[
	Fan and temperature control are left disabled until qcontrol
	gets a proper daemon mode.
	Empty functions are needed to avoid errors.
--]]
function fan_error(  )
end

function fan_normal(  )
end

function temp( temp )
	print("ts409 temperature:", temp)
end
