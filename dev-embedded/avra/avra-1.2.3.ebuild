# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/avra/avra-1.2.3.ebuild,v 1.5 2010/08/11 21:12:26 scarabeus Exp $

EAPI=2
inherit autotools

PSRC=${P}a

DESCRIPTION="Atmel AVR Assembler"
HOMEPAGE="http://avra.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PSRC}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="examples"

src_prepare() {
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog README

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins Example/*
	fi
}
