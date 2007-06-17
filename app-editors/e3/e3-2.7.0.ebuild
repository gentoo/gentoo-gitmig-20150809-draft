# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/e3/e3-2.7.0.ebuild,v 1.3 2007/06/17 11:13:57 opfer Exp $

DESCRIPTION="Very tiny editor in x86 ASM with emacs, pico, wordstar, and vi keybindings"
HOMEPAGE="http://www.sax.de/~adlibit/"
SRC_URI="http://www.sax.de/~adlibit/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE=""
RESTRICT="strip"

DEPEND="dev-lang/nasm"
RDEPEND=""
PROVIDE="virtual/editor"

src_install() {
	use amd64 && newbin ${S}/bin/Linux_x86-64/e3 e3 || die "newbin failed"
	use x86 && newbin ${S}/bin/Linux/e3 e3 || die "newbin failed"
	dosym e3 /usr/bin/e3vi
	dosym e3 /usr/bin/e3em
	dosym e3 /usr/bin/e3ws
	dosym e3 /usr/bin/e3pi
	dosym e3 /usr/bin/e3ne
	newman e3.man e3.1
}
