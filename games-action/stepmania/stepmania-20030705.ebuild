# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/stepmania/stepmania-20030705.ebuild,v 1.1 2003/09/10 19:29:16 vapier Exp $

inherit games

MY_PV="cvs-5Jul03"
MY_P=${PN}-${MY_PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="An advanced DDR simulator"
HOMEPAGE="http://www.stepmania.com/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/jpeg
	media-libs/libpng
	media-libs/libmad
	media-libs/libogg
	media-libs/libvorbis"

src_install() {
	dogamesbin ${S}/src/stepmania
	cp -r ${S}/Announcers ${S}/BGAnimations ${S}/CDTitles ${S}/Cache \
		${S}/Characters ${S}/Courses ${S}/Data ${S}/Docs ${S}/NoteSkins \
		${S}/RandomMovies ${S}/Songs ${S}/Themes ${S}/Utils \
		${S}/Visualizations ${D}/usr/games/stepmania/
}
