# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvd-slideshow/dvd-slideshow-0.8.2.2.ebuild,v 1.4 2011/04/21 19:49:10 radhermit Exp $

EAPI=2

inherit versionator

MY_P=${PN}-$(replace_version_separator 3 '-')

DESCRIPTION="DVD Slideshow - Turn your pictures into a dvd with menus!"
HOMEPAGE="http://dvd-slideshow.sourceforge.net/wiki/Main_Page"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz
		examples? ( mirror://sourceforge/${PN}/${PN}-examples-0.8.0-1.tar.gz )
		themes? ( mirror://sourceforge/${PN}/${PN}-themes-0.8.0-1.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="examples mp3 themes vorbis"

RDEPEND="media-sound/sox
	|| ( media-gfx/imagemagick media-gfx/graphicsmagick[imagemagick] )
	media-video/mjpegtools
	>media-video/dvdauthor-0.6.11
	virtual/cdrtools
	virtual/ffmpeg
	app-cdr/dvd+rw-tools
	mp3? ( media-sound/lame )
	vorbis? ( media-libs/libvorbis )
	sys-devel/bc
	media-gfx/jhead"
DEPEND=""

S=${WORKDIR}/${MY_P}

src_install() {
	dobin dir2slideshow dvd-menu dvd-slideshow gallery1-to-slideshow \
		jigl2slideshow || die "dobin failed."

	dodoc doc/changelog.txt dvd-slideshowrc TODO.txt
	dohtml doc/*.html
	doman man/*.1

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r "${WORKDIR}"/dvd-slideshow-examples-0.8.0-1/*
	fi

	if use themes; then
		rm "${WORKDIR}"/dvd-slideshow-themes-0.8.0-1/themes.readme.txt
		insinto /usr/share/themes/${PF}
		doins -r "${WORKDIR}"/dvd-slideshow-themes-0.8.0-1/*
	fi
}
