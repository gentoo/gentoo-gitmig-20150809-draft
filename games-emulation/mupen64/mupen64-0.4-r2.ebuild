# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mupen64/mupen64-0.4-r2.ebuild,v 1.1 2005/03/25 05:42:54 mr_bones_ Exp $

inherit games gcc eutils libtool

DESCRIPTION="A Nintendo 64 (N64) emulator"
HOMEPAGE="http://mupen64.emulation64.com/"
SRC_URI="http://mupen64.emulation64.com/files/${PV}/mupen64_src-${PV}.tar.bz2
	http://mupen64.emulation64.com/files/${PV}/mupen64_input.tar.bz2
	http://mupen64.emulation64.com/files/${PV}/mupen64_sound.tar.bz2
	http://mupen64.emulation64.com/files/${PV}/hack_azi_rsp_hle.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="avi gtk2 asm"

RDEPEND="sys-libs/zlib
	media-libs/libsdl
	virtual/glu
	virtual/opengl
	avi? ( media-video/avifile )
	!gtk2? ( =x11-libs/gtk+-1.2* )
	gtk2? ( =x11-libs/gtk+-2* )"
DEPEND="${RDEPEND}
	gtk2? ( dev-util/pkgconfig )"
RDEPEND="${RDEPEND}
	>=games-emulation/mupen64-glN64-0.4.1_rc2-r1"


S=${WORKDIR}

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/${PN}-makefiles.patch"
	epatch "${FILESDIR}/${PN}-confdir.patch"
	# gtk2 breaks some configuration dialogs (bug 56195 #35)
	use gtk2 && epatch "${FILESDIR}/${PN}-gtk2-makefile.patch"
	use avi && epatch "${FILESDIR}/${PN}-gentoo-avi.patch"

	if use x86 ; then
		if ! use asm ; then
			epatch "${FILESDIR}/${PN}-noasm.patch"
		fi
	fi
	sed -i \
		-e "s:CFLAGS.*=\(.*\):CFLAGS=\1 ${CFLAGS}:" \
		-e "s:CXXFLAGS.*=\(.*\):CXXFLAGS=\1 ${CXXFLAGS}:" \
		*/Makefile \
		|| die "sed failed"
}

src_compile() {
	local d

	for d in *; do
		emake -C $d || die "emake failed on $d"
	done
}

src_install() {
	local dir=${GAMES_LIBDIR}/${PN}

	exeinto "${dir}/plugins"
	doexe */*.so || die "doexe failed"
	insinto "${dir}/plugins"
	doins */*.ini || die "doins failed"
	rm "${D}/${dir}"/plugins/mupen64*.ini

	cd emu64
	cp -r mupen64* lang plugins save roms path.cfg "${D}/${dir}/" \
		|| die "cp failed"
	rm "${D}/${dir}/mupen64_test.ini"

	dogamesbin "${FILESDIR}/mupen64" || die "dogamesbin failed"
	newgamesbin "${FILESDIR}/mupen64" mupen64_nogui || die "newgamesbin failed"
	sed -i \
		-e "s:GENTOO_DIR:${dir}:" \
		"${D}${GAMES_BINDIR}/mupen64" \
		"${D}${GAMES_BINDIR}/mupen64_nogui" \
		|| die "sed failed"

	# plugins docs are in subdirs of the doc main directory
	dodoc *.txt
	cp doc/readme.pdf "${D}/usr/share/doc/${PF}"

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	ewarn "If you are upgrading from previous version of mupen64"
	ewarn "you have to do rm -rf on your .mupen64 directory."
	ewarn "Copy your saved games and after launching new mupen"
	ewarn "copy it to the original place."
	echo
}
