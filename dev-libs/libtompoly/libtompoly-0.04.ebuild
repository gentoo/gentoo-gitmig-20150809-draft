# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtompoly/libtompoly-0.04.ebuild,v 1.8 2011/06/10 01:09:34 radhermit Exp $

inherit toolchain-funcs

DESCRIPTION="portable ISO C library for polynomial basis arithmetic"
HOMEPAGE="http://poly.libtomcrypt.org/"
SRC_URI="http://poly.libtomcrypt.org/files/ltp-${PV}.tar.bz2"

LICENSE="WTFPL-2"
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
