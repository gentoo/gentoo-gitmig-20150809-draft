# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Silvio Boehme <Silvio.Boehme@gmx.net>
# $Header: /var/cvsroot/gentoo-x86/media-sound/awesfx/awesfx-0.4.4.ebuild,v 1.1 2002/05/22 11:46:45 seemant Exp $

DESCRIPTION="AWE Utilities - sfxload"
HOMEPAGE="http://mitglied.lycos.de/iwai/awedrv.html"

S=${WORKDIR}/${P}
SRC_URI="http://mitglied.lycos.de/iwai/${P}.tar.bz2"

DEPEND="virtual/glibc"
SLOT="0"


src_unpack() {
	unpack ${A} ; cd ${S}
	# use shared build, not static
	sed -e "s:\$(CDEBUGFLAGS)\( \$(CINCS)\) \$(CDEFS):\1 ${CFLAGS}:" \
		Makefile-shared > Makefile

	cd awelib
	sed -e "s:\$(CDEBUGFLAGS)\( \$(CINCS)\) \$(CDEFS):\1 ${CFLAGS}:" \
		Makefile-shared > Makefile

	mv config.h config.h.orig
	sed -e 's|/usr/local/lib/sfbank:/dos/sb32/sfbank|/usr/share/sfbank|' \
		config.h.orig > config.h
}

src_compile() {
	export CC=gcc
	make \
		INSTDIR=${D}/usr \
		BINDIR=${D}/usr/bin \
		INCDIR=${D}/usr/include/awe \
		LIBDIR=${D}/usr/lib \
		MANDIR=${D}/usr/share/man \
		BANKDIR=${D}/usr/share/sfbank \
		all || die "compile problem"
}

src_install() {

	make \
		INSTDIR=${D}/usr \
		BINDIR=${D}/usr/bin \
		INCDIR=${D}/usr/include/awe \
		LIBDIR=${D}/usr/lib \
		MANDIR=${D}/usr/share/man \
		BANKDIR=${D}/usr/share/sfbank \
		install || die "compile problem"

	dodoc docs/*
}

pkg_postinst() {
	einfo "Please copy your SoundFont files from the original CD-ROM"
	einfo "shipped with your soundcard to"
	einfo "/usr/share/sfbank"
}
