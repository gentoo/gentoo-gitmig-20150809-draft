# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-analogtv/vdr-analogtv-1.0.00.ebuild,v 1.1 2006/08/16 11:38:25 zzam Exp $

inherit vdr-plugin eutils

DESCRIPTION="VDR plugin: Support analog-tv devices as input"
HOMEPAGE="http://www.ko0l.de/download/vdr/analogtv/index.html"
SRC_URI="http://www.ko0l.de/download/vdr/analogtv/download/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
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
