# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/aircrack/aircrack-2.41-r1.ebuild,v 1.5 2006/10/23 16:25:19 alonbl Exp $

inherit toolchain-funcs eutils

MY_P="${P/_b/-b}"

DESCRIPTION="WLAN tool for breaking 802.11 WEP keys"
HOMEPAGE="http://freshmeat.net/projects/aircrack/"
# HOMEPAGE="http://www.cr0.net:8040/code/network/aircrack/"
# original homepage is gone - bug 119981
SRC_URI="mirror://gentoo/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="virtual/libc
	net-libs/libpcap"
S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-stack.diff
}

src_compile() {
	emake -e CC=$(tc-getCC) || die "emake failed"
}

src_test() {
	# Upstream uses signal in order to quit,
	# So protect busybox with interactive shell.
	/bin/sh -ci "./aircrack test/wpa.cap -w test/password.lst" || die 'cracking WPA key failed'

	#cd test
	#$(tc-getCC) $(CFLAGS) kstats.c  -o kstats
	#$(tc-getCC) $(CFLAGS)  makeivs.c -o makeivs
	#./makeivs iv.dat 33333333333333333333333333
	# SIGQUIT does not play nicely with sanbox
	#../aircrack ./iv.dat 
	#|| die 'second selftest failed'
}

src_install() {
	emake prefix=/usr docdir="/usr/share/doc/${PF}" DESTDIR="${D}" install doc \
		|| die "emake install failed"
}

