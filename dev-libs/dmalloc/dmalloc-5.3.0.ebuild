# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dmalloc/dmalloc-5.3.0.ebuild,v 1.10 2007/01/04 22:39:11 flameeyes Exp $

inherit eutils

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
	epatch ${FILESDIR}/${P}-respect-DESTDIR.diff
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
