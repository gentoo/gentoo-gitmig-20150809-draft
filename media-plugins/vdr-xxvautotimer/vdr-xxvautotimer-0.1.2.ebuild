# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-xxvautotimer/vdr-xxvautotimer-0.1.2.ebuild,v 1.1 2008/03/22 18:27:10 hd_brummy Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: edit Autotimers of XXV via VDR on-screen-display"
HOMEPAGE="http://www.vdrtools.de/vdrxxvautotimer.html"
SRC_URI="http://www.vdrtools.de/download/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.3.0"

RDEPEND=">=net-www/xxv-0.30"

src_unpack() {
	vdr-plugin_src_unpack

	sed -i "s:CFLAGS =:CFLAGS ?=:" "${S}"/mysqlwrapped-1.4/Makefile
}
