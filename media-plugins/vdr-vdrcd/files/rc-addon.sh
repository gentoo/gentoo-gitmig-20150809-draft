# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-vdrcd/files/rc-addon.sh,v 1.1 2006/01/29 21:36:07 hd_brummy Exp $
#
# rc-addon plugin-startup-skript for vdr-vdrcd
#

: ${VDRCD_PLUGIN_MOUNT:=/usr/bin/mount-vdrcd.sh}
: ${VDRCD_DRIVE:=/dev/cdrom}

plugin_pre_vdr_start() {

	local VDRCD_DRV

	for VDRCD_DRV in ${VDRCD_DRIVE}; do
		add_plugin_param "-c ${VDRCD_DRV}"
	done

	add_plugin_param "-m ${VDRCD_PLUGIN_MOUNT}"
				
}

		
# for compatibility
  if [[ ${SCRIPT_API:-1} -lt 2 ]]; then
    plugin_pre_vdr_start
  fi
