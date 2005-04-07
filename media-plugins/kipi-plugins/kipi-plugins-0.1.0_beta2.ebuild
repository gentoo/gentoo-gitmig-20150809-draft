# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/kipi-plugins/kipi-plugins-0.1.0_beta2.ebuild,v 1.3 2005/04/07 15:46:24 blubb Exp $

inherit kde

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Plugins for libkipi."
HOMEPAGE="http://digikam.sourceforge.net/"
SRC_URI="mirror://sourceforge/digikam/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc amd64"
IUSE="opengl"

DEPEND="media-libs/libkexif
	media-libs/libkipi
	>=media-libs/libgphoto2-2.1.4
	>=media-libs/imlib2-1.1.0
	>=media-gfx/imagemagick-5.5.4
	>=media-video/mjpegtools-1.6.0
	opengl? ( virtual/opengl )"
RDEPEND="${DEPEND}
	media-gfx/dcraw"
need-kde 3.1

src_compile() {
	myconf="$(use_with opengl)"
	kde_src_compile all
}
