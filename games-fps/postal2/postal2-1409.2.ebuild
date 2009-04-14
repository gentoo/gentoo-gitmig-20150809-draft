# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/postal2/postal2-1409.2.ebuild,v 1.7 2009/04/14 07:27:22 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="Postal 2: Share the Pain"
HOMEPAGE="http://www.gopostal.com/"
SRC_URI="http://updatefiles.linuxgamepublishing.com/${PN}/${P/%?/1}.run
	http://updatefiles.linuxgamepublishing.com/${PN}/${P}.run"

LICENSE="postal2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""
RESTRICT="strip"
PROPERTIES="interactive"

DEPEND="games-util/loki_patch"
RDEPEND="sys-libs/glibc
	virtual/opengl
	amd64? ( app-emulation/emul-linux-x86-xlibs )"

S=${WORKDIR}

GAMES_CHECK_LICENSE="yes"

src_unpack() {
	cdrom_get_cds .installation_data/linux-specific.tar.bz2
	mkdir ${A}

	local f
	for f in * ; do
		cd "${S}"/${f}
		unpack_makeself ${f}
	done
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}

	dodir "${dir}"
	cd "${D}/${dir}"

	ln -s "${CDROM_ROOT}"/.installation_data/*.bz2 .
	unpack ./*.bz2
	rm ./*.bz2

	local d
	for d in "${S}"/* ; do
		cd "${d}"
		loki_patch patch.dat "${D}/${dir}" || die "loki_patch ${d} failed"
	done

	games_make_wrapper ${PN} ./${PN}-bin "${dir}"/System .
	doicon "${CDROM_ROOT}"/.installation_data/${PN}.xpm
	make_desktop_entry ${PN} "Postal 2: Share the Pain"

	prepgamesdirs
}
