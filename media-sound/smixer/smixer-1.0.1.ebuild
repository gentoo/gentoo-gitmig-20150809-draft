# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/smixer/smixer-1.0.1.ebuild,v 1.4 2002/08/01 11:59:02 seemant Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A command-line tool for setting and viewing mixer settings."
SRC_URI="http://centerclick.org/programs/smixer/${PN}${PV}.tgz"
HOMEPAGE="http://centerclick.org/programs/smixer/"

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {
	emake || die
}

src_install () {
	dodir /usr/bin
	dodir /etc
	dodir /usr/share/man/man1
	
	make INS_BIN=${D}/usr/bin \
		INS_ETC=${D}/etc \
		INS_MAN=${D}/usr/share/man/man1 \
		install || die

	dodoc COPYING README
}
