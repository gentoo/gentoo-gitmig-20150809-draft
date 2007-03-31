# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/yammi/yammi-1.2.3.ebuild,v 1.1 2007/03/31 15:49:52 aballier Exp $

ARTS_REQUIRED="yes"
inherit kde

DESCRIPTION="MP3/Ogg/Wav-Manager and Jukebox"
HOMEPAGE="http://yammi.sourceforge.net/"
SRC_URI="mirror://sourceforge/yammi/${P}.tar.gz
	mirror://gentoo/kde-admindir-3.5.5.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="cdr encode kde vorbis"

DEPEND=">=media-libs/taglib-1.3"

RDEPEND="${DEPEND}
	kde? ( || ( kde-base/noatun kde-base/kdemultimedia ) )
	media-sound/sox
	virtual/mpg123
	vorbis? ( media-sound/vorbis-tools )
	encode? ( media-sound/cdparanoia
		media-sound/lame )"

# sox, mpg123 and vorbis-tools are used for the 'prelisten' feature.
# cdparanoia and lame are used by the yammiGrabAndEncode script.
# gstreamer support is left out on purpose, since it is
# based on the obsolete gst kde bindings.

need-kde 3

src_unpack() {
	kde_src_unpack

	sed -i -e '/AM_PATH_XMMS/s:^:dnl :' "${S}/configure.in.in"
}

src_compile() {
	myconf="--disable-xmms"

	kde_src_compile
}

pkg_postinst() {
	elog
	elog "yammi provides various plugins based on"
	elog "external programs, you can emerge any of the"
	elog "following packages to make the correspondent plugin"
	elog "available:"
	elog
	elog "app-cdr/cdlabelgen:	create CD labels"
	elog "app-cdr/k3b:			burn CDs with K3b"
	elog "media-libs/tunepimp or media-sound/trm:"
	elog "						lookup tracks on www.musicbrainz.org"
	echo
}
