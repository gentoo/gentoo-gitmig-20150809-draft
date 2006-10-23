# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/x2/x2-1.4.01.ebuild,v 1.1 2006/10/23 18:16:38 wolf31o2 Exp $

inherit eutils versionator games

PV_MAJOR=$(get_version_component_range 1-2)
MY_P=${PN}-${PV_MAJOR}-${PV}

DESCRIPTION="Open-ended space opera with trading, building & fighting"
HOMEPAGE="http://www.linuxgamepublishing.com/info.php?id=x2"
SRC_URI="http://updatefiles.linuxgamepublishing.com/${PN}/${MY_P}-x86.run"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bonusscripts dynamic german langpacks modkit"
RESTRICT="strip"

RDEPEND="media-libs/alsa-lib
	sys-libs/glibc
	x86? (
		media-libs/libsdl
		media-libs/openal
		sys-libs/zlib
		x11-libs/gtk+
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libXdmcp
		x11-libs/libXext
		x11-libs/libXi )
	amd64? (
		app-emulation/emul-linux-x86-gtklibs
		app-emulation/emul-linux-x86-medialibs
		app-emulation/emul-linux-x86-sdl
		app-emulation/emul-linux-x86-xlibs )"
DEPEND=""

S=${WORKDIR}

src_unpack() {
	cdrom_get_cds bin/Linux/x86/${PN}
	ln -sfn "${CDROM_ROOT}"/data cd
	local u
	for u in data bonusscripts german langpacks modkit ; do
		if ( [[ "${u}" = "data" ]] || use "${u}" ) ; then
			unpack "./cd/${u}.tar.gz"
		fi
	done
	rm -f cd

	cp -rf "${CDROM_ROOT}"/bin/Linux/x86/* . || die "cp exes failed"
	cp -f "${CDROM_ROOT}"/{READ*,icon*} . || die "cp READ* failed"

	mkdir patch
	cd patch
	unpack_makeself ${MY_P}-x86.run
	bin/Linux/x86/loki_patch patch.dat "${S}" || die "loki_patch failed"
	cp -f README.txt "${S}"/patch.txt || die "cp README.txt failed"
	cd "${S}"
	rm -rf patch

	# These files do not get installed
	[[ -e modkit ]] && rm -f modkit/x2*.debug
}

src_install() {
	dir=${GAMES_PREFIX_OPT}/${PN}

	# Whether to use static (default) or dynamic binaries
	local dyn
	use dynamic && dyn=".dynamic"

	insinto "${dir}"
	doins -r * || die "doins -r failed"
	keepdir "${dir}"/Database

	exeinto "${dir}"
	doexe x2{,.dynamic} || die "doexe x2 failed"

	if use modkit ; then
		exeinto "${dir}"/modkit
		doexe modkit/x2{build,tool}{,.dynamic} || die "doexe modkit failed"
		local f
		for f in build tool ; do
			games_make_wrapper "x2${f}" "${dir}/modkit/x2${f}${dyn}"
		done
	fi

	games_make_wrapper ${PN} "./${PN}${dyn}" "${dir}"
	newicon "${CDROM_ROOT}"/icon.xpm ${PN}.xpm || die "newicon failed"
	make_desktop_entry ${PN} "X2 - The Threat" ${PN}.xpm

	prepgamesdirs
}
