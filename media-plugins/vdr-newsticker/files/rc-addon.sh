#
# rc-addon-script for plugin newsticker
#

plugin_pre_vdr_start() {
	add_plugin_param "--output=/var/vdr/newsticker"
}

# for compatibility
if [[ ${SCRIPT_API:-1} -lt 2 ]]; then
	plugin_pre_vdr_start
fi
