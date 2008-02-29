# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/heretic2/heretic2-1.06c.ebuild,v 1.3 2008/02/29 18:04:06 carlo Exp $

inherit eutils games

DESCRIPTION="Third-person classic magical action-adventure game"
HOMEPAGE="http://lokigames.com/products/heretic2/
	http://www.ravensoft.com/heretic2.html"
SRC_URI="mirror://lokigames/${PN}/${P/%?/b}-unified-x86.run
	mirror://lokigames/${PN}/${P}-unified-x86.run
	mirror://lokigames/${PN}/${PN}-maps-1.0.run"

LICENSE="LOKI-EULA"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RESTRICT="strip"
QA_TEXTRELS="${GAMES_PREFIX_OPT:1}/${PN}/base/*.so"

DEPEND="games-util/loki_patch"
RDEPEND="virtual/opengl"

S=${WORKDIR}

GAMES_CHECK_LICENSE="yes"
dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

src_unpack() {
	cdrom_get_cds bin/x86/glibc-2.1/${PN}
	mkdir ${A}

	local f
	for f in * ; do
		cd "${S}"/${f}
		unpack_makeself ${f}
	done
}

src_install() {
	cd "${CDROM_ROOT}"

	insinto "${dir}"
	doins -r base help Manual.html README README.more || die "doins failed"

	exeinto "${dir}"
	doexe bin/x86/glibc-2.1/${PN} || die "doexe failed"

	games_make_wrapper ${PN} ./${PN} "${dir}" "${dir}"
	newicon icon.xpm ${PN}.xpm
	make_desktop_entry ${PN} "Heretic II" ${PN}

	cd "${Ddir}"
	ln -s "${CDROM_ROOT}"/*.gz .
	unpack ./*.gz
	rm -f *.gz

	local d
	for d in "${S}"/* ; do
		cd "${d}"
		loki_patch patch.dat "${Ddir}" || die "loki_patch ${d} failed"
	done

	rmdir "${Ddir}"/gl_drivers
	sed -i '128i set gl_driver "/usr/lib/libGL.so"' \
		"${Ddir}"/base/default.cfg || die "sed failed"

	prepgamesdirs
}
