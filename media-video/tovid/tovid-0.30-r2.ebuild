# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/tovid/tovid-0.30-r2.ebuild,v 1.3 2007/08/16 06:59:06 opfer Exp $

inherit eutils

DESCRIPTION="Video conversion and DVD authoring tools"
HOMEPAGE="http://tovid.wikia.com/"
SRC_URI="mirror://sourceforge/tovid/${P}.tar.gz"
IUSE="tk"
DEPEND="media-video/mplayer
	app-text/txt2tags"
RDEPEND="media-video/mjpegtools
	media-video/ffmpeg
	media-video/transcode
	media-sound/normalize
	media-gfx/imagemagick
	media-sound/sox
	media-video/dvdauthor
	media-video/vcdimager
	media-video/lsdvd
	virtual/cdrtools
	dev-python/pycairo
	>=dev-python/wxpython-2.6
	app-cdr/dvd+rw-tools
	app-cdr/cdrdao
	dev-python/imaging"
KEYWORDS="amd64 x86"
LICENSE="GPL-2"
SLOT="0"

pkg_setup() {
	if use tk && ( ! built_with_use dev-lang/python tk ); then
		eerror "Please emerge python with useflag 'tk' enabled."
		die "Fix USE flags and re-emerge"
	elif ! use tk; then
		ewarn "If you want to use 'todiscgui', then emerge"
		ewarn "dev-lang/python and this package with the 'tk' use flag"
	fi
	if ! built_with_use media-video/mplayer encode; then
		eerror "Please emerge media-video/mplayer with useflag 'encode'."
		die "Fix USE flags and re-emerge"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-configure.patch"
	epatch "${FILESDIR}/${P}-ffmpeg.patch"
	epatch "${FILESDIR}/${P}-tovid-init.patch"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install died"
	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	elog ""
	elog "List of suite components:"
	elog "   idvid:       Identifies video format, resolution, and length"
	elog "   makemenu:    Creates (S)VCD/DVD menus"
	elog "   makeslides:  Creates mpeg still slides for (S)VCD"
	elog "   makexml:     Creates XML specification for an (S)VCD or DVD navigation hierarchy"
	elog "   makedvd:     Creates the DVD structure and/or iso image"
	elog "   postproc:    Adjusts A/V sync and does shrinking of encoded video"
	elog "   tovid:       Converts video to (S)VCD or DVD mpeg format"
	elog "   tovidgui:    The tovid GUI"
	elog "   pytovid:     The new (experimental) python based tovid script"
	elog "   todisc:      Create a DVD with animated menus"
	elog "   todiscgui:   Experimental gui for todisc"
	elog ""
	elog "Please check out the tovid documentation on the web:"
	elog "   http://tovid.wikia.com/"
	elog ""
}
