# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mupen64/mupen64-0.3.ebuild,v 1.1 2003/09/19 05:58:18 vapier Exp $

inherit games eutils

DESCRIPTION="A Nintendo 64 (N64) emulator"
SRC_URI="http://mupen64.emulation64.com/files/src/mupen64_src-${PV}.tar.bz2
	http://mupen64.emulation64.com/files/src/mupen64_input.tar.bz2
	http://mupen64.emulation64.com/files/src/mupen64_sound.tar.bz2
	http://mupen64.emulation64.com/files/src/tr64_oglv078_src.tar.bz2
	http://mupen64.emulation64.com/files/src/mupen64_hle_rsp.tar.bz2
	http://mupen64.emulation64.com/files/src/riceplugin.tar.bz2"
#SRC_URI="http://mupen64.emulation64.com/files/${P}.tar.bz2"
HOMEPAGE="http://mupen64.emulation64.com/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* x86"

DEPEND="=x11-libs/gtk+-1.2*
	>=sys-apps/sed-4
	media-libs/libsdl
	virtual/glu
	virtual/opengl"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-gcc3.patch
	sed -i "/^CC/s:-O3.*-Wall:${CFLAGS}:" \
		emu64/Makefile \
		mupen64_input/Makefile
	sed -i "/^CFLAGS/s:-O3.*-march=athlon:${CFLAGS}:" mupen64_sound/Makefile
	sed -i "/^CFLAGS/s:-O3.*$:${CFLAGS}:" \
		riceplugin/Makefile \
		rsp_hle/Makefile \
		tr64_oglv078_src/Makefile
}

src_compile() {
	for d in * ; do
		cd ${S}/${d}
		emake || die "failed on $d"
	done
}

src_install() {
	local dir=${GAMES_LIBDIR}/${PN}
	dodir ${dir}

	exeinto ${dir}/plugins
	doexe */*.so
	insinto ${dir}/plugins
	doins */*.ini
	rm ${D}/${dir}/plugins/mupen64*.ini

	cd emu64
	cp -r mupen64* lang plugins save roms path.cfg ${D}/${dir}/
	rm ${D}/${dir}/mupen64_test.ini
	dogamesbin ${FILESDIR}/mupen64
	dosed "s:GENTOO_DIR:${dir}:" ${GAMES_BINDIR}/mupen64
	newgamesbin ${FILESDIR}/mupen64 mupen64_nogui
	dosed "s:GENTOO_DIR:${dir}:" ${GAMES_BINDIR}/mupen64_nogui
	dodoc *.txt doc/readme.pdf

	prepgamesdirs
}
