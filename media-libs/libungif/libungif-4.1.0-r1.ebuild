# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/libungif/libungif-4.1.0-r1.ebuild,v 1.2 2002/04/14 16:48:29 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A library for reading and writing gif images without LZW compression"
SRC_URI="ftp://prtr-13.ucsc.edu/pub/libungif/${P}.tar.gz"
HOMEPAGE="http://prtr-13.ucsc.edu/~badger/software/libungif/index.shtml"

DEPEND="X? ( virtual/x11 )"
	
src_compile() {

	local myconf
	use X \
		&& myconf="--with-x" \
		|| myconf="--without-x"
    
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		${myconf} || die

	emake || die
}

src_install() {

	make \
		prefix=${D}/usr \
		install || die

	use gif && rm -rf ${D}/usr/bin

	dodoc AUTHORS BUGS COPYING ChangeLog NEWS ONEWS
	dodoc UNCOMPRESSED_GIF README TODO
	dodoc doc/*.txt
	dohtml -r doc
}
