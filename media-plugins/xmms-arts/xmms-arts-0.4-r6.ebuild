# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-arts/xmms-arts-0.4-r6.ebuild,v 1.5 2003/01/28 12:51:07 hannes Exp $

inherit kde-base eutils

# Note: we set many vars e.g. DEPEND insteaed of extending them because this isn't a proper KDE app,
# it only links against arts. So we need set-kdedir, but almost nothing else. So make sure it continues
# to override e.g. src_install.

DESCRIPTION="This output plugin allows xmms to work with arts, KDE's sound system"
SRC_URI="http://stukach.com/hosted/m.i.a/xmmsarts/xmmsarts-0.4.tar.gz"
# HOMEPAGE="http://home.earthlink.net/~bheath/xmms-arts/" #disappeared from the 'net?
HOMEPAGE="http://www.xmms.org/plugins_output.html"

LICENSE="GPL-2"
KEYWORDS="~x86 -ppc"

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

src_install() {                               
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING NEWS README
}

