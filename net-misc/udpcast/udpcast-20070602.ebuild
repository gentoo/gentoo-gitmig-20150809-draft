# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/udpcast/udpcast-20070602.ebuild,v 1.2 2008/01/26 17:07:15 armin76 Exp $

DESCRIPTION="Multicast file transfer tool"
HOMEPAGE="http://udpcast.linux.lu/"
SRC_URI="http://udpcast.linux.lu/download/${P}.tar.bz2"

IUSE=""
LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~amd64 x86"

DEPEND="dev-lang/perl"

src_install() {
	emake DESTDIR="${D}" || die "emake install failed"
	dodoc *.txt
}
