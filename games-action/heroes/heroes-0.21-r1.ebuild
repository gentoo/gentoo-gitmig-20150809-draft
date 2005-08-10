# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/heroes/heroes-0.21-r1.ebuild,v 1.2 2005/08/10 19:26:12 r3pek Exp $

inherit games eutils

data_ver=1.5
snd_trk_ver=1.0
snd_eff_ver=1.0

DESCRIPTION="Heroes Enjoy Riding Over Empty Slabs: similar to Tron and Nibbles"
HOMEPAGE="http://heroes.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2
	mirror://sourceforge/${PN}/${PN}-data-${data_ver}.tar.bz2
	mirror://sourceforge/${PN}/${PN}-sound-tracks-${snd_trk_ver}.tar.bz2
	mirror://sourceforge/${PN}/${PN}-sound-effects-${snd_eff_ver}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc ~amd64"
IUSE="sdl nls ggi"

DEPEND="virtual/x11
	nls? ( sys-devel/gettext )
	sdl? ( media-libs/libsdl media-libs/sdl-mixer )
	ggi? ( media-libs/libggi media-libs/libgii media-libs/libmikmod )
	!sdl? ( !ggi? ( media-libs/libsdl media-libs/sdl-mixer ) )"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}/${P}
	epatch ${FILESDIR}/${PV}-cvs-segfault-fix.patch #56118
}

src_compile() {
	local myconf="--disable-heroes-debug $(use_enable nls)"

	if use sdl || ! use ggi ; then
		myconf="${myconf} --with-sdl --with-sdl-mixer"
	else
		myconf="${myconf} --with-ggi --with-mikmod"
	fi

	for pkg in ${A//.tar.bz2} ; do
		cd ${S}/${pkg}
		egamesconf ${myconf}
		make || die "unable to compile ${pkg}"
	done
}

src_install() {
	for pkg in ${A//.tar.bz2} ; do
		cd ${S}/${pkg}
		make DESTDIR=${D} install || die
	done
	prepgamesdirs
}
