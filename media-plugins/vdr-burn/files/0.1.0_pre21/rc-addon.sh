# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-burn/files/0.1.0_pre21/rc-addon.sh,v 1.1 2007/05/07 10:26:31 hd_brummy Exp $
#
# rc-addon-script for plugin burn
#
# Joerg Bornkessel hd_brummy@gentoo.org

source /etc/conf.d/vdr.burn

: ${BURN_TMPDIR:=/tmp}
: ${BURN_DATADIR:=/var/vdr/video}
: ${BURN_DVDWRITER:=/dev/dvd}
: ${BURN_ISODIR:=/var/vdr/video/dvd-images}

plugin_pre_vdr_start() {

  add_plugin_param "-t ${BURN_TMPDIR}"
  add_plugin_param "-d ${BURN_DATADIR}"
  add_plugin_param "-D ${BURN_DVDWRITER}"
  add_plugin_param "-i ${BURN_ISODIR}"

}
 
