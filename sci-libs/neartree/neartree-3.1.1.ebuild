# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/neartree/neartree-3.1.1.ebuild,v 1.1 2011/12/14 09:20:30 jlec Exp $

EAPI=4

inherit base flag-o-matic multilib toolchain-funcs versionator

MY_PN=NearTree
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Function library efficiently solving the Nearest Neighbor Problem(known as the post office problem)"
HOMEPAGE="http://neartree.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${MY_P}/${MY_P}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="dev-libs/cvector"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${MY_P}

src_prepare() {
	epatch \
		"${FILESDIR}"/${PV}-test.patch \
		"${FILESDIR}"/${PV}-gentoo.patch \
		"${FILESDIR}"/${PV}-notest.patch

	sed \
		-e "s:GENTOOLIBDIR:$(get_libdir):g" \
		-e "s:/usr:${EPREFIX}/usr:g" \
		-i Makefile || die

	tc-export CC CXX
}

src_compile() {
	emake all
}

src_install() {
	default

	dodoc README_NearTree.txt
	dohtml *.html
}
