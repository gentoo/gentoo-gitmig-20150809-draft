# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtompoly/libtompoly-0.04.ebuild,v 1.7 2009/07/29 00:05:25 vostorga Exp $

inherit toolchain-funcs

DESCRIPTION="portable ISO C library for polynomial basis arithmetic"
HOMEPAGE="http://poly.libtomcrypt.org/"
SRC_URI="http://poly.libtomcrypt.org/files/ltp-${PV}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="dev-libs/libtommath"
RDEPEND="${DEPEND}"

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc changes.txt *.pdf
	docinto demo ; dodoc demo/*
}
