# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/e3/e3-2.43.ebuild,v 1.8 2007/07/02 13:45:17 peper Exp $

DESCRIPTION="Very tiny editor in x86 ASM with emacs, pico, and vi keybindings"
HOMEPAGE="http://www.sax.de/~adlibit/"
SRC_URI="http://www.sax.de/~adlibit/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* x86"
IUSE="build"
RESTRICT="strip"

DEPEND="dev-lang/nasm"
RDEPEND="sys-apps/sed"

src_compile() {
	emake || die
}

src_install() {
	dodir /usr/bin
	dobin e3 || die
	dosym e3 /usr/bin/e3vi
	dosym e3 /usr/bin/e3em
	dosym e3 /usr/bin/e3ws
	dosym e3 /usr/bin/e3pi
	dosym e3 /usr/bin/e3ne
	if use build ; then
		# easier-to-remember shell scripts
		dobin ${FILESDIR}/vi
		# this one is more trouble than its worth --woodchip
		# dobin ${FILESDIR}/emacs
		dobin ${FILESDIR}/pico
		newbin ${FILESDIR}/pico nano
	fi
	cp e3.man e3.1
	doman e3.1
}
