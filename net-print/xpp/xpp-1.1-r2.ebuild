# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/xpp/xpp-1.1-r2.ebuild,v 1.3 2004/01/22 14:04:44 lanius Exp $

inherit eutils

DESCRIPTION="X Printing Panel"
SRC_URI="mirror://sourceforge/cups/${P}.tar.gz"
HOMEPAGE="http://cups.sourceforge.net/xpp/"

KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	virtual/x11
	>=net-print/cups-1.1.14
	>=x11-libs/fltk-1.1"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/cups.diff || die
	epatch ${FILESDIR}/inputslider.h.patch || die
}

src_compile() {
	export CXX=g++
	export LDFLAGS="-L/usr/lib/fltk-1.1 -lfltk"
	export CPPFLAGS="-I/usr/include/fltk-1.1"

	econf || die "configure failed"

	make || die "make failed"
}

src_install() {
	einstall || die "make install failed"
	dodoc LICENSE ChangeLog README
}
