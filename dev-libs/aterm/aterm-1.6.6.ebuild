# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/aterm/aterm-1.6.6.ebuild,v 1.1 2002/04/12 13:51:40 karltk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="ATerm tree-handling library"
SRC_URI="http://www.cwi.nl/projects/MetaEnv/aterm/${P}.tar.gz"
HOMEPAGE="http://www.cwi.nl/projects/MetaEnv/aterm/"

DEPEND="java? ( virtual/jdk )"
#RDEPEND=""

src_compile() {
	local myconf
	use java && myconf="$myconf --with-java"
	
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--with-gcc \
		$myconf || die "./configure failed"
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
