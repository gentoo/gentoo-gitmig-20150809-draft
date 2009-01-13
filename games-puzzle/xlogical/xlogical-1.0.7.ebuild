# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/xlogical/xlogical-1.0.7.ebuild,v 1.7 2009/01/13 02:02:32 mr_bones_ Exp $

EAPI=2
inherit autotools versionator eutils games

MY_PV=$(replace_version_separator 2 '-' )
MY_P=${PN}-${MY_PV}
DESCRIPTION="SDL logical clone"
HOMEPAGE="http://changeling.ixionstudios.com/xlogical/"
SRC_URI="http://changeling.ixionstudios.com/xlogical/downloads/${MY_P}.tar.bz2
	alt_gfx? ( http://changeling.ixionstudios.com/xlogical/downloads/xlogical_gfx.zip )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="alt_gfx"

RDEPEND="media-libs/libsdl
	media-libs/sdl-image[jpeg]
	media-libs/sdl-mixer[mikmod]"
DEPEND="${RDEPEND}
	alt_gfx? ( app-arch/unzip )"

S=${WORKDIR}/${PN}-$(get_version_component_range 1-2)

src_unpack() {
	unpack ${MY_P}.tar.bz2
	if use alt_gfx ; then
		cd "${S}/images"
		unpack xlogical_gfx.zip
	fi
}

src_prepare() {
	sed -i '/^CXXFLAGS/d' Makefile.am || die "sed failed"
	edos2unix properties.h anim.h exception.h
	epatch \
		"${FILESDIR}"/${P}-gcc41.patch \
		"${FILESDIR}"/${P}-gcc43.patch
	eautoreconf
}

src_install() {
	dogamesbin ${PN} || die "installing the binary failed"

	insinto "${GAMES_DATADIR}"/${PN}
	doins -r ${PN}.{properties,levels} music sound images \
		 || die "installing game data failed"
	find "${D}" -name "Makefile*" -exec rm -f '{}' +

	insinto "${GAMES_STATEDIR}"/${PN}
	doins ${PN}.scores || die "installing hi-score failed"
	fperms 0660 "${GAMES_STATEDIR}"/${PN}/${PN}.scores

	dodoc AUTHORS ChangeLog NEWS README TODO
	make_desktop_entry ${PN} "Xlogical"
	prepgamesdirs
}
