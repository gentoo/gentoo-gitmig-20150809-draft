# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wireless-tools/wireless-tools-27_pre27.ebuild,v 1.1 2004/10/19 07:46:59 brix Exp $

MY_P=wireless_tools.${PV/_/\.}
S=${WORKDIR}/${MY_P/.pre27/}
DESCRIPTION="A collection of tools to configure wireless lan cards."
SRC_URI="http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/${MY_P}.tar.gz"
HOMEPAGE="http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/Tools.html"
KEYWORDS="~x86 ~amd64 ~ppc ~hppa"
SLOT="0"
LICENSE="GPL-2"
DEPEND="virtual/libc"
IUSE="nls"

src_unpack() {
	unpack ${A}

	sed -i "s:^CFLAGS=:CFLAGS=${CFLAGS} :" \
		${S}/Makefile
}

src_compile() {
	emake WARN="" || die
}

src_install () {
	dosbin iwconfig iwevent iwgetid iwpriv iwlist iwspy ifrename

	dolib libiw.so.27
	insinto /usr/include/
	doins iwlib.h wireless.h
	dosym /usr/lib/libiw.so.27 /usr/lib/libiw.so

	doman {iwconfig,iwlist,iwpriv,iwspy,iwgetid,iwevent,ifrename}.8 \
		wireless.7 iftab.5

	if use nls; then
		insinto /usr/share/man/fr/man8
		doins {iwconfig,iwlist,iwpriv,iwspy,iwgetid,iwevent}.8
		dodoc README.fr
	fi

	dodoc CHANGELOG.h COPYING INSTALL HOTPLUG.txt PCMCIA.txt README
}
