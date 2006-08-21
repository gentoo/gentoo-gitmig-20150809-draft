# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mupen64/mupen64-0.5.ebuild,v 1.2 2006/08/21 18:22:20 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="A Nintendo 64 (N64) emulator"
HOMEPAGE="http://mupen64.emulation64.com/"
SRC_URI="http://mupen64.emulation64.com/files/${PV}/mupen64_src-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-amd64 ~x86"
IUSE=""

RDEPEND="sys-libs/zlib
	>=x11-libs/gtk+-2
	media-libs/libsdl"
DEPEND="${RDEPEND}
	 dev-util/pkgconfig"

S=${WORKDIR}/mupen64_src-${PV}

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${PN}-gentoo.patch"

	cd "${S}"

	sed -i "s:#undef WITH_HOME:#define WITH_HOME \"/usr/games/\":" config.h \
		|| die "sed failed"

	sed -i \
		-e '/strip/d' \
		-e "s:CFLAGS.*=\(.*\):CFLAGS=-fPIC ${CFLAGS}:" \
		-e "s:CXXFLAGS.*=\(.*\):CXXFLAGS=-fPIC ${CXXFLAGS}:" \
		Makefile \
		|| die "sed failed"
}

src_compile() {
	emake mupen64 || die "emake failed on $d"
	emake mupen64_nogui || die "emake failed"
	emake plugins/mupen64_input.so || die "emake failed"
	emake plugins/mupen64_hle_rsp_azimer.so || die "emake failed"
	emake plugins/dummyaudio.so || die "emake failed"
	emake plugins/mupen64_audio.so || die "emake failed"
	emake plugins/mupen64_soft_gfx.so || die "emake failed"
}

src_install() {
	local dir=${GAMES_LIBDIR}/${PN}

	exeinto "${GAMES_BINDIR}"
	doexe mupen64 || die "doexe failed"
	doexe mupen64_nogui || die "doexe failed"

	insinto "${dir}"
	doins mupen64.ini || "doins failed"

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
	ewarn "If you are upgrading from a previous version of mupen64,"
	ewarn "backup your saved games then run rm -rf on your"
	ewarn ".mupen64 directory. After launching the new version, copy"
	ewarn "your saved games to their original place."
	echo
}
