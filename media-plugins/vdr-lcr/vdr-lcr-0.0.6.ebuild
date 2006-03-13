# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-lcr/vdr-lcr-0.0.6.ebuild,v 1.1 2006/03/13 13:34:58 hd_brummy Exp $

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
		>=dev-perl/libwww-perl-5.69-r2
		>=dev-perl/HTML-Parser-3.34-r1
		>=www-client/lynx-2.8.4"

src_install() {
	vdr-plugin_src_install

	dobin contrib/retrieve-data.pl
}

pkg_postinst() {
	vdr-plugin_pkg_postinst

	echo
	einfo "By default, this plugin only supports the German telephone network"
	einfo "Find more info in /usr/bin/retrieve-data.pl how to add your"
	einfo "own Provider-Parser, or contact the maintainer"
}
