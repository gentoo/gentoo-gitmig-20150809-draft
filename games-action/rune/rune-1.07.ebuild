# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/rune/rune-1.07.ebuild,v 1.2 2005/10/27 22:39:43 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="Viking hack and slay game"
HOMEPAGE="http://www.runegame.com"
SRC_URI=""

LICENSE="LOKI-EULA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/x11
	!amd64? ( =media-libs/libsdl-1.2* )
	opengl? ( virtual/opengl )
	amd64? ( app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-compat
		app-emulation/emul-linux-x86-sdl )"

DEPEND=""

S=${WORKDIR}

GAMES_CHECK_LICENSE="yes"
dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

pkg_setup() {
	games_pkg_setup
	cdrom_get_cds System/rune-bin
}

src_unpack() {
	# unpack the data files
	dodir "${dir}"
	tar xzf "${CDROM_ROOT}"/data.tar.gz || die "Could not unpack data.tar.gz"
}

src_install() {
	insinto "${dir}"
	exeinto "${dir}"
	einfo "Copying files... this may take a while..."

	for j in Help Maps Meshes Sounds System Textures Web
	do
		doins -r ${j} || die "copying ${j}"
	done

	# copy linux specific files
	doins -r "${CDROM_ROOT}"/System \
		|| die "Could not copy Linux specific files"

	# the most important things: rune and ucc :)
	doexe "${CDROM_ROOT}"/bin/x86/rune \
		|| die "Could not install rune executable"
	fperms 750 ${dir}/System/{ucc{,-bin},rune-bin} \
		|| die "Could not make executables executable"
	use amd64 && mv ${Ddir}/System/libSDL-1.2.so.0 \
		${Ddir}/System/libSDL-1.2.so.0.backup

	games_make_wrapper rune ./rune "${dir}" "${dir}"

	# installing documentation/icon
	dodoc "${CDROM_ROOT}"/{README,CREDITS} || die "Could not dodoc README.linux"
	newicon "${CDROM_ROOT}"/icon.xpm rune.xpm || die "Could not copy pixmap"
	make_desktop_entry rune "Rune" rune.xpm "Game;ActionGame"

	find ${Ddir} -exec touch '{}' \;

	prepgamesdirs
}
