# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/avr-libc/avr-libc-1.0.2-r1.ebuild,v 1.5 2004/07/21 10:52:59 pappy Exp $

# MY_P=${P/avr-/}
# SRC_URI="http://savannah.nongnu.org/download/avr-libc/${MY_P}.tar.bz2"

DESCRIPTION="Libc for the AVR microcontroller architecture"
HOMEPAGE="http:////www.nongnu.org/avr-libc/"

# eiter .tar.gz or tar.bz2
SRC_URI="http://savannah.nongnu.org/download/avr-libc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="nls"

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

