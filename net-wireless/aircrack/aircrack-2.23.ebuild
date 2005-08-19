# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/aircrack/aircrack-2.23.ebuild,v 1.1 2005/08/19 23:22:12 vanquirius Exp $

inherit toolchain-funcs

MY_P=${P/_b/-b}

DESCRIPTION="WLAN tool for breaking 802.11 WEP keys"
HOMEPAGE="http://www.cr0.net:8040/code/network/aircrack/"
SRC_URI="http://100h.org/wlan/aircrack/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="virtual/libc
	virtual/libpcap"
S=${WORKDIR}/${MY_P}

src_compile() {
	emake -e CC=$(tc-getCC) || die "emake failed"
}

src_install() {
	emake prefix=/usr docdir=/usr/share/doc/${PF} DESTDIR=${D} install doc \
		|| die "emake install failed"
}

