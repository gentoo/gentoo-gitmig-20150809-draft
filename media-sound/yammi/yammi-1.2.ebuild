# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/yammi/yammi-1.2.ebuild,v 1.1 2005/03/15 21:12:48 greg_g Exp $

inherit kde

DESCRIPTION="MP3/Ogg/Wav-Manager and Jukebox"
HOMEPAGE="http://yammi.sourceforge.net/"
SRC_URI="mirror://sourceforge/yammi/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc ~ppc"
IUSE="cdr encode kde oggvorbis xmms"

DEPEND=">=media-libs/taglib-1.3
	xmms? ( media-sound/xmms )"

RDEPEND="${DEPEND}
	kde? ( || ( kde-base/noatun kde-base/kdemultimedia ) )
	media-sound/sox
	virtual/mpg123
	oggvorbis? ( media-sound/vorbis-tools )
	encode? ( media-sound/cdparanoia
		  media-sound/lame )"

# sox, mpg123 and vorbis-tools are used for the 'prelisten' feature.
# cdparanoia and lame are used by the yammiGrabAndEncode script.
# gstreamer support is left out on purpose, since it is
# based on the obsolete gst kde bindings.

need-kde 3

pkg_setup() {
	if ! use arts && ! use xmms; then
		eerror "Yammi needs either aRts or Xmms to work,"
		eerror "please try again with USE=\"arts\" or USE=\"xmms\"".
		die
	fi

	# check whether kdelibs was compiled with arts support
	kde_pkg_setup
}

src_unpack() {
	# override kde_src_unpack, to prevent automake from running
	unpack ${A}
}

src_compile() {
	myconf="$(use_enable xmms)"

	kde_src_compile
}

pkg_postinst() {
	echo
	einfo "yammi provides various plugins based on"
	einfo "external programs, you can emerge any of the"
	einfo "following packages to make the correspondent plugin"
	einfo "available:"
	einfo
	einfo "app-cdr/cdlabelgen:  create CD labels"
	einfo "app-cdr/k3b:         burn CDs with K3b"
	einfo "media-libs/tunepimp or media-sound/trm:"
	einfo "                     lookup tracks on www.musicbrainz.org"
	echo
}
