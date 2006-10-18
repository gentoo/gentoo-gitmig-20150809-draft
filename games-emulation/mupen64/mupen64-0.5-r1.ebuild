# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mupen64/mupen64-0.5-r1.ebuild,v 1.2 2006/10/18 22:26:31 nyhm Exp $

inherit eutils flag-o-matic multilib games

DESCRIPTION="A Nintendo 64 (N64) emulator"
HOMEPAGE="http://mupen64.emulation64.com/"
SRC_URI="http://mupen64.emulation64.com/files/${PV}/mupen64_src-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="opengl"

RDEPEND="sys-libs/zlib
	opengl? ( virtual/opengl )
	>=x11-libs/gtk+-2
	amd64? ( app-emulation/emul-linux-x86-gtklibs
		 app-emulation/emul-linux-x86-sdl )
	media-libs/libsdl
	media-libs/sdl-sound"

# Block the now included external plugins.
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	!games-emulation/mupen64-blight-input
	!games-emulation/mupen64-glN64
	!games-emulation/mupen64-jttl_sound"


S=${WORKDIR}/mupen64_src-${PV}

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${PN}-gentoo.patch"

	cd "${S}"

	sed -i "s:#undef WITH_HOME:#define WITH_HOME \"/usr/games/\":" config.h \
		|| die "sed failed"

	sed -i \
		-e '/strip/d' \
		-e "s:CFLAGS[[:space:]]*=\(.*\):CFLAGS=-fPIC ${CFLAGS}:" \
		-e "s:CXXFLAGS[[:space:]]*=\(.*\):CXXFLAGS=-fPIC ${CXXFLAGS}:" \
		Makefile \
		|| die "sed failed"
}

src_compile() {
	use amd64 && multilib_toolchain_setup x86

	emake mupen64 || die "emake failed on $d"
	emake mupen64_nogui || die "emake failed"
	emake plugins/mupen64_input.so || die "emake failed"
	emake plugins/mupen64_hle_rsp_azimer.so || die "emake failed"
	emake plugins/dummyaudio.so || die "emake failed"
	emake plugins/mupen64_audio.so || die "emake failed"
	emake plugins/mupen64_soft_gfx.so || die "emake failed"

	emake plugins/blight_input.so || die "emake failed"
	emake plugins/jttl_audio.so || die "emake failed"

	if use opengl; then
		emake plugins/glN64.so || die "emake failed"
	fi
}

src_install() {
	local dir=${GAMES_LIBDIR}/${PN}

	exeinto "${GAMES_BINDIR}"
	doexe mupen64 || die "doexe failed"
	doexe mupen64_nogui || die "doexe failed"

	insinto "${dir}"
	doins mupen64.ini jttl_audio.conf || "doins failed"

	dodir ${dir}/save

	cp -r lang roms plugins "${D}/${dir}/" \
		|| die "cp failed"

	rm "${D}/${dir}/plugins/empty"
	dodoc *.txt
	cp doc/readme.pdf "${D}/usr/share/doc/${PF}"

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	ewarn "If you are upgrading from previous version of mupen64"
	ewarn "backup your saved games then do a rm -rf on your"
	ewarn ".mupen64 directory. After launching then new mupen copy"
	ewarn "your saved games to the original place."
	echo
}
