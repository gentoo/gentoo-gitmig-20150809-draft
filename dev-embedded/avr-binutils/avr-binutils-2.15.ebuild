# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/avr-binutils/avr-binutils-2.15.ebuild,v 1.5 2005/01/01 17:51:22 eradicator Exp $


IUSE="nls"

MY_P=${P/avr-/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="The GNU binutils for the AVR microcontroller architecture"
HOMEPAGE="http://sources.redhat.com/binutils"
SRC_URI="mirror://gnu/binutils/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND="virtual/libc"

src_compile() {
	econf \
		--target=avr \
		`use_enable nls` || die
	emake || die
}

src_install() {
	emake DESTDIR=${D} install || die
	#rm -rf ${D}/usr/avr/bin
	rm -rf ${D}/usr/share/info
	rm -rf ${D}/usr/share/locale
	rm -rf ${D}/usr/lib/libiberty.a
}
