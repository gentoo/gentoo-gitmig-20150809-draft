# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/awesfx/awesfx-0.4.4.ebuild,v 1.11 2004/10/14 21:29:18 eradicator Exp $

IUSE=""

inherit toolchain-funcs

DESCRIPTION="AWE Utilities - sfxload"
HOMEPAGE="http://mitglied.lycos.de/iwai/awedrv.html"
SRC_URI="http://mitglied.lycos.de/iwai/${P}.tar.bz2"

DEPEND="virtual/libc"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"


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
	export CC="$(tc-getCC)"
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
