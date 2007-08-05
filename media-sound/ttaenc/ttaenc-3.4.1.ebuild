# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ttaenc/ttaenc-3.4.1.ebuild,v 1.1 2007/08/05 11:41:21 drac Exp $

inherit toolchain-funcs

DESCRIPTION="True Audio Compressor Software"
HOMEPAGE="http://tta.sourceforge.net"
SRC_URI="mirror://sourceforge/tta/${P}-src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=""
DEPEND="sys-apps/sed"

S="${WORKDIR}"/${P}-src

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s:gcc:$(tc-getCC):g" Makefile
}

src_compile () {
	emake CFLAGS="${CFLAGS}" || die "emake failed."
}

src_install () {
	dobin ttaenc
	dodoc ChangeLog-${PV} README
}
