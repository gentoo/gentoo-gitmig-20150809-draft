# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/smixer/smixer-1.0.1.ebuild,v 1.2 2002/07/11 06:30:41 drobbins Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A command-line tool for setting and viewing mixer settings."
SRC_URI="http://centerclick.org/programs/smixer/smixer1.0.1.tgz"
HOMEPAGE="http://centerclick.org/programs/smixer/"

RDEPEND="virtual/glibc"

src_compile() {
	emake || die
}

src_install () {
	dodir /usr/bin
	dodir /etc
	dodir /usr/share/man/man1
	
	make INS_BIN=${D}/usr/bin					\
	     INS_ETC=${D}/etc						\
	     INS_MAN=${D}/usr/share/man/man1				\
	     install || die

	dodoc COPYING README
}



