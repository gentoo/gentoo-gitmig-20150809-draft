# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xdaliclock/xdaliclock-2.20.ebuild,v 1.5 2004/06/24 22:39:36 agriffis Exp $

S=${WORKDIR}/${P}/X11
DESCRIPTION=" Dali Clock is a digital clock. When a digit changes, it melts into its new shape."
HOMEPAGE="http://www.jwz.org/xdaliclock/"
SRC_URI="http://www.jwz.org/${PN}/${P}.tar.gz"

KEYWORDS="x86 ppc ~amd64"
LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND="virtual/x11"

src_install() {
	dodir /usr/bin
	dodir /usr/share/man/man1
	einstall || die

	dodoc ../README
}
