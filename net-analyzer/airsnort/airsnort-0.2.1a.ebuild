# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/airsnort/airsnort-0.2.1a.ebuild,v 1.4 2002/09/08 21:03:56 owen Exp $

MY_P=${P/a/A}
S=${WORKDIR}/${MY_P}
DESCRIPTION="AirSnort 802.11b Wireless Packet Sniffer/WEP Cracker"
HOMEPAGE="http://airsnort.shmoo.com/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND=">=sys-devel/autoconf-2.13
	>=x11-libs/gtk+-1.2.10-r8
	>=net-libs/libpcap-0.7.1
	>=sys-apps/pcmcia-cs-3.1.33"

src_compile() {
	./autogen.sh \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./autogen failed"
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
}
