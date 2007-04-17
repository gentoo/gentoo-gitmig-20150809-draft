# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-dvd/files/rc-addon.sh,v 1.2 2007/04/17 09:45:04 zzam Exp $
#
# rc-addon plugin-startup-skript for vdr-dvd
#

plugin_pre_vdr_start() {

	: ${DVD_DRIVE:=/dev/dvd}

	add_plugin_param "-C${DVD_DRIVE}"


	if [ "${DVD_DVDCSS:=no}" = "yes" ]; then
		export DVDCSS_METHOD=key		
	fi	

}
