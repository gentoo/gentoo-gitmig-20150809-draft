# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmnetselect/wmnetselect-0.8.ebuild,v 1.8 2004/06/24 23:15:20 agriffis Exp $

IUSE=""
DESCRIPTION="WindowMaker browser launcher doclette"
HOMEPAGE="http://freshmeat.net/projects/wmnetselect/"
SRC_URI="ftp://ftp11.freebsd.org/pub/FreeBSD/ports/distfiles/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc amd64"

DEPEND="virtual/x11"

src_compile() {
	xmkmf || die
	emake wmnetselect || die
}

src_install () {
	dobin   wmnetselect
	dodoc   COPYING README ChangeLog TODO README.html
}
