# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/darwinia/darwinia-1.3.0.ebuild,v 1.13 2012/01/16 19:41:13 ulm Exp $

CDROM_DISABLE_PROPERTIES=1
inherit eutils cdrom games

DESCRIPTION="the hyped indie game of the year. By the Uplink creators."
HOMEPAGE="http://www.darwinia.co.uk/support/linux.html"
SRC_URI="http://www.introversion.co.uk/darwinia/downloads/${PN}-full-${PV}.sh"

LICENSE="Introversion"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE="cdinstall"
RESTRICT="mirror strip"
PROPERTIES="cdinstall? ( interactive )"

RDEPEND="
	sys-libs/glibc
	sys-devel/gcc
	x86? (
		virtual/opengl
		virtual/glu
		media-libs/libsdl
		media-libs/libvorbis )
	amd64? (
		app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-medialibs
		app-emulation/emul-linux-x86-sdl
		app-emulation/emul-linux-x86-compat )"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/${PN}

src_unpack() {
	use cdinstall && cdrom_get_cds gamefiles/main.dat
	unpack_makeself
}

src_install() {
	insinto "${dir}"/lib
	exeinto "${dir}"/lib

	doins lib/{language,patch}.dat
	doexe lib/darwinia.bin.x86 lib/open-www.sh || die "copying executables"

	exeinto "${dir}"
	doexe bin/Linux/x86/darwinia || die "couldn't do exe"

	if use cdinstall ; then
		doins "${CDROM_ROOT}"/gamefiles/{main,sounds}.dat \
			|| die "couldn't copy data files"
	fi

	dodoc README || die "no reading"
	newicon darwinian.png darwinia.png

	games_make_wrapper darwinia ./darwinia "${dir}" "${dir}"
	make_desktop_entry darwinia "Darwinia"
	prepgamesdirs
}

pkg_postinst() {
	if ! use cdinstall; then
		ewarn "To play the game, you need to copy main.dat and sounds.dat"
		ewarn "from gamefiles/ on the game CD to ${dir}/lib/."
	fi
	games_pkg_postinst
}
