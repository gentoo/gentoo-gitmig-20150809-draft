# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mupen64/mupen64-0.4.ebuild,v 1.1 2005/01/01 06:59:18 morfic Exp $

inherit games gcc eutils libtool

IUSE="avi gtk2 sdl"

DESCRIPTION="A Nintendo 64 (N64) emulator"
SRC_URI="http://mupen64.emulation64.com/files/${PV}/mupen64_src-${PV}.tar.bz2
	http://mupen64.emulation64.com/files/${PV}/mupen64_input.tar.bz2
	http://mupen64.emulation64.com/files/${PV}/mupen64_sound.tar.bz2
	http://mupen64.emulation64.com/files/${PV}/hack_azi_rsp_hle.tar.bz2
	http://mupen64.emulation64.com/files/${PV}/riceplugin.tar.bz2
	http://mupen64.emulation64.com/files/${PV}/blight_input-0.0.8-b.tar.gz
	sdl? ( http://mupen64.emulation64.com/files/${PV}/jttl_sound-1.2.tar.bz2 )"
HOMEPAGE="http://mupen64.emulation64.com/"

RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND="sys-libs/zlib
	!gtk2? ( =x11-libs/gtk+-1.2* )
	gtk2? ( =x11-libs/gtk+-2* )
	media-libs/libsdl
	sdl? ( media-libs/sdl-sound )
	avi? ( media-video/avifile )
	virtual/glu
	virtual/opengl"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-makefiles.patch
	epatch ${FILESDIR}/${PN}-confdir.patch
	epatch ${FILESDIR}/${PN}-rice-confdir.patch
	epatch ${FILESDIR}/${PN}-SDL_ttf.patch
	# gtk2 breaks some configuration dialogs (bug 56195 #35)
	use gtk2 && epatch ${FILESDIR}/${PN}-gtk2-makefile.patch
	use avi && epatch ${FILESDIR}/${PN}-gentoo-avi.patch
	use sdl && epatch ${FILESDIR}/${PN}-gentoo-sdl.patch

	# the riceplugin seems to want gcc 3.3 to compile
	if [ "`gcc-major-version`" -lt 3 -o "`gcc-version`" = "3.2" ] ; then
		rm -rf riceplugin
	else
		epatch ${FILESDIR}/${PN}-gcc3.patch
	fi

	# the riceplugin requires sse support
	echo "#include <xmmintrin.h>" > ${T}/test.c
	$(gcc-getCC) ${CFLAGS} -o ${T}/test.s -S ${T}/test.c >&/dev/null || rm -rf riceplugin

	# polish locales
	cp ${FILESDIR}/polish.lng ${S}/emu64/lang
}

src_compile() {
	cd ${S}/blight_input-0.0.8-b
	econf || die "configure of blight_input failed"

	export GCFLAGS="${CFLAGS}"
	export GCXXFLAGS="${CXXFLAGS}"

	cd ${S}
	for i in *; do
		einfo ""
		einfo "Entering $i and make"
		cd ${S}/${i} && emake || die "emake failed on $i"
		einfo "and done."
	done

	unset GCFLAGS
	unset GCXXFLAGS
}

src_install() {
	local dir=${GAMES_LIBDIR}/${PN}
	dodir ${dir}

	cd ${S}

	exeinto ${dir}/plugins
	doexe */*.so blight_input-0.0.8-b/src/.libs/*.so
	insinto ${dir}/plugins
	doins */*.ini
	rm ${D}/${dir}/plugins/mupen64*.ini
	echo -e "\n" > ${D}/usr/games/lib/mupen64/plugins/RiceDaedalus.cfg
	echo -e "\n" > ${D}/usr/games/lib/mupen64/plugins/blight_input.conf

	cd ${S}/emu64
	cp -r mupen64* lang plugins save roms path.cfg ${D}/${dir}/
	rm ${D}/${dir}/mupen64_test.ini
	if use sdl; then
		cd ${S}/jttl_sound-1.2
		cp jttl_audio.conf ${D}/${dir}/plugins
	fi

	dogamesbin ${FILESDIR}/mupen64
	dosed "s:GENTOO_DIR:${dir}:" ${GAMES_BINDIR}/mupen64
	newgamesbin ${FILESDIR}/mupen64 mupen64_nogui
	dosed "s:GENTOO_DIR:${dir}:" ${GAMES_BINDIR}/mupen64_nogui

	# plugins docs are in subdirs of the doc main directory
	cd ${S}/emu64
	insinto /usr/share/doc/${PF}
	dodoc *.txt
	doins doc/readme.pdf
	cd ${S}/blight_input-0.0.8-b
	docinto blight_input
	dodoc AUTHORS ChangeLog NEWS README ToDo
	cd ${S}/jttl_sound-1.2
	docinto jttl_sound-1.2
	dodoc README

	prepgamesdirs
}

pkg_postinst() {
	ewarn "If you are upgreading from previous version of mupen64"
	ewarn "you have to do rm -rf on your .mupen64 directory."
	ewarn "Copy your saved games and after launching new mupen"
	ewarn "copy it to the original place."
}

