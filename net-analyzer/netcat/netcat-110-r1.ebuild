# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netcat/netcat-110-r1.ebuild,v 1.6 2003/04/23 00:00:18 lostlogic Exp $

MY_P=nc${PV}
S=${WORKDIR}
DESCRIPTION="A network piping program"
SRC_URI="http://www.atstake.com/research/tools/${MY_P}.tgz"
HOMEPAGE="http://www.atstake.com/research/tools/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc "

DEPEND="=sys-apps/sed-4*"

src_compile() {

	einfo "Makefile corrections"
	sed -i \
		-e "s:nc:netcat:g" \
		-e "s:^CFLAGS =.*$:CFLAGS = ${CFLAGS}:" \
		-e "s:^CC =.*$:CC = gcc \$(CFLAGS):" \
		Makefile

	einfo "netcat.c corrections"
	sed -i "s:#define HAVE_BIND:#undef HAVE_BIND:" \
		netcat.c

	make linux || die

}

src_install () {
	dobin netcat
	dodoc README
	docinto scripts
	dodoc scripts/*
}

pkg_postinst() {
	einfo "The binary is now installed as /usr/bin/netcat instead of"
	einfo "/usr/bin/nc, because the latter is provided by"
	einfo "app-editors/nedit for a completely different purpose."
}
