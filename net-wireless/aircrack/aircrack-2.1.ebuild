# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/aircrack/aircrack-2.1.ebuild,v 1.2 2005/01/29 21:27:40 dragonheart Exp $

inherit toolchain-funcs

DESCRIPTION="WLAN tool for breaking 802.11 WEP keys"
HOMEPAGE="http://www.cr0.net:8040/code/network/aircrack/"
SRC_URI="http://www.cr0.net:8040/code/network/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/libc
	virtual/libpcap"

src_compile() {
	emake CC=$(tc-getCC) || die "emake failed"
}

src_install() {
	emake prefix=/usr docdir=/usr/share/doc/${PF} DESTDIR=${D} install doc \
		|| die "emake install failed"
}

