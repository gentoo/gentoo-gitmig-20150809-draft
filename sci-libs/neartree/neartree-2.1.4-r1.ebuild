# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/neartree/neartree-2.1.4-r1.ebuild,v 1.1 2010/03/07 18:48:36 jlec Exp $

EAPI="3"

inherit base flag-o-matic multilib toolchain-funcs versionator

MY_PN=NearTree
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Function library efficiently solving the Nearest Neighbor Problem(known as the post office problem)"
HOMEPAGE="http://neartree.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}/${MY_PN}.zip -> ${P}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="dev-libs/cvector"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-FLAGS.patch
	epatch "${FILESDIR}"/${PV}-gcc4.3.patch
	epatch "${FILESDIR}"/${PV}-iterator.patch
	epatch "${FILESDIR}"/${PV}-test.patch
	epatch "${FILESDIR}"/${PV}-dynlib.patch

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

src_install() {
	dolib.so *.so.${PV} || die
	dosym libCNearTree.so.${PV} /usr/$(get_libdir)/libCNearTree.so.$(get_version_component_range 1-2) || die
	dosym libCNearTree.so.${PV} /usr/$(get_libdir)/libCNearTree.so.$(get_major_version) || die
	dosym libCNearTree.so.${PV} /usr/$(get_libdir)/libCNearTree.so || die

	insinto /usr/include
	doins CNearTree.h || die

	dodoc README_NearTree.txt || die
	dohtml *.html || die
}
