# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/linux-atm/linux-atm-2.4.1.ebuild,v 1.1 2003/09/03 17:45:58 mholzer Exp $

DESCRIPTION="Linux Point-to-Point Tunnelling Protocol Server"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://linux-atm.sourceforge.net/"

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

src_compile() {
	econf || die
	sed -i 's:hosts.atm :hosts.atm ${D}:' src/config/Makefile
	emake || die
}

src_install () {
	make \
	DESTDIR=${D} \
	man_prefix=/usr/share/man \
	install || die

	dodoc README NEWS THANKS AUTHORS BUGS COPYING* INSTALL ChangeLog
	dodoc doc/README* doc/atm*
}
