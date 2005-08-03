# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/avr-libc/avr-libc-1.2.5.ebuild,v 1.1 2005/08/03 23:40:27 vapier Exp $

inherit eutils flag-o-matic

DESCRIPTION="Libc for the AVR microcontroller architecture"
HOMEPAGE="http://www.nongnu.org/avr-libc/"
SRC_URI="http://savannah.nongnu.org/download/avr-libc/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="nls"

DEPEND=">=sys-devel/crossdev-0.9.1"
[[ ${CATEGORY/cross-} != ${CATEGORY} ]] \
	&& RDEPEND="!dev-embedded/avr-libc" \
	|| RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-macros.patch
}

src_compile() {
	export CC=avr-gcc
	strip-flags
	strip-unsupported-flags

	mkdir obj-avr
	cd obj-avr
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
	dodoc AUTHORS ChangeLog* NEWS README
	cd obj-avr
	make DESTDIR="${D}" install || die
}
