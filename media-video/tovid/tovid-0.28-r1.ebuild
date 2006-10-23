# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/tovid/tovid-0.28-r1.ebuild,v 1.1 2006/10/23 05:59:23 beandog Exp $

inherit eutils

DESCRIPTION="Video conversion and DVD authoring tools"
HOMEPAGE="http://tovid.wikia.com/"
SRC_URI="mirror://sourceforge/tovid/${P}.tar.gz"

IUSE=""
DEPEND=""
RDEPEND="media-video/mplayer
	media-video/mjpegtools
	media-video/ffmpeg
	media-video/transcode
	media-sound/normalize
	media-gfx/imagemagick
	media-sound/sox
	media-video/dvdauthor
	media-video/vcdimager
	media-video/lsdvd
	virtual/cdrtools
	>=dev-python/wxpython-2.6
	app-cdr/dvd+rw-tools
	app-cdr/cdrdao"

KEYWORDS="~x86 ~amd64"
LICENSE="GPL-2"
RESTRICT="nomirror"
SLOT="0"

pkg_setup() {
	if ! built_with_use media-video/mplayer encode; then
		eerror "Please emerge media-video/mplayer with useflag 'encode'."
		die "Fix USE flags and re-emerge"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Patch to fix makexml from the gui app
	epatch "${FILESDIR}/makemenu_png8.patch" || die "epatch died"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake died"
}

pkg_postinst() {
	einfo ""
	einfo "List of suite components:"
	einfo "   idvid:       Identifies video format, resolution, and length"
	einfo "   makemenu:    Creates (S)VCD/DVD menus"
	einfo "   makeslides:  Creates mpeg still slides for (S)VCD"
	einfo "   makexml:     Creates XML specification for an (S)VCD or DVD navigation hierarchy"
	einfo "   makedvd:     Creates the DVD structure and/or iso image"
	einfo "   postproc:    Adjusts A/V sync and does shrinking of encoded video"
	einfo "   tovid:       Converts video to (S)VCD or DVD mpeg format"
	einfo "   tovidgui:    The tovid GUI"
	einfo "   pytovid:     The new (experimental) python based tovid script"
	einfo "   todisc:      Create a DVD with animated menus"
	einfo "   todiscgui:   Experimental gui for todisc"
	einfo ""
	einfo "Please check out the tovid documentation on the web:"
	einfo "   http://tovid.wikia.com/"
	einfo ""
}
