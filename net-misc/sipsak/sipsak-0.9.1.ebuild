# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sipsak/sipsak-0.9.1.ebuild,v 1.1 2005/08/21 05:49:30 dragonheart Exp $

IUSE=""

DESCRIPTION="small command line tool for testing SIP applications and devices"
HOMEPAGE="http://sipsak.org/"
SRC_URI="http://download.berlios.de/sipsak/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"

DEPEND="virtual/libc"

src_install() {
	emake DESTDIR=${D} install || die "install failed"

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}
