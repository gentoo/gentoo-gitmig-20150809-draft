# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/openxcom/openxcom-9999.ebuild,v 1.8 2011/11/09 10:19:29 scarabeus Exp $

EAPI=3

EGIT_REPO_URI="https://github.com/SupSuper/OpenXcom.git"
[[ ${PV} = 9999 ]] && SCM_ECLASS="git-2 autotools"
inherit games ${SCM_ECLASS}
unset SCM_ECLASS

DESCRIPTION="Open-source reimplementation of the original X-Com"
HOMEPAGE="http://openxcom.org/"
[[ ${PV} = 9999 ]] || SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
[[ ${PV} = 9999 ]] || KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug doc"

RDEPEND="
	dev-cpp/yaml-cpp
	media-libs/libsdl
	media-libs/sdl-gfx
	media-libs/sdl-mixer
"
DEPEND="${DEPEND}
	doc? ( app-doc/doxygen )
"

src_prepare() {
	[[ ${PV} = 9999 ]] && eautoreconf
}

src_configure() {
	egamesconf \
		--docdir="${EPREFIX}/usr/share/doc/${PF}/" \
		--disable-werror \
		$(use_enable debug) \
		$(use_with doc docs)
}

src_install() {
	emake DESTDIR="${ED}" install || die

	if [[ -e "${S}"/ChangeLog ]]; then
		dodoc "${S}"/ChangeLog || die "dodoc failed"
	fi

	elog "Remember to put X-Com data to proper location:"
	elog "	${EROOT}${GAMES_DATADIR}/${PN}/"
	prepgamesdirs
}
