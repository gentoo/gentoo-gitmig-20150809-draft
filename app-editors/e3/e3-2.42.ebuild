# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/e3/e3-2.42.ebuild,v 1.2 2003/04/18 17:53:36 avenj Exp $

DESCRIPTION="Super Tiny Editor with wordstar, vi, and emacs key bindings"
SRC_URI="http://www.sax.de/~adlibit/${P}.tar.gz"
HOMEPAGE="http://www.sax.de/~adlibit"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* x86"

DEPEND="dev-lang/nasm"
RDEPEND="sys-apps/sed"

RESTRICT="nostrip"

IUSE=""

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
}

src_compile() {
	emake || die
}

src_install() {
	dodir /usr/bin
	dobin e3
	dosym e3 /usr/bin/e3vi
	dosym e3 /usr/bin/e3em
	dosym e3 /usr/bin/e3ws
	dosym e3 /usr/bin/e3pi
	dosym e3 /usr/bin/e3ne
	if [ "`use build`" ]; then
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
