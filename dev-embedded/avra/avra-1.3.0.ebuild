# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/avra/avra-1.3.0.ebuild,v 1.1 2010/08/11 21:12:26 scarabeus Exp $

EAPI=3

inherit autotools

DESCRIPTION="Atmel AVR Assembler"
HOMEPAGE="http://avra.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc examples"

S="${WORKDIR}/${P}/src/"

src_prepare() {
	eautoreconf
}

src_install() {
	local datadir="${WORKDIR}/${P}"

	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc ${datadir}/{AUTHORS,INSTALL,README,TODO} || die

	# install headers
	insinto "${EPREFIX}/usr/include/avr"
	doins "${datadir}/includes/"* || die

	if use doc; then
		dohtml -r "${datadir}/doc/"* || die
	fi

	if use examples; then
		insinto "${EPREFIX}/usr/share/doc/${PF}/examples"
		doins "${datadir}/examples/"* || die
	fi
}
