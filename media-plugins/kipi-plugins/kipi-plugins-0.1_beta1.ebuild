# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/kipi-plugins/kipi-plugins-0.1_beta1.ebuild,v 1.1 2004/10/18 20:40:22 carlo Exp $

inherit kde

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Plugins for libkipi."
HOMEPAGE="http://digikam.sourceforge.net/"
SRC_URI="mirror://sourceforge/digikam/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="opengl"

DEPEND="media-libs/libkexif
	media-libs/libkipi
	media-gfx/dcraw
	>=media-libs/libgphoto2-2.1.4
	>=media-gfx/gphoto2-2.1.4
	>=media-libs/imlib2-1.1.0
	>=media-gfx/imagemagick-5.5.4
	>=media-video/mjpegtools-1.6.0
	opengl? ( virtual/opengl )"
RDEPEND="media-libs/libkexif
	media-libs/libkipi
	media-gfx/dcraw
	>=media-libs/libgphoto2-2.1.4
	>=media-gfx/gphoto2-2.1.4
	>=media-libs/imlib2-1.1.0
	>=media-gfx/imagemagick-5.5.4
	>=media-video/mjpegtools-1.6.0
	opengl? ( virtual/opengl )"
need-kde 3.1

src_compile() {
	myconf="$(use_with opengl)"
	kde_src_compile all
}
