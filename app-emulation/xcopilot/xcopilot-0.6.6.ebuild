# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/xcopilot/xcopilot-0.6.6.ebuild,v 1.1 2004/01/27 01:40:13 zul Exp $

MY_P="xcopilot-0.6.6-uc0"

DESCRIPTION="A pilot emulator."
SRC_URI="http://www.uclinux.org/pub/uClinux/utilities/${MY_P}.tar.gz"
HOMEPAGE="http://www.uclinux.org"

KEYWORDS="~x86"
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
