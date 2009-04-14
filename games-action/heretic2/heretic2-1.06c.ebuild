# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/heretic2/heretic2-1.06c.ebuild,v 1.5 2009/04/14 07:24:44 mr_bones_ Exp $

inherit eutils multilib games

DESCRIPTION="Third-person classic magical action-adventure game"
HOMEPAGE="http://lokigames.com/products/heretic2/
	http://www.ravensoft.com/heretic2.html"
SRC_URI="mirror://lokigames/${PN}/${P/%?/b}-unified-x86.run
	mirror://lokigames/${PN}/${P}-unified-x86.run
	mirror://lokigames/${PN}/${PN}-maps-1.0.run"

LICENSE="LOKI-EULA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="strip"
PROPERTIES="interactive"
QA_TEXTRELS="${GAMES_PREFIX_OPT:1}/${PN}/base/*.so"

DEPEND="games-util/loki_patch"
RDEPEND="virtual/opengl
	amd64? ( app-emulation/emul-linux-x86-xlibs )"

S=${WORKDIR}

GAMES_CHECK_LICENSE="yes"

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
	local dir=${GAMES_PREFIX_OPT}/${PN}

	cd "${CDROM_ROOT}"

	insinto "${dir}"
	doins -r base help Manual.html README README.more || die "doins failed"

	exeinto "${dir}"
	doexe bin/x86/glibc-2.1/${PN} || die "doexe failed"

	games_make_wrapper ${PN} ./${PN} "${dir}" "${dir}"
	newicon icon.xpm ${PN}.xpm
	make_desktop_entry ${PN} "Heretic II"

	cd "${D}/${dir}"
	ln -s "${CDROM_ROOT}"/*.gz .
	unpack ./*.gz
	rm -f *.gz

	local d
	for d in "${S}"/* ; do
		pushd "${d}" > /dev/null
		loki_patch patch.dat "${D}/${dir}" || die "loki_patch ${d} failed"
		popd > /dev/null
	done

	rmdir gl_drivers
	sed -i \
		"128i set gl_driver \"/usr/$(ABI=x86 get_libdir)/libGL.so\"" \
		base/default.cfg \
		|| die "sed failed"

	prepgamesdirs
}
