# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/xcopilot/xcopilot-0.6.6.ebuild,v 1.3 2004/06/24 22:37:38 agriffis Exp $

MY_P="xcopilot-0.6.6-uc0"

DESCRIPTION="A pilot emulator."
SRC_URI="http://www.uclinux.org/pub/uClinux/utilities/${MY_P}.tar.gz"
HOMEPAGE="http://www.uclinux.org"

KEYWORDS="~x86 ~ppc"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="virtual/glibc
		virtual/x11
		app-arch/dpkg"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf --disable-autorun || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS README NEWS README.uClinux

	einfo "See ${D}/usr/share/${P}/README.uClinux for more info"
}
