# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rexima/rexima-1.4.ebuild,v 1.1 2003/07/19 04:06:16 jje Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A curses-based interactive mixer which can also be used from the command-line."
HOMEPAGE="http://rus.members.beeb.net/rexima.html"
SRC_URI="ftp://ftp.ibiblio.org/pub/Linux/apps/sound/mixers/${PN}-${PV}.tar.gz"

DEPEND="virtual/glibc
	sys-libs/ncurses"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

S="${WORKDIR}/${P}"

src_compile() {
	cd ${S}
	mv Makefile Makefile.orig
	cat Makefile.orig | sed "s%/usr/local%/usr%" > Makefile
	emake || die
}

src_install () {
	cd ${S}
	
	make \
		PREFIX=${D}/usr \
		BINDIR=${D}/usr/bin \
		MANDIR=${D}/usr/share/man \
		install || die

	dodoc COPYING NEWS README
}
