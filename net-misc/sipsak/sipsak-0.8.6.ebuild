# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sipsak/sipsak-0.8.6.ebuild,v 1.2 2004/06/25 00:11:13 agriffis Exp $

IUSE=""

DESCRIPTION="small comand line tool for testing SIP applications and devices"
HOMEPAGE="http://sipsak.berlios.de/"
SRC_URI="http://download.berlios.de/sipsak/${P}-1.tar.gz"
S=${WORKDIR}/${P}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/glibc"

src_compile() {
	econf || die

	emake || die
}

src_install() {
	einstall || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}
