# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mupen64/mupen64-0.4-r1.ebuild,v 1.3 2005/02/12 00:58:40 mr_bones_ Exp $

inherit games gcc eutils libtool

IUSE="avi gtk2 asm"

DESCRIPTION="A Nintendo 64 (N64) emulator"
SRC_URI="http://mupen64.emulation64.com/files/${PV}/mupen64_src-${PV}.tar.bz2
	http://mupen64.emulation64.com/files/${PV}/mupen64_input.tar.bz2
	http://mupen64.emulation64.com/files/${PV}/mupen64_sound.tar.bz2
	http://mupen64.emulation64.com/files/${PV}/hack_azi_rsp_hle.tar.bz2"

HOMEPAGE="http://mupen64.emulation64.com/"

RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="sys-libs/zlib
	media-libs/libsdl
	virtual/glu
	virtual/opengl
	avi? ( media-video/avifile )
	!gtk2? ( =x11-libs/gtk+-1.2* )
	gtk2? ( =x11-libs/gtk+-2* )"

RDEPEND="${RDEPEND}
	>=games-emulation/mupen64-glN64-0.4.1_rc2-r1
	>=sys-apps/sed-4"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-makefiles.patch
	epatch ${FILESDIR}/${PN}-confdir.patch
	# gtk2 breaks some configuration dialogs (bug 56195 #35)
	use gtk2 && epatch ${FILESDIR}/${PN}-gtk2-makefile.patch
	use avi && epatch ${FILESDIR}/${PN}-gentoo-avi.patch

	if use x86; then
		if use asm; then
			einfo "using x86 asm where aviable"
		else
			epatch ${FILESDIR}/${PN}-noasm.patch
		fi
	fi
	# polish locales
	cp ${FILESDIR}/polish.lng ${S}/emu64/lang
}

src_compile() {

	for i in *; do
		einfo ""
		einfo "Entering $i and make"
		cd ${S}/${i}
		sed -i -e "s:CFLAGS.*=\(.*\):CFLAGS=\1 ${CFLAGS}:" \
				-e "s:CXXFLAGS.*=\(.*\):CXXFLAGS=\1 ${CXXFLAGS}:" \
				Makefile ||  die "couldn't apply cflags"
		emake || die "emake failed on $i"
		einfo "and done."
	done

}

src_install() {
	local dir=${GAMES_LIBDIR}/${PN}
	dodir ${dir}

	cd ${S}

	exeinto ${dir}/plugins
	doexe */*.so
	insinto ${dir}/plugins
	doins */*.ini
	rm ${D}/${dir}/plugins/mupen64*.ini

	cd ${S}/emu64
	cp -r mupen64* lang plugins save roms path.cfg ${D}/${dir}/
	rm ${D}/${dir}/mupen64_test.ini

	dogamesbin ${FILESDIR}/mupen64 || die "dogamesbin failed"
	dosed "s:GENTOO_DIR:${dir}:" ${GAMES_BINDIR}/mupen64
	newgamesbin ${FILESDIR}/mupen64 mupen64_nogui || die "newgamesbin failed"
	dosed "s:GENTOO_DIR:${dir}:" ${GAMES_BINDIR}/mupen64_nogui

	# plugins docs are in subdirs of the doc main directory
	cd "${S}/emu64"
	dodoc *.txt doc/readme.pdf

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	ewarn "If you are upgreading from previous version of mupen64"
	ewarn "you have to do rm -rf on your .mupen64 directory."
	ewarn "Copy your saved games and after launching new mupen"
	ewarn "copy it to the original place."
}

