# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/avr-libc/avr-libc-1.0.2-r1.ebuild,v 1.1 2004/03/07 19:29:04 pappy Exp $

DESCRIPTION="Libc for the AVR microcontroller architecture"

# Homepage, not used by Portage directly but handy for developer reference

HOMEPAGE="http:////www.nongnu.org/avr-libc/"


S="${WORKDIR}/avr-libc-1.0.2"

A="avr-libc-1.0.2.tar.gz"

SRC_URI="http://savannah.nongnu.org/download/avr-libc/${A}"

LICENSE="GPL-2"

CFLAGS=""
SLOT="0"

KEYWORDS="x86"
IUSE=""

INSTALLDIR=/usr
MANDIR=/usr/share/man
INFODIR=/usr/share/info

# Build-time dependencies, such as
#    ssl? ( >=openssl-0.9.6b )
#    >=perl-5.6.1-r1
# It is advisable to use the >= syntax show above, to reflect what you
# had installed on your system when you tested the package.  Then
# other users hopefully won't be caught without the right version of
# a dependency.
DEPEND="dev-embedded/avr-gcc"

# Run-time dependencies, same as DEPEND if RDEPEND isn't defined:
#RDEPEND=""

src_compile() {
	mkdir obj-avr
	cd obj-avr
	pwd
	CC=avr-gcc CFLAGS="" ../configure \
		--target=avr \
		--prefix=${INSTALLDIR} \
		--infodir=${INFODIR} \
		--mandir=${MANDIR} || die "./configure failed"

	emake || die
}

src_install() {
	cd obj-avr
	pwd
	make prefix=${D}${INSTALLDIR} \
		mandir=${D}${MANDIR} \
		infodir=${D}${INFODIR} \
		install || die
}
