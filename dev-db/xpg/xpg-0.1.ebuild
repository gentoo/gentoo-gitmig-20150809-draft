# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/xpg/xpg-0.1.ebuild,v 1.5 2004/08/05 13:21:08 sejo Exp $
inherit java-pkg

DESCRIPTION="GUI for PostgreSQL written in Java"
HOMEPAGE="http://www.kazak.ws/xpg/"
SRC_URI="mirror://gentoo/xpg-current.tar.gz
	mirror://gentoo/xpg-icons.tar.gz"
S="${WORKDIR}/xpg-current"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""
DEPEND=">=virtual/jdk-1.4"

src_compile() {
	make || die "make problems"
}
src_install () {
	java-pkg_dojar ${S}/bin/*.jar
	cp -Rdp ${S}/bin/xpg /usr/bin/
	cp -Rdp ${S}/styles /usr/share/xpg/
	cp -Rdp ${WORKDIR}/*.jpg /usr/share/pixmaps/
	cp -Rdp ${WORKDIR}/*.xpm /usr/share/pixmaps/
	dohtml -r  ${S}/doc/*
}
