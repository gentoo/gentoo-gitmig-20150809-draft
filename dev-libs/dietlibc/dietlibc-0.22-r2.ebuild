# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dietlibc/dietlibc-0.22-r2.ebuild,v 1.9 2004/02/20 02:51:45 mr_bones_ Exp $

inherit eutils flag-o-matic

DESCRIPTION="A minimal libc"
SRC_URI="mirror://kernel/linux/libs/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.fefe.de/dietlibc/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc hppa amd64 alpha"

src_unpack() {
	filter-flags "-fstack-protector"

	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}_xdr_security_fix.patch
	epatch ${FILESDIR}/${PV}-dirent-prototype.patch

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
