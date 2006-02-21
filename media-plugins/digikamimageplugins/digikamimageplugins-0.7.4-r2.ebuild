# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/digikamimageplugins/digikamimageplugins-0.7.4-r2.ebuild,v 1.1 2006/02/21 18:03:31 carlo Exp $

inherit kde

P_DOC="${PN}-doc-${PV}"
MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="DigikamImagePlugins are a collection of plugins for digiKam Image Editor."
HOMEPAGE="http://www.digikam.org/"
SRC_URI="mirror://sourceforge/digikam/${MY_P}.tar.bz2
	mirror://sourceforge/digikam/${P_DOC}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND="~media-gfx/digikam-${PV}
	>=media-gfx/imagemagick-5.5.4
	>=media-video/mjpegtools-1.6.0
	virtual/opengl"

need-kde 3.2

src_compile(){
	kde_src_compile
	_S=${S}
	S=${WORKDIR}/${P_DOC}
	cd ${S}
	kde_src_compile
	S=${_S}
}

src_install(){
	kde_src_install
	_S=${S}
	S=${WORKDIR}/${P_DOC}
	cd ${S}
	kde_src_install
	S=${_S}
}
