# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wireless-tools/wireless-tools-26_pre8.ebuild,v 1.1 2003/04/24 23:05:16 pylon Exp $

MY_P=wireless_tools.${PV/_/\.}
S=${WORKDIR}/${MY_P/.pre8/}
DESCRIPTION="A collection of tools to configure wireless lan cards."
SRC_URI="http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/${MY_P}.tar.gz"
HOMEPAGE="http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/Tools.html"
KEYWORDS="~x86 ~ppc ~sparc"
SLOT="0"
LICENSE="GPL-2"
DEPEND="virtual/glibc"
RDEPEND="${DEPEND}"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}

	check_KV

	mv Makefile ${T}
	sed -e "s:# KERNEL_SRC:KERNEL_SRC:" \
		${T}/Makefile > Makefile
}
src_compile() {
	emake CFLAGS="$CFLAGS" || die
}

src_install () {
	dosbin iwconfig iwevent iwgetid iwpriv iwlist iwspy
	dolib libiw.so.26 libiw.a
	doman iwconfig.8 iwlist.8 iwpriv.8 iwspy.8
	dodoc CHANGELOG.h COPYING INSTALL PCMCIA.txt README
}
