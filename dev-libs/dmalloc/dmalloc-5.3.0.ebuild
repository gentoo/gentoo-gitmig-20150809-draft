# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dmalloc/dmalloc-5.3.0.ebuild,v 1.8 2005/01/21 11:24:29 ka0ttic Exp $

inherit debug eutils

DESCRIPTION="A Debug Malloc Library"
HOMEPAGE="http://dmalloc.com/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~ia64 ppc ~sparc x86 ~alpha"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-fpic.patch
}

src_compile() {
	econf --enable-threads --enable-shlib || die "configure failed"
	emake || die "emake failed"
}

src_test() {
	einfo "Running tests"
	make heavy || die "make check tests failed"
}

src_install() {
	newdoc ChangeLog.1 ChangeLog
	dodoc INSTALL NEWS README docs/NOTES docs/TODO
	dohtml RELEASE.html docs/dmalloc.html

	make prefix=${D}/usr install || die "make install failed"
	doinfo docs/dmalloc.info
}
