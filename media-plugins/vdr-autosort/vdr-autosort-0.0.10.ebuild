# Copyright 2003-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-autosort/vdr-autosort-0.0.10.ebuild,v 1.1 2006/05/15 07:51:34 zzam Exp $

IUSE=""
inherit vdr-plugin eutils

DESCRIPTION="VDR plugin: Auto-sort channels.conf"
HOMEPAGE="http://www.copypointburscheid.de/linux/autosort.htm"
SRC_URI="http://www.copypointburscheid.de/linux/${P}.tgz"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.3.32"

src_install()
{
	vdr-plugin_src_install
	insinto /etc/vdr/plugins
	doins autosort.conf
}

pkg_preinst() {
	if [[ ! -L ${ROOT}/etc/vdr/channels.conf ]]; then
		cp ${ROOT}/etc/vdr/channels.conf ${IMAGE}/etc/vdr/channels.conf.autosort.bak
		fowners vdr:vdr /etc/vdr/channels.conf.autosort.bak
	fi
}


pkg_postinst()
{
	vdr-plugin_pkg_postinst
	einfo
	einfo "You will find a backup of your channels.conf in /etc/vdr/channels.conf.autosort.bak"
	einfo "Edit /etc/vdr/plugins/autosort.conf to fit your needs"
	ewarn "Important:"
	ewarn "Backup your channels.conf together with autosort.conf"
	ewarn "before making heavy changes to autosort.conf."
	einfo
}
