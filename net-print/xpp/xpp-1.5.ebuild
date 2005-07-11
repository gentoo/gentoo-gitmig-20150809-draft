# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/xpp/xpp-1.5.ebuild,v 1.3 2005/07/11 18:44:17 dertobi123 Exp $

inherit eutils

DESCRIPTION="X Printing Panel"
SRC_URI="mirror://sourceforge/cups/${P}.tar.gz"
HOMEPAGE="http://cups.sourceforge.net/xpp/"

KEYWORDS="x86 amd64 ~ppc"
IUSE=""
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/libc
	virtual/x11
	>=net-print/cups-1.1.14
	>=x11-libs/fltk-1.1"

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
