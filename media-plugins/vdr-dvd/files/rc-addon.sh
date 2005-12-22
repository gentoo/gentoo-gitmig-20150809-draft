# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-dvd/files/rc-addon.sh,v 1.1 2005/12/22 20:39:11 hd_brummy Exp $
#
# rc-addon plugin-startup-skript for vdr-dvd
#

plugin_pre_vdr_start() {

	: ${DVD_DRIVE:=/dev/dvd}

	add_plugin_param "-C${DVD_DRIVE}"


	if [[ ${DVD_DVDCSS:=no} == "yes" ]]; then
		export DVDCSS_METHOD=key		
	fi	

}


# for compatibility
if [[ ${SCRIPT_API:-1} -lt 2 ]]; then
    plugin_pre_vdr_start
fi
