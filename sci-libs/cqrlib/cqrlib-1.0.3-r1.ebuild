# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/cqrlib/cqrlib-1.0.3-r1.ebuild,v 1.2 2010/03/07 18:49:41 jlec Exp $

inherit base flag-o-matic multilib toolchain-funcs versionator

MY_PN=CQRlib
MY_P="${MY_PN}-${PV}"

DESCRIPTION="An ANSI C implementation of a utility library for quaternion arithmetic and quaternion rotation math"
HOMEPAGE="http://cqrlib.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="dev-libs/cvector"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${MY_P}

PATCHES=(
	"${FILESDIR}"/${PV}-LDFLAGS.patch
	"${FILESDIR}"/${PV}-dynlib.patch
	)

src_compile() {
	append-flags -ansi
	emake -j1 \
		CC=$(tc-getCC) \
		CXX=$(tc-getCXX) \
		CFLAGS="${CFLAGS}" \
		all || die
}

src_install() {
	dolib.so *.so.${PV} || die
	dosym libCQRlib.so.${PV} /usr/$(get_libdir)/libCQRlib.so.$(get_version_component_range 1-2) || die
	dosym libCQRlib.so.${PV} /usr/$(get_libdir)/libCQRlib.so.$(get_major_version) || die
	dosym libCQRlib.so.${PV} /usr/$(get_libdir)/libCQRlib.so || die

	insinto /usr/include
	doins *.h || die

	dodoc README_CQRlib.txt || die
}
