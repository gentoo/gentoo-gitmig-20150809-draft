# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libpqpp/libpqpp-4.0-r6.ebuild,v 1.2 2005/05/09 11:55:40 nakano Exp $

inherit eutils toolchain-funcs multilib

IUSE=""
MY_P=${P/pp/++}
DESCRIPTION="C++ wrapper for the libpq Postgresql library"
HOMEPAGE="http://gborg.postgresql.org/"
SRC_URI="ftp://gborg.postgresql.org/pub/libpqpp/stable/${MY_P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"

DEPEND="virtual/libc
	dev-db/libpq
	>=sys-apps/sed-4"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch
	epatch ${FILESDIR}/${P}-Makefile.patch
}

src_compile() {
	emake CXX="$(tc-getCXX)" CXXFLAGS="${CXXFLAGS}" LIBDIR="$(get_libdir)" || die
}

src_install() {
	make DESTDIR="${D}" LIBDIR="$(get_libdir)" install || die
	dodoc README CHANGES
}
