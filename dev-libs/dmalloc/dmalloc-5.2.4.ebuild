# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dmalloc/dmalloc-5.2.4.ebuild,v 1.1 2003/11/20 13:37:14 liquidx Exp $

inherit debug

DESCRIPTION="A Debug Malloc Library"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
HOMEPAGE="http://dmalloc.com/"

IUSE=""
SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~sparc "

DEPEND="virtual/glibc"

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
