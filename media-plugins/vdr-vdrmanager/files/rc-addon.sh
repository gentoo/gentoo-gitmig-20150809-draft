# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-vdrmanager/files/rc-addon.sh,v 1.1 2012/02/24 21:44:54 hd_brummy Exp $
#
# rc-addon plugin-startup-skript for vdr-vdrmanager
#

: ${VDRMANAGER_PORT:=6420}

if [[ -z ${VDRMANAGER_PASS} ]]; then
	eerror "No password in /etc/conf.d/vdr.manager"
	logger -t vdr "ERROR: need password for plugin vdr-manager"
fi

plugin_pre_vdr_start() {


        add_plugin_param "-p${VDRMANAGER_PORT}"
		add_plugin_param "-P${VDRMANAGER_PASS}"
		add_plugin_param "-s"
}

