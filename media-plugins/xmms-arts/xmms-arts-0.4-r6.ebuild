# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-arts/xmms-arts-0.4-r6.ebuild,v 1.13 2004/03/26 21:07:55 eradicator Exp $

inherit kde-base eutils

MY_P=${PN/-/}-${PV}
DESCRIPTION="This output plugin allows xmms to work with arts, KDE's sound system"
SRC_URI="http://stukach.com/hosted/m.i.a/xmmsarts/${MY_P}.tar.gz"
HOMEPAGE="http://www.xmms.org/plugins_output.html"

LICENSE="GPL-2"
KEYWORDS="~x86 -ppc"

IUSE=""

newdepend ">=media-sound/xmms-1.2.5-r1
	kde-base/arts"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN/-/}-${PV}-nocmallocc.patch
	epatch ${FILESDIR}/${P}-gentoo2.patch
	#epatch ${FILESDIR}/${P}-gentoo-endian.patch
}

src_compile() {
	kde_src_compile myconf # calls set-kdedir
	econf || die
	emake || die
}
