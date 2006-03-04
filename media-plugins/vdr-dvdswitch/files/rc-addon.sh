#
# rc-addon-script for plugin vdrswitch
#

plugin_pre_vdr_start() {
	: ${DVDSWITCH_READ_DVD:=/usr/share/vdr/dvdchanger/dvdchanger_readdvd.sh}
	: ${DVDSWITCH_WRITE_DVD:=/usr/share/vdr/dvdchanger/dvdchanger_writedvd.sh}

	add_plugin_param "-r ${DVDSWITCH_READ_DVD}"
	add_plugin_param "-w ${DVDSWITCH_WRITE_DVD}"
}

# for compatibility
if [[ ${SCRIPT_API:-1} -lt 2 ]]; then
	plugin_pre_vdr_start
fi
        