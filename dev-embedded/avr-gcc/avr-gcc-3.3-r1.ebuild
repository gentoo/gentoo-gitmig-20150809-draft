# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/avr-gcc/avr-gcc-3.3-r1.ebuild,v 1.8 2004/06/29 13:21:27 vapier Exp $

MY_P=${P/avr-/}
DESCRIPTION="The GNU C compiler for the AVR microcontroller architecture"
HOMEPAGE="http://sources.redhat.com/binutils"
SRC_URI="http://ftp.gnu.org/gnu/gcc/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="nls"

DEPEND="virtual/libc
	dev-embedded/avr-binutils"

S=${WORKDIR}/${MY_P}

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
