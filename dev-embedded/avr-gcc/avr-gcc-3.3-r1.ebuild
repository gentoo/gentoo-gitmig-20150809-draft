# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/avr-gcc/avr-gcc-3.3-r1.ebuild,v 1.4 2004/03/15 02:19:51 seemant Exp $

IUSE="nls"

MY_P=${P/avr-/}
DESCRIPTION="The GNU C compiler for the AVR microcontroller architecture"
HOMEPAGE="http://sources.redhat.com/binutils"
SRC_URI="http://ftp.gnu.org/gnu/gcc/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/glibc
	dev-embedded/avr-binutils"

src_compile() {
	econf \
		--target=avr \
		--enable-languages=c \
		`use_enable nls` || die

	emake || die
}

src_install() {
	einstall || die
}
