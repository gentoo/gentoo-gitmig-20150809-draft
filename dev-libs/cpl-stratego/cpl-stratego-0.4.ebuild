# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Karl Trygve Kalleberg
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cpl-stratego/cpl-stratego-0.4.ebuild,v 1.1 2002/04/12 13:51:53 karltk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Choice library mostly used by Stratego"
SRC_URI="http://www.stratego-language.org/ftp/${P}.tar.gz"
HOMEPAGE="http://www.stratego-language.org"

DEPEND="virtual/glibc"
RDEPEND="$DEPEND"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
	#make || die
}

src_install () {
	make DESTDIR=${D} install || die
	#make \
	#	prefix=${D}/usr \
	#	mandir=${D}/usr/share/man \
	#	infodir=${D}/usr/share/info \
	#	install || die
}
