# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/digikamimageplugins/digikamimageplugins-0.7.0.ebuild,v 1.1 2004/11/08 18:04:07 carlo Exp $

inherit kde

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="DigikamImagePlugins are a collection of plugins for Digikam Image Editor."
HOMEPAGE="http://digikam.sourceforge.net/"
SRC_URI="mirror://sourceforge/digikam/${MY_P}.tar.bz2"


SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND="!media-plugin/digikamplugins
	=media-gfx/digikam-0.7
	>=media-gfx/imagemagick-5.5.4
	>=media-video/mjpegtools-1.6.0
	virtual/opengl"
RDEPEND="=media-gfx/digikam-0.7
	>=media-gfx/imagemagick-5.5.4
	>=media-video/mjpegtools-1.6.0
	virtual/opengl"
need-kde 3
