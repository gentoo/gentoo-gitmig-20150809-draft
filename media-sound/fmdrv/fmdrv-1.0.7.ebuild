# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/fmdrv/fmdrv-1.0.7.ebuild,v 1.1 2004/03/18 16:21:50 eradicator Exp $

DESCRIPTION="Console mode MIDI player with builtin userland OPL2 driver"
HOMEPAGE="http://bisqwit.iki.fi/source/fmdrv.html"
SRC_URI="http://bisqwit.iki.fi/src/arch/${P}.tar.bz2"

KEYWORDS="~x86"
SLOT="0"

# See file
LICENSE="as-is"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e "s:BINDIR=/usr/local/bin:BINDIR=${D}usr/bin:" \
		Makefile

	echo "" > .depend
}


src_compile() {
	emake fmdrv || die
}

src_install() {
	dobin fmdrv
	dodoc TINYFREELICENSE README README.html
}

pkg_postinst() {
	einfo "If you want to use AdLib (FM OPL2), you need to setuid /usr/bin/fmdv."
	einfo "chmod 4711 /usr/bin/fmdrv"
}
