# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/avra/avra-1.0.1.ebuild,v 1.3 2007/11/23 21:39:57 drac Exp $

inherit toolchain-funcs

DESCRIPTION="Atmel AVR Assembler"
HOMEPAGE="http://avra.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="examples"

RDEPEND=""
DEPEND=""

S="${WORKDIR}"

src_compile() {
	cd SOURCE
	emake all CC="$(tc-getCC)" CFLAGS="${CFLAGS}" \
		LD="$(tc-getCC)" LDFLAGS="${LDFLAGS}" \
		|| die "emake failed."
}

src_install() {
	dobin SOURCE/avra
	dodoc ChangeLog README

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins TEST/*
	fi
}
