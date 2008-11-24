# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ethstatus/ethstatus-0.4.2-r2.ebuild,v 1.7 2008/11/24 15:57:54 s4t4n Exp $

DESCRIPTION="ncurses based utility to display real time statistics about network traffic."
HOMEPAGE="http://ethstatus.calle69.net/"
SRC_URI="mirror://debian/pool/main/e/ethstatus/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND=">=sys-libs/ncurses-5.4-r1"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4.1.4-r1"

src_unpack()
{
	unpack ${A}

	#Fix LDFLAGS ordering, see bug #247926
	sed -i 's/$(LDFLAGS) -o ${BIN} ${SRC}/-o ${BIN} ${SRC} $(LDFLAGS)/' "${S}/Makefile"
}

src_compile()
{
	emake CFLAGS="${CFLAGS}" || die "Compilation failed"
}

src_install()
{
	dobin ethstatus
	doman ethstatus.1
	dodoc CHANGELOG README
}
