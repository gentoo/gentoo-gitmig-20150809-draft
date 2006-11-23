# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/virtualjaguar/virtualjaguar-1.0.7.ebuild,v 1.3 2006/11/23 22:33:57 nyhm Exp $

inherit eutils toolchain-funcs games

DESCRIPTION="an Atari Jaguar emulator"
HOMEPAGE="http://www.icculus.org/virtualjaguar/"
SRC_URI="http://www.icculus.org/virtualjaguar/tarballs/${P}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND="virtual/opengl
	media-libs/libsdl"

S=${WORKDIR}/${P}-src

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/^CC/d' \
		-e "/^LD\b/s:=.*:=$(tc-getCXX):" \
		-e 's:-O2:$(ECFLAGS):' Makefile \
		|| die "sed Makefile failed"
	mkdir obj || die "mkdir failed" # silly makefile

	epatch "${FILESDIR}/${PV}-cdintf_linux.patch"

	cp "${FILESDIR}/virtualjaguar" "${T}" || die "cp failed"

	sed -i \
		-e "s:GENTOODIR:${GAMES_BINDIR}:" \
		"${T}/virtualjaguar" \
		|| die "sed failed"
}

src_compile() {
	export ECFLAGS="${CFLAGS}" \
		SYSTYPE=__GCCUNIX__ \
		GLLIB=-lGL \
		SDLLIBTYPE=--libs
	emake obj/m68kops.h || die # silly makefile
	emake || die "emake failed"
}

src_install() {
	dogamesbin vj "${T}/virtualjaguar" || die "dogamebin failed"
	dodoc docs/{README,TODO,WHATSNEW}
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "Please run ${PN} to create the necessary directories"
	einfo "in your home directory.  After that you may place ROM files"
	einfo "in ~/.vj/ROMs and they will be detected when you run virtualjaguar."
	einfo "You may then select which ROM to run from inside the emulator."
	echo
	einfo "If you have previously run a version of ${PV} please note that"
	einfo "the location of the ROMs has changed."
}
