# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/avr-gcc/avr-gcc-3.4.2.ebuild,v 1.1 2004/09/23 15:57:39 dragonheart Exp $

IUSE="nls"

MY_P=${P/avr-/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="The GNU C compiler for the AVR microcontroller architecture"
HOMEPAGE="http://www.avrfreaks.net/AVRGCC"
SRC_URI="mirror://gnu/gcc/${MY_P}/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-*"
#KEYWORDS="~x86"

DEPEND="virtual/glibc
	>=dev-embedded/avr-binutils-2.15"

src_compile() {
	# Build in a separate build tree
	mkdir -p ${WORKDIR}/build
	cd ${WORKDIR}/build

	einfo "Configuring GCC..."
	#addwrite "/dev/zero"
	${S}/configure \
		--prefix=/usr \
		--target=avr \
		--enable-languages=c \
		`use_enable nls` || die

	emake || die
}

src_install() {
	cd ${WORKDIR}/build
	emake DESTDIR=${D} install|| die
	rm -rf ${D}/usr/share ${D}/include
}
