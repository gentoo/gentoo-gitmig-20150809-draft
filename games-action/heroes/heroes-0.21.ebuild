# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/heroes/heroes-0.21.ebuild,v 1.4 2004/02/20 06:13:56 mr_bones_ Exp $

inherit games

data_ver=1.5
snd_trk_ver=1.0
snd_eff_ver=1.0
pkg_list="${P}
	heroes-data-${data_ver}
	heroes-sound-tracks-${snd_trk_ver}
	heroes-sound-effects-${snd_eff_ver}"

DESCRIPTION="Heroes Enjoy Riding Over Empty Slabs: similar to Tron and Nibbles"
HOMEPAGE="http://heroes.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2
	mirror://sourceforge/${PN}/${PN}-data-${data_ver}.tar.bz2
	mirror://sourceforge/${PN}/${PN}-sound-tracks-${snd_trk_ver}.tar.bz2
	mirror://sourceforge/${PN}/${PN}-sound-effects-${snd_eff_ver}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"
IUSE="sdl nls ggi"

DEPEND="virtual/x11
	nls? ( sys-devel/gettext )
	sdl? ( media-libs/libsdl media-libs/sdl-mixer )
	ggi? ( media-libs/libggi media-libs/libgii media-libs/libmikmod )"

S=${WORKDIR}

pkg_setup() {
	[ -z "`use sdl``use ggi`" ] \
		&& die "You must have sdl or ggi in your USE variable" \
		|| return 0
}

src_compile() {
	local myconf="--disable-heroes-debug `use_enable nls`"

	if [ `use sdl` ] ; then
		myconf="${myconf} --with-sdl --with-sdl-mixer"
	else
		myconf="${myconf} --with-ggi --with-mikmod"
	fi

	for pkg in ${pkg_list} ; do
		cd ${S}/${pkg}
		egamesconf ${myconf}
		make || die "unable to compile ${pkg}"
	done
}

src_install() {
	for pkg in ${pkg_list} ; do
		cd ${S}/${pkg}
		make DESTDIR=${D} install || die
	done
	prepgamesdirs
}
