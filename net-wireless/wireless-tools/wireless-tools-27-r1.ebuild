# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wireless-tools/wireless-tools-27-r1.ebuild,v 1.8 2006/04/24 07:37:28 brix Exp $

# The following works with both pre-releases and releases
MY_P=${PN/-/_}.${PV/_/.}
S=${WORKDIR}/${MY_P/\.pre*/}

DESCRIPTION="A collection of tools to configure IEEE 802.11 wireless LAN cards."
SRC_URI="http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/${MY_P}.tar.gz"
HOMEPAGE="http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/Tools.html"

KEYWORDS="amd64 hppa ~mips ppc ppc64 x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="sys-apps/sed"
RDEPEND="virtual/libc"
IUSE="nls"

src_unpack() {
	unpack ${A}

	sed -i \
		-e "s:^CFLAGS=:CFLAGS=${CFLAGS} :" \
		-e "s:\(@\$(LDCONFIG).*\):#\1:" \
		${S}/Makefile
}

src_compile() {
	emake WARN="" || die "emake failed"
}

src_install () {
	emake PREFIX=${D}/ INSTALL_INC=${D}/usr/include INSTALL_MAN=${D}/usr/share/man install \
		|| die "emake install failed"

	if use nls; then
		insinto /usr/share/man/fr/man5
		doins fr/iftab.5

		insinto /usr/share/man/fr/man7
		doins fr/wireless.7

		insinto /usr/share/man/fr/man8
		doins fr/{ifrename,iwconfig,iwevent,iwgetid,iwlist,iwpriv,iwspy}.8

		dodoc README.fr
	fi

	dodoc CHANGELOG.h COPYING INSTALL HOTPLUG.txt PCMCIA.txt README
}
