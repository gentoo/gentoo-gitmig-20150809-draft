# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.8 2002/05/30 01:54:49 sandymac Exp

DESCRIPTION="AirSnort 802.11b Wireless Packet Sniffer/WEP Cracker"
HOMEPAGE="http://airsnort.shmoo.com/"
LICENSE="GPL-2"
SLOT="0"

DEPEND="
	>=sys-devel/autoconf-2.13
	>=x11-libs/gtk+-1.2.10-r8
	>=net-libs/libpcap-0.7.1
	>=sys-apps/pcmcia-cs-3.1.33
	"

SRC_URI="http://telia.dl.sourceforge.net/sourceforge/airsnort/Airsnort-0.2.1a.tar.gz"

S=${WORKDIR}/Airsnort-0.2.1a

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
