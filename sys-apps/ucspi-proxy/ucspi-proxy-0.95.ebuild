# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ucspi-proxy/ucspi-proxy-0.95.ebuild,v 1.2 2003/09/07 00:39:09 msterret Exp $

DESCRIPTION="A proxy program that passes data back and forth between two connections set up by a UCSPI server and a UCSPI client."
HOMEPAGE="http://untroubled.org/ucspi-proxy/"
SRC_URI="http://untroubled.org/ucspi-proxy/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="sys-devel/gcc-config"
RDEPEND="virtual/glibc"

S=${WORKDIR}/${P}

src_compile() {
	emake CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" || die
}

src_install() {
	einstall || die
	dodoc ANNOUNCEMENT NEWS README TODO
}
