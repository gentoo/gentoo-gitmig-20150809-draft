# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dmalloc/dmalloc-5.5.2.ebuild,v 1.1 2007/07/09 20:44:36 drizzt Exp $

inherit eutils autotools

DESCRIPTION="A Debug Malloc Library"
HOMEPAGE="http://dmalloc.com/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-5.3.0-fpic.patch
	epatch "${FILESDIR}"/${P}-SONAME.patch
	epatch "${FILESDIR}"/${P}-respect-DESTDIR.diff
	epatch "${FILESDIR}"/${PN}-5.4.2-sandbox.patch

	eautoreconf
}

src_compile() {
	econf --enable-threads --enable-shlib || die "configure failed"
	emake || die "emake failed"
	cd docs && makeinfo dmalloc.texi
}

src_test() {
	einfo "Running tests"
	make heavy || die "make check tests failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	newdoc ChangeLog.1 ChangeLog
	dodoc INSTALL NEWS README docs/NOTES docs/TODO
	insinto /usr/share/doc/${PF}
	doins docs/dmalloc.pdf
	dohtml RELEASE.html docs/dmalloc.html
	doinfo docs/dmalloc.info
}
