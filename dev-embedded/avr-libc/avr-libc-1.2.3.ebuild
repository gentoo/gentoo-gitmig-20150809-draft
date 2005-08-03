# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/avr-libc/avr-libc-1.2.3.ebuild,v 1.6 2005/08/03 23:39:53 vapier Exp $

inherit eutils

DESCRIPTION="Libc for the AVR microcontroller architecture"
HOMEPAGE="http://www.nongnu.org/avr-libc/"
SRC_URI="http://savannah.nongnu.org/download/avr-libc/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc64 x86"
IUSE="nls"

DEPEND=">=sys-devel/crossdev-0.9.1"
[[ ${CATEGORY/cross-} != ${CATEGORY} ]] \
	&& RDEPEND="!dev-embedded/avr-libc" \
	|| RDEPEND=""

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PN}-macros.patch
}

src_compile() {
	mkdir obj-avr
	cd obj-avr
	export CC=avr-gcc
	export CFLAGS=""
	../configure \
		--target=avr \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		$(use_enable nls) \
		|| die "./configure failed"
	emake || die
}

src_install() {
	cd obj-avr
	emake DESTDIR="${D}" install || die
}
