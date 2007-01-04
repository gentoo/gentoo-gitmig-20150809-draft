# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dmalloc/dmalloc-4.8.2-r1.ebuild,v 1.14 2007/01/04 22:39:11 flameeyes Exp $

DESCRIPTION="A Debug Malloc Library"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
HOMEPAGE="http://dmalloc.com/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	econf --enable-threads --enable-shlib || die "configure failed"
	emake || die "emake failed"
}

src_test() {
	einfo "Running tests"
	make heavy || die "make check tests failed"
}

src_install () {
	# install extra docs
	dodoc ChangeLog INSTALL TODO NEWS NOTES README
	dohtml RELEASE.html dmalloc.html

	make prefix=${D}/usr install || die "make install failed"
	doinfo dmalloc.info
}
