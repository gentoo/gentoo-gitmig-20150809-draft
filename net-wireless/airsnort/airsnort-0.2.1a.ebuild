# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/airsnort/airsnort-0.2.1a.ebuild,v 1.11 2005/01/29 21:28:22 dragonheart Exp $

MY_P=${P/a/A}
S=${WORKDIR}/${MY_P}
DESCRIPTION="802.11b Wireless Packet Sniffer/WEP Cracker"
HOMEPAGE="http://airsnort.shmoo.com/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc -sparc"
IUSE="pcmcia"

DEPEND=">=sys-devel/autoconf-2.13
	=x11-libs/gtk+-1*
	virtual/libpcap
	pcmcia? ( >=sys-apps/pcmcia-cs-3.1.33 )"

src_compile() {
	./autogen.sh \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./autogen failed"
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README README.crypt Authors ChangeLog TODO
}
pkg_postinst() {
	einfo "Make sure to emerge linux-wlan-ng if you want support"
	einfo "for Prism2 based cards in airsnort."
}
