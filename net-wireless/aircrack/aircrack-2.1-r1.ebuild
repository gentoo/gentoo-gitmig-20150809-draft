# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/aircrack/aircrack-2.1-r1.ebuild,v 1.4 2005/05/21 21:45:52 dholm Exp $

inherit toolchain-funcs eutils

DESCRIPTION="WLAN tool for breaking 802.11 WEP keys"
HOMEPAGE="http://www.cr0.net:8040/code/network/aircrack/"
SRC_URI="mirror://gentoo/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="virtual/libc
	virtual/libpcap"

src_unpack(){
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-amd64.patch
}

src_compile() {
	emake CC=$(tc-getCC) || die "emake failed"
}

src_install() {
	emake prefix=/usr docdir=/usr/share/doc/${PF} DESTDIR=${D} install doc \
		|| die "emake install failed"
}

