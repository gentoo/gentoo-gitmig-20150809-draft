# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/cqrlib/cqrlib-1.0.5.ebuild,v 1.6 2011/12/15 08:21:59 jlec Exp $

EAPI=3

inherit base flag-o-matic multilib toolchain-funcs versionator

MY_PN=CQRlib
MY_P="${MY_PN}-${PV}"

DESCRIPTION="An ANSI C implementation of a utility library for quaternion arithmetic and quaternion rotation math"
HOMEPAGE="http://cqrlib.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="dev-libs/cvector"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${MY_P}

PATCHES=(
	"${FILESDIR}"/${PV}-gentoo.patch
	)

src_compile() {
	sed "s:GENTOOLIBDIR:$(get_libdir):g" -i Makefile || die
	append-flags -ansi
	emake \
		CC=$(tc-getCC) \
		CXX=$(tc-getCXX) \
		CFLAGS="${CFLAGS}" \
		CPPFLAGS="${CXXFLAGS} -DCQR_NOCCODE=1" \
		all || die
}

src_test() {
	emake -j1 \
		CC=$(tc-getCC) \
		CXX=$(tc-getCXX) \
		CFLAGS="${CFLAGS}" \
		tests || die
}

src_install() {
	emake -j1 DESTDIR="${ED}" install || die

	dodoc README_CQRlib.txt || die
	dohtml README_CQRlib.html || die
}
