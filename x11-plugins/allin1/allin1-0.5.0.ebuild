# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/allin1/allin1-0.5.0.ebuild,v 1.2 2004/09/02 18:22:39 pvdabeel Exp $

DESCRIPTION="All in one monitoring dockapp: RAM, CPU, Net, Power, df, seti"
HOMEPAGE="http://ilpettegolo.altervista.org/linux_allin1.en.shtml"
SRC_URI="mirror://sourceforge/allinone/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc"
IUSE=""
DEPEND="virtual/x11"

src_compile()
{
	emake CFLAGS="${CFLAGS}" || die "Compilation failed"
}

src_install() {
	dobin src/allin1
	doman docs/allin1.1
	dodoc README README.it TODO ChangeLog BUGS src/allin1.conf.example
}
