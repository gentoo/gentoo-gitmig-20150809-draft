# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dmalloc/dmalloc-4.8.2.ebuild,v 1.6 2003/02/13 10:37:16 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A Debug Malloc Library"
SRC_URI="http://download.sourceforge.net/${PN}/${P}.tgz"
HOMEPAGE="http://dmalloc.com/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc "

DEPEND="virtual/glibc"

src_compile() {
	econf --with-shlibs || die
	emake all threads shlib tests || die "emake failed"
}

src_install () {
	# install extra docs
	dodoc ChangeLog INSTALL TODO NEWS NOTES README
	dohtml Release.html dmalloc.html
	
	make prefix=${D}/usr install installth installsl
	doinfo dmalloc.info
}
