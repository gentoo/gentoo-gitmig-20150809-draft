# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dmalloc/dmalloc-5.4.2.ebuild,v 1.6 2005/04/01 04:01:43 agriffis Exp $

inherit debug eutils

DESCRIPTION="A Debug Malloc Library"
HOMEPAGE="http://dmalloc.com/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="ia64 ppc sparc x86 ~alpha -amd64"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-5.3.0-fpic.patch
	epatch ${FILESDIR}/${P}-respect-DESTDIR.diff
	epatch ${FILESDIR}/${P}-sandbox.patch
}

src_compile() {
	econf --enable-threads --enable-shlib || die "configure failed"
	emake -j1 || die "emake failed"
}

src_test() {
	einfo "Running tests"
	make heavy || die "make check tests failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	newdoc ChangeLog.1 ChangeLog
	dodoc INSTALL NEWS README docs/NOTES docs/TODO
	dohtml RELEASE.html docs/dmalloc.html
	doinfo docs/dmalloc.info
}
