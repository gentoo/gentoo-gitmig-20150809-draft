# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wireless-tools/wireless-tools-27_pre28.ebuild,v 1.2 2004/11/06 14:34:25 pylon Exp $

# The following works with both pre-releases and releases
MY_P=${PN/-/_}.${PV/_/.}
S=${WORKDIR}/${MY_P/\.pre*/}

DESCRIPTION="A collection of tools to configure wireless lan cards."
SRC_URI="http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/${MY_P}.tar.gz"
HOMEPAGE="http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/Tools.html"

KEYWORDS="~x86 ~amd64 ppc ~hppa"
SLOT="0"
LICENSE="GPL-2"

DEPEND="sys-apps/sed"
RDEPEND="virtual/libc"
IUSE="nls"

src_unpack() {
	unpack ${A}

	sed -i "s:^CFLAGS=:CFLAGS=${CFLAGS} :" \
		${S}/Makefile

	sed -i "s:\(@\$(LDCONFIG).*\):#\1:" \
		${S}/Makefile

	sed -i "s:^\(INSTALL_MAN= \$(PREFIX)\)/man/:\1/share/man:" \
		${S}/Makefile
}

src_compile() {
	emake WARN="" || die "emake failed"
}

src_install () {
	emake PREFIX=${D}/usr install || die "emake install failed"

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
