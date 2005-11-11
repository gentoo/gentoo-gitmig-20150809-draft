# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmnetselect/wmnetselect-0.8-r1.ebuild,v 1.11 2005/11/11 10:23:42 s4t4n Exp $

IUSE=""
DESCRIPTION="WindowMaker browser launcher docklet"
HOMEPAGE="http://freshmeat.net/projects/wmnetselect/"
SRC_URI="ftp://ftp11.freebsd.org/pub/FreeBSD/ports/distfiles/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc amd64 ppc"

DEPEND="virtual/x11"

src_compile() {
	xmkmf || die
	emake CDEBUGFLAGS="${CFLAGS}" wmnetselect || die
}

src_install () {
	dobin wmnetselect
	dodoc README ChangeLog TODO README.html
}
