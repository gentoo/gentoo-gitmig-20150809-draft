# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/toycars/toycars-0.3.10.ebuild,v 1.4 2009/11/25 14:27:06 maekke Exp $

EAPI=2
inherit eutils flag-o-matic games

DESCRIPTION="a physics based 2-D racer inspired by Micro Machines"
HOMEPAGE="http://sourceforge.net/projects/toycars"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="media-libs/libsdl[video]
	media-libs/sdl-image[png]
	>=x11-libs/fltk-1.1.9:1.1
	>=media-libs/fmod-4.25.07-r1:1
	virtual/glu
	virtual/opengl"

src_prepare() {
	epatch "${FILESDIR}"/${P}-glibc-2.10.patch
}

src_configure() {
	append-ldflags -L/opt/fmodex/api/lib
	egamesconf
}

src_install() {
	local d,f

	emake DESTDIR="${D}" install || die "emake install failed"
	newicon toycars/celica-render.png ${PN}.png
	make_desktop_entry ${PN} "Toy Cars"
	dodoc AUTHORS

	for d in toycars toycars_track_editor toycars_vehicle_editor
	do
		for f in ChangeLog README TODO
		do
			if [[ -s $d/$f ]] ; then
				newdoc $d/$f $d.$f
			fi
		done
	done
	prepgamesdirs
}
