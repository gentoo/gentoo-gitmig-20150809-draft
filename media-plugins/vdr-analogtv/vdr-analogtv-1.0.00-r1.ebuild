# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-analogtv/vdr-analogtv-1.0.00-r1.ebuild,v 1.4 2007/07/10 23:09:00 mr_bones_ Exp $

inherit vdr-plugin eutils

DESCRIPTION="VDR plugin: Support analog-tv devices as input"
HOMEPAGE="http://www.ko0l.de/download/vdr/analogtv/index.html"
SRC_URI="http://www.ko0l.de/download/vdr/analogtv/download/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

DEPEND=">=media-video/vdr-1.2.6
	media-libs/libdvb"
RDEPEND="${DEPEND}
	media-video/mp1e"

PATCHES="${FILESDIR}/${PN}-sane-c++.diff"

src_unpack()
{
	vdr-plugin_src_unpack

	cd ${S}
	sed -i -e "s:^INCLUDES += :INCLUDES += -I/usr/include/libdvb :" Makefile
}

src_install()
{
	vdr-plugin_src_install

	docinto "examples"
	dodoc examples/channels.conf.*
}

pkg_postinst()
{
	vdr-plugin_pkg_postinst

	elog "Please try the example-channels.conf-files"
	elog "stored inside /usr/share/doc/${PF}/examples"
}
