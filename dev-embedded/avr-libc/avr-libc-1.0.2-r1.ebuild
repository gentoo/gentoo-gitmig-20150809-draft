# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/avr-libc/avr-libc-1.0.2-r1.ebuild,v 1.2 2004/03/15 02:18:57 seemant Exp $

IUSE="nls"

MY_P=${P/avr-/}
DESCRIPTION="Libc for the AVR microcontroller architecture"
HOMEPAGE="http:////www.nongnu.org/avr-libc/"
SRC_URI="http://savannah.nongnu.org/download/avr-libc/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="dev-embedded/avr-gcc"

src_compile() {
	mkdir obj-avr
	cd obj-avr
	CC=avr-gcc CFLAGS="" ../configure \
		--target=avr \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		`use_enable nls` || die "./configure failed"

	emake || die
}

src_install() {
	cd obj-avr
	einstall || die
}
