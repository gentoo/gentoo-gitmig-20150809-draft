# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/cqrlib/cqrlib-1.0.3.ebuild,v 1.1 2010/02/03 22:12:21 jlec Exp $

inherit base flag-o-matic toolchain-funcs

MY_PN=CQRlib
MY_P="${MY_PN}-${PV}"

DESCRIPTION="An ANSI C implementation of a utility library for quaternion arithmetic and quaternion rotation math"
HOMEPAGE="http://cqrlib.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/cvector"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${MY_P}

PATCHES=(
	"${FILESDIR}"/${PV}-LDFLAGS.patch
	)

src_compile() {
	append-flags -ansi
	emake \
		CC=$(tc-getCC) \
		CXX=$(tc-getCXX) \
		CFLAGS="${CFLAGS}" \
		all || die
}

src_test() {
	emake tests || die
}

src_install() {
	dobin bin/* || die
	dolib.a lib/.libs/*.a || die

	insinto /usr/include
	doins *.h || die

	dodoc README_CQRlib.txt || die
}
