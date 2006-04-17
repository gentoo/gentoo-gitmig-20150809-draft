# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/smac/smac-6.0a.ebuild,v 1.9 2006/04/17 13:30:57 wolf31o2 Exp $

inherit eutils games


DESCRIPTION="Linux port of the popular strategy game from Firaxis"
HOMEPAGE="http://www.lokigames.com/products/smac/"
SRC_URI="mirror://lokigames/${PN}/${P}-x86.run"

LICENSE="LOKI-EULA"
SLOT="0"
KEYWORDS="~x86"
IUSE="videos"
RESTRICT="strip"

DEPEND="games-util/loki_patch"
RDEPEND="sys-libs/glibc
	|| (
		(
			x11-libs/libX11
			x11-libs/libXext
			x11-libs/libXau
			x11-libs/libXdmcp )
		virtual/x11 )
	sys-libs/lib-compat-loki
	media-libs/libsdl
	media-libs/sdl-ttf
	media-libs/sdl-mixer
	media-libs/smpeg
	media-libs/freetype
	sys-libs/zlib"

dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

pkg_setup() {
	games_pkg_setup
	cdrom_get_cds Alien_Crossfire_Manual.pdf
}

src_unpack() {
	mkdir -p ${S}/a
	cd ${S}/a
	unpack_makeself ${P}-x86.run
}

src_install() {
	dodir ${dir}
	einfo "Copying files... this may take a while..."
	exeinto ${dir}
	doexe ${CDROM_ROOT}/bin/x86/{smac,smacx,smacpack}

	insinto ${dir}
	doins ${CDROM_ROOT}/{{Alien_Crossfire,Alpha_Centauri}_Manual.pdf,QuickStart.txt,README,icon.{bmp,xpm}}

	cd ${Ddir}
	tar xzf ${CDROM_ROOT}/data.tar.gz || die "unpack"
	insinto ${dir}/data
	doins ${CDROM_ROOT}/data/*.{pcx,cvr,flc,gif} || die "copying data"
	doins -r ${CDROM_ROOT}/data/facs || die "copying fac-data"
	doins -r ${CDROM_ROOT}/data/fx || die "copying fx-data"
	doins -r ${CDROM_ROOT}/data/projs || die "copying projects-data"
	doins -r ${CDROM_ROOT}/data/techs || die "copying tech-data"
	doins -r ${CDROM_ROOT}/data/voices || die "copying voices"

	if use videos ; then
		doins -r ${CDROM_ROOT}/data/movies || die "copying movies"
	fi

	cd ${S}/a
	loki_patch --verify patch.dat
	loki_patch patch.dat ${Ddir} >& /dev/null || die "patching"

	# now, since these files are coming off a cd, the times/sizes/md5sums wont
	# be different ... that means portage will try to unmerge some files (!)
	# we run touch on ${D} so as to make sure portage doesnt do any such thing
	find ${Ddir} -exec touch '{}' \;

	newicon ${CDROM_ROOT}/icon.xpm smac.xpm

	games_make_wrapper ${PN} ./${PN} "${dir}" "${dir}"
	games_make_wrapper ${PN}x ./${PN}x "${dir}" "${dir}"
	make_desktop_entry smac "Sid Meier's Alpha Centauri" smac.xpm
	make_desktop_entry smacx "Sid Meier's Alpha Centauri - Alien Crossfire" \
		smac.xpm
	prepgamesdirs

	einfo "Linking libs provided by 'sys-libs/lib-compat-loki' to '${dir}'."
	dosym /lib/loki_ld-linux.so.2 ${dir}/ld-linux.so.2 && \
	dosym /usr/lib/loki_libc.so.6 ${dir}/libc.so.6 && \
	dosym /usr/lib/loki_libnss_files.so.2 ${dir}/libnss_files.so.2 || die "dosym failed"
}

pkg_postinst() {
	games_pkg_postinst
	einfo "To play Sid Meyer's Alpha Centauri run:"
	einfo " smac"
	einfo "To play Alien Crossfire run:"
	einfo " smacx"
}
