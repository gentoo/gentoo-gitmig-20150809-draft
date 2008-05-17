# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/kipi-plugins/kipi-plugins-0.1.0_rc1.ebuild,v 1.9 2008/05/17 16:15:25 carlo Exp $

inherit kde

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Plugins for libkipi."
HOMEPAGE="http://www.kipi-plugins.org/"
SRC_URI="mirror://sourceforge/digikam/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc sparc x86"
IUSE="opengl gphoto2"

DEPEND="media-libs/libkexif
	media-libs/libkipi
	gphoto2? ( >=media-libs/libgphoto2-2.1.4 )
	>=media-libs/imlib2-1.1.0
	>=media-gfx/imagemagick-5.5.4
	>=media-video/mjpegtools-1.6.0
	opengl? ( virtual/opengl )
	media-libs/tiff"
RDEPEND="${DEPEND}
	media-gfx/dcraw"
need-kde 3.1

pkg_setup(){
	if ! built_with_use media-libs/imlib2 X ; then
		eerror "X support is required in media-libs/imlib2 in order to be able"
		eerror "to compile media-plugins/kipi-plugins. Please, re-emerge"
		eerror "media-libs/imlib2 with the 'X' USE flag	enabled."
		die
	fi
}

src_compile() {
	myconf="$(use_with opengl) $(use_with gphoto2)"
	kde_src_compile all
}
