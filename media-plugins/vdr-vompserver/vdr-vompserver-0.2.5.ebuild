# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-vompserver/vdr-vompserver-0.2.5.ebuild,v 1.3 2007/01/05 17:02:26 hd_brummy Exp $

IUSE=""

inherit vdr-plugin

DESCRIPTION="VDR Plugin: server part for MediaMVP device"
#HOMEPAGE="http://vomp.sourceforge.net"
HOMEPAGE="http://www.vdr-wiki.de/wiki/index.php/Vompserver-plugin"
SRC_URI="mirror://gentoo/${P}.tgz mirror://vdrfiles/${PN}/${P}.tgz"
KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.2.6
	"

src_install() {
	vdr-plugin_src_install

	dodoc README HISTORY COPYING
	newdoc remux/README README.remux

	insinto /etc/vdr/plugins
	newins vomp.conf.sample vomp.conf
	newins vomp-00-00-00-00-00-00.conf.sample vomp-00-00-00-00-00-00.conf
}

pkg_postinst() {
	vdr-plugin_pkg_postinst

	echo
	elog "Have a look to the VOMP sample files in /etc/vdr/plugins."
	echo
	elog "You have to download the dongle file (i.e. firmware) and adapt"
	elog "the vomp configuration files accordingly."
	echo
}
