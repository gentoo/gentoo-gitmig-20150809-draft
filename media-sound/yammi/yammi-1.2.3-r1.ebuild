# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/yammi/yammi-1.2.3-r1.ebuild,v 1.1 2009/02/13 22:59:56 carlo Exp $

ARTS_REQUIRED="yes"

EAPI="1"

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
	kde? ( || ( kde-base/noatun:3.5 kde-base/kdemultimedia:3.5 ) )
	media-sound/sox
	virtual/mpg123
	vorbis? ( media-sound/vorbis-tools )
	encode? ( media-sound/cdparanoia
		media-sound/lame )"

# sox, mpg123 and vorbis-tools are used for the 'prelisten' feature.
# cdparanoia and lame are used by the yammiGrabAndEncode script.
# gstreamer support is left out on purpose, since it is
# based on the obsolete gst kde bindings.

need-kde 3.5

PATCHES=(
	"${FILESDIR}/yammi-1.2.3-desktop-file.diff"
	)

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
	elog "Yammi provides various plugins based on external"
	elog "programs, you can emerge any of the following"
	elog "packages to make the correspondent plugin available:"
	elog
	elog "app-cdr/cdlabelgen:        Create CD labels."
	elog "app-cdr/k3b:               Burn CDs with K3b."
	elog "media-libs/tunepimp or"
	elog "media-sound/trm:           Lookup tracks on www.musicbrainz.org"
	echo
}
