# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wireless-tools/wireless-tools-28_pre3.ebuild,v 1.1 2004/11/24 20:04:25 brix Exp $

inherit toolchain-funcs

# The following works with both pre-releases and releases
MY_P=${PN/-/_}.${PV/_/.}
S=${WORKDIR}/${MY_P/\.pre*/}

DESCRIPTION="A collection of tools to configure wireless LAN cards"
SRC_URI="http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/${MY_P}.tar.gz"
HOMEPAGE="http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/Tools.html"

KEYWORDS="~x86 ~amd64 ~ppc ~hppa ~alpha"
SLOT="0"
LICENSE="GPL-2"

DEPEND="sys-apps/sed"
RDEPEND="virtual/libc"
IUSE="multicall nls"

src_unpack() {
	unpack ${A}

	sed -i "s:gcc:$(tc-getCC):" \
		${S}/Makefile

	sed -i "s:ar:$(tc-getAR):" \
		${S}/Makefile

	sed -i "s:ranlib:$(tc-getRANLIB):" \
		${S}/Makefile

	sed -i "s:^\(CFLAGS=-Os\):#\1:" \
		${S}/Makefile

	sed -i "s:\(@\$(LDCONFIG).*\):#\1:" \
		${S}/Makefile

	sed -i "s:^\(INSTALL_MAN= \$(PREFIX)\)/man/:\1/share/man:" \
		${S}/Makefile
}

src_compile() {
	if use multicall
	then
		emake || die "emake failed"
		emake iwmulticall || die "emake iwmulticall failed"
	else
		emake || die "emake failed"
	fi
}

src_install() {
	if use multicall
	then
		emake PREFIX=${D}/usr install || die "emake install failed"
		# 'make install-iwmulticall will overwrite some of the tools
		# with symlinks - this is intentional (brix)
		emake PREFIX=${D}/usr install-iwmulticall || die "emake install-iwmulticall failed"
	else
		emake PREFIX=${D}/usr install || die "emake install failed"
	fi

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
