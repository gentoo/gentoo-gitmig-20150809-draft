# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sipsak/sipsak-0.8.12.ebuild,v 1.1 2005/05/07 14:18:03 stkn Exp $

IUSE=""

DESCRIPTION="small command line tool for testing SIP applications and devices"
HOMEPAGE="http://sipsak.berlios.de/"
SRC_URI="http://download.berlios.de/sipsak/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc"

DEPEND="virtual/libc"

src_compile() {
	econf || die "configure failed"

	emake || die "make failed"
}

src_install() {
	einstall || die "install failed"

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}
