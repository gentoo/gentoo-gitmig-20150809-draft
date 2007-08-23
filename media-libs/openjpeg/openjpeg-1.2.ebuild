# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/openjpeg/openjpeg-1.2.ebuild,v 1.2 2007/08/23 10:44:07 uberlord Exp $

inherit flag-o-matic toolchain-funcs multilib

DESCRIPTION="An open-source JPEG 2000 codec written in C"
HOMEPAGE="http://www.openjpeg.org/"
SRC_URI="http://www.openjpeg.org/openjpeg_v${PV//./_}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE=""

S="${WORKDIR}/trunk"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-Makefile.patch
}

src_compile() {
	append-flags -fPIC
	emake CC="$(tc-getCC)" AR="$(tc-getAR)" COMPILERFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" INSTALL_LIBDIR="/usr/$(get_libdir)" install || die "install failed"

	dodoc ChangeLog
}
