# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvd-slideshow/dvd-slideshow-0.8.0.ebuild,v 1.2 2007/11/19 20:00:28 aballier Exp $

MY_P=${P}-1

DESCRIPTION="DVD Slideshow - Turn your pictures into a dvd with menus!"
HOMEPAGE="http://dvd-slideshow.sourceforge.net/wiki/Main_Page"
SRC_URI="mirror://sourceforge/dvd-slideshow/${MY_P}.tar.gz
		examples? ( mirror://sourceforge/dvd-slideshow/${PN}-examples-${PV}-1.tar.gz )
		themes? ( mirror://sourceforge/dvd-slideshow/${PN}-themes-${PV}-1.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="examples mp3 themes vorbis"

RDEPEND="media-sound/sox
	>media-gfx/imagemagick-5.5.4
	>media-video/dvdauthor-0.6.11
	virtual/cdrtools
	>media-video/ffmpeg-0.4.8
	app-cdr/dvd+rw-tools
	mp3? ( media-sound/lame )
	vorbis? ( media-libs/libvorbis )
	sys-devel/bc"

DEPEND=""

S="${WORKDIR}/${MY_P}"

src_install() {
	dobin dvd-slideshow dvd-menu gallery1-to-slideshow jigl2slideshow dir2slideshow
	dodoc TODO.txt
	dohtml *.html
	doman man/*

	if use examples ; then
		insinto /usr/share/doc/${PF}/examples
		doins -r "${WORKDIR}/dvd-slideshow-examples-${PV}-1/"*
	fi

	if use themes ; then
		rm "${WORKDIR}/dvd-slideshow-themes-${PV}-1/themes.readme.txt"
		insinto /usr/share/themes/${PF}/
		doins -r "${WORKDIR}/dvd-slideshow-themes-${PV}-1/"*
	fi
}
