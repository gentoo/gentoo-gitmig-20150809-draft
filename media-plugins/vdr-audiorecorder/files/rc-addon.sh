# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-audiorecorder/files/rc-addon.sh,v 1.1 2006/07/05 16:57:35 zzam Exp $
#
# rc-addon-script for plugin audiorecorder
#
# Matthias Schwarzott <zzam@gentoo.org>

: ${AUDIORECORDER_DIR:=/var/vdr/audiorecorder}

plugin_pre_vdr_start() {
	add_plugin_param "--recdir=${AUDIORECORDER_DIR}"
}

