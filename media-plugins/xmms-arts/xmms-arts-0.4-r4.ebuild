# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-arts/xmms-arts-0.4-r4.ebuild,v 1.4 2003/09/07 00:02:15 msterret Exp $
inherit kde-base

# Note: we set many vars e.g. DEPEND insteaed of extending them because this isn't a proper KDE app,
# it only links against arts. So we need set-kdedir, but almost nothing else. So make sure it continues
# to override e.g. src_install.

DESCRIPTION="This output plugin allows xmms to work with arts, KDE's sound system"
SRC_URI="http://stukach.com/hosted/m.i.a/xmmsarts/xmmsarts-0.4.tar.gz"
# HOMEPAGE="http://home.earthlink.net/~bheath/xmms-arts/" #disappeared from the 'net?
HOMEPAGE="http://www.xmms.org/plugins_output.html"

LICENSE="GPL-2"
KEYWORDS="x86 -ppc"

newdepend ">=media-sound/xmms-1.2.5-r1
	    kde-base/arts"

set-kdedir 3

src_unpack() {
	unpack ${A}
	cd ${S}
	cp Makefile.am Makefile.orig
	sed -e "s:artsc-config:${KDEDIR}/bin/artsc-config:" \
		Makefile.orig > Makefile.am
	patch -p1 < ${FILESDIR}/${P}-gentoo.patch || die "Failed patch"
	autoconf
}

src_compile() {
	kde_src_compile myconf # calls set-kdedir
	CFLAGS="$CFLAGS -I/usr/X11R6/include -I/usr/include -I${KDEDIR}/include -I${KDEDIR}/include/artsc"
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING NEWS README
}

