# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libpqpp/libpqpp-4.0-r6.ebuild,v 1.3 2006/11/09 15:24:08 dev-zero Exp $

inherit eutils toolchain-funcs multilib

KEYWORDS="amd64 ~sparc ~x86"

MY_P=${P/pp/++}

DESCRIPTION="C++ wrapper for the libpq Postgresql library"
HOMEPAGE="http://gborg.postgresql.org/"
SRC_URI="ftp://gborg.postgresql.org/pub/libpqpp/stable/${MY_P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

DEPEND="dev-db/libpq"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gentoo.patch"
	epatch "${FILESDIR}/${P}-Makefile.patch"
}

src_compile() {
	emake CXX="$(tc-getCXX)" CXXFLAGS="${CXXFLAGS}" LIBDIR="$(get_libdir)" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" LIBDIR="$(get_libdir)" install || die "emake install failed"
	dodoc README CHANGES
}
