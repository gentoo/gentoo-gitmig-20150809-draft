# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dmalloc/dmalloc-4.8.2-r1.ebuild,v 1.1 2002/06/06 02:32:53 jnelson Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A Debug Malloc Library"
SRC_URI="http://dmalloc.com/cgi-bin/bounce/http://download.sourceforge.net/${PN}/${PN}-${PV}.tgz"
HOMEPAGE="http://dmalloc.com/"
DEPEND="virtual/glibc"
RDEPEND="${DEPEND}"
SLOT="0"
LICENSE="as-is"

src_compile() {
	econf --enable-threads --enable-shlib || die "configure failed"
	emake all threads shlib tests || die "emake failed"
}

src_install () {
	# install extra docs
	dodoc ChangeLog INSTALL TODO NEWS NOTES README
	dohtml Release.html dmalloc.html
	
	make prefix=${D}/usr install installth installsl
	doinfo dmalloc.info
}
