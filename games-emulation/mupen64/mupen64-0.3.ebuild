# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mupen64/mupen64-0.3.ebuild,v 1.4 2004/02/20 06:26:47 mr_bones_ Exp $

inherit games gcc eutils

DESCRIPTION="A Nintendo 64 (N64) emulator"
SRC_URI="http://mupen64.emulation64.com/files/src/mupen64_src-${PV}.tar.bz2
	http://mupen64.emulation64.com/files/src/mupen64_input.tar.bz2
	http://mupen64.emulation64.com/files/src/mupen64_sound.tar.bz2
	http://mupen64.emulation64.com/files/src/tr64_oglv078_src.tar.bz2
	http://mupen64.emulation64.com/files/src/mupen64_hle_rsp.tar.bz2
	http://mupen64.emulation64.com/files/src/riceplugin.tar.bz2"
HOMEPAGE="http://mupen64.emulation64.com/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* x86"

RDEPEND="=x11-libs/gtk+-1.2*
	media-libs/libsdl
	virtual/glu
	virtual/opengl"
DEPEND="${RDEPEND}
	sys-devel/gcc
	>=sys-apps/sed-4"

S=${WORKDIR}

src_unpack() {
	unpack ${A}

	# the riceplugin seems to want gcc 3.3 to compile
	if [ "`gcc-major-version`" -lt 3 -o "`gcc-version`" = "3.2" ] ; then
		rm -rf riceplugin
	else
		epatch ${FILESDIR}/${PV}-gcc3.patch
		sed -i \
			-e "/^CFLAGS/s:-O3.*$:${CFLAGS}:" \
			riceplugin/Makefile \
			|| die "sed riceplugin/Makefile failed"
	fi
	# the riceplugin requires sse support
	echo "#include <xmmintrin.h>" > ${T}/test.c
	$(gcc-getCC) ${CFLAGS} -o ${T}/test.s -S ${T}/test.c >&/dev/null || rm -rf riceplugin

	sed -i \
		-e "/^CC/s:-O3.*-Wall:${CFLAGS}:" \
		emu64/Makefile mupen64_input/Makefile \
		|| die "sed mupen64_input/Makefile failed"
	sed -i \
		-e "/^CFLAGS/s:-O3.*-march=athlon:${CFLAGS}:" \
		mupen64_sound/Makefile \
		|| die "sed mupen64_sound/Makefile failed"
	sed -i \
		-e "/^CFLAGS/s:-O3.*$:${CFLAGS}:" \
		rsp_hle/Makefile tr64_oglv078_src/Makefile \
		|| die "other sed Makefiles failed"
}

src_compile() {
	for d in * ; do
		cd ${S}/${d}
		emake || die "emake failed on $d"
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
