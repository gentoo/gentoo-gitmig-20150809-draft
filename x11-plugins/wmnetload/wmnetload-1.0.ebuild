# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmnetload/wmnetload-1.0.ebuild,v 1.5 2003/04/01 22:14:50 spider Exp $

IUSE=""

S="${WORKDIR}/${P}"

DESCRIPTION="Network interface monitor dockapp"
HOMEPAGE="http://freshmeat.net/projects/wmnetload/"
SRC_URI="ftp://truffula.com/pub/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc -sparc "

DEPEND="virtual/glibc
	virtual/x11
	x11-libs/libdockapp"

src_compile() {

	econf || die "configure failed"

	make || die "parallel make failed"

}

src_install() {

	einstall || die "make install failed"

	dodoc AUTHORS README

}
