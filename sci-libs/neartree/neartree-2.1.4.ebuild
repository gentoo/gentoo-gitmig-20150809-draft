# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/neartree/neartree-2.1.4.ebuild,v 1.1 2010/02/03 20:23:57 jlec Exp $

EAPI="3"

inherit eutils flag-o-matic toolchain-funcs

MY_PN=NearTree
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Function library efficiently solving the Nearest Neighbor Problem(known as the post office problem)"
HOMEPAGE="http://neartree.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}/${MY_PN}.zip -> ${P}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/cvector"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-FLAGS.patch
	epatch "${FILESDIR}"/${PV}-gcc4.3.patch
	epatch "${FILESDIR}"/${PV}-iterator.patch
	epatch "${FILESDIR}"/${PV}-test.patch

	sed \
		-e "s:GENTOOLIBDIR:$(get_libdir):g" \
		-e "s:/usr:${EPREFIX}/usr:g" \
		-i Makefile
}

src_compile() {
	emake \
		CC=$(tc-getCC) \
		CXX=$(tc-getCXX) \
		all || die
}

src_test() {
	emake \
		CC=$(tc-getCC) \
		CXX=$(tc-getCXX) \
		tests || die
}

src_install() {
	dobin bin/* || die "failed to install bins"
	dolib.a lib/.libs/*.a || die "failed to install libs"

	insinto /usr/include
	doins *.h || die "failed to install includes"

	dodoc README_NearTree.txt || die
	dohtml *.html || die
}
