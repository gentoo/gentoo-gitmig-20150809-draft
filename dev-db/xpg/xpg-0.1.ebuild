# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/xpg/xpg-0.1.ebuild,v 1.3 2004/08/05 09:25:13 sejo Exp $


DESCRIPTION="GUI for PostgreSQL written in Java"
HOMEPAGE="http://www.kazak.ws/xpg/"
SRC_URI="mirror://gentoo/xpg-current.tar.gz
	mirror://gentoo/xpg-icons.tar.gz"
S="${WORKDIR}/xpg-current"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc"
IUSE="java"

DEPEND=">=virtual/jdk-1.4"

src_compile() {
	make || die "make problems"
}
src_install () {
	make install || die "install problems"
	cp -Rdp ${WORKDIR}/*.jpg ${WORKDIR}/*.xpm /usr/share/pixmaps
}
