# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-lcr/vdr-lcr-0.0.3.ebuild,v 1.1 2006/02/28 00:05:20 hd_brummy Exp $

inherit vdr-plugin

DESCRIPTION="Video Disk Recorder Least Cost Routing (LCR) PlugIn"
HOMEPAGE="http://lcr.vdr-developer.org"
SRC_URI="http://lcr.vdr-developer.org/downloads/${P}.tar.bz2
		mirror://vdrfiles/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.3.21
		>=libwww-perl-5.69-r2
		>=HTML-Parser-3.34-r1"

src_install() {
	vdr-plugin_src_install

	dobin contrib/retrieve-data.pl
}

src_postinst() {
	vdr-plugin_pkg_postinst

	echo
	einfo "LCR - Plugin support per default only German telefon net"
	einfo "Find more info in /usr/bin/retrieve-data.pl how to add your"
	einfo "own Provider-Parser, or contact the maintainer"
}
