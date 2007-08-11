# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/yconsole/yconsole-3.4.3.ebuild,v 1.4 2007/08/11 03:35:21 beandog Exp $

inherit eutils toolchain-funcs

DESCRIPTION="User interface to control and monitor the Y server"
HOMEPAGE="http://wolfpack.twu.net/YIFF"
SRC_URI="ftp://wolfpack.twu.net/users/wolfpack/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1*
	media-libs/imlib
	media-libs/yiff"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-Makefile.patch
	epatch "${FILESDIR}"/${P}-implicit-declaration.patch
}

src_compile() {
	cd ${PN}
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" \
		CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" || die "emake failed."
}

src_install() {
	dodoc AUTHORS README

	cd ${PN}
	emake PREFIX="${D}"/usr install || die "emake install failed."
}
