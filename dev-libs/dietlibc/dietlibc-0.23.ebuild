# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dietlibc/dietlibc-0.23.ebuild,v 1.6 2003/12/20 01:14:28 gmsoft Exp $

inherit eutils flag-o-matic
filter-flags "-fstack-protector"

DESCRIPTION="A minimal libc"
SRC_URI="mirror://kernel/linux/libs/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.fefe.de/dietlibc/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ~hppa ~amd64 ~alpha"

src_unpack() {
	unpack ${A} ; cd ${S}

	epatch ${FILESDIR}/${PV}-dirent-prototype.patch
	[ "${ARCH}" = "hppa" ] && epatch "${FILESDIR}/${P}-hppa.patch"
	mv Makefile Makefile.orig
	sed -e "s:^CFLAGS.*:CFLAGS = ${CFLAGS}:" \
		-e "s:^prefix.*:prefix=/usr/diet:" \
		-e "s:^#DESTDIR=/tmp/fef.*:DESTDIR=${D}:" \
		Makefile.orig > Makefile
	# does not say anything about this in the install docs - uncommenting (Thilo)
	#mkdir ${S}/include/asm
	#cp /usr/include/asm/posix_types.h ${S}/include/asm
}

src_compile() {
# Added by Jason Wever <weeve@gentoo.org>
# Fix for bug #27171.
# dietlibc assumes that if uname -m is sparc64, then gcc is 64 bit
# but this is not the case on Gentoo currently.

	if [ "${ARCH}" = "sparc" -a "${PROFILE_ARCH}" = "sparc64" ]; then
		cd ${S}
		/usr/bin/sparc32 make
	else
		emake || die
	fi
}

src_install() {
	if [ "${ARCH}" = "sparc" -a "${PROFILE_ARCH}" = "sparc64" ]; then
		cd ${S}
		/usr/bin/sparc32 make install
	else
		make install || die
	fi

	exeinto /usr/bin
#	newexe bin-i386/diet-i diet
	newexe bin-$(uname -m | sed -e 's/i[4-9]86/i386/' -e 's/armv[3-6][lb]/arm/')/diet-i diet

	doman diet.1
	dodoc AUTHOR BUGS CAVEAT CHANGES README THANKS TODO PORTING
}
