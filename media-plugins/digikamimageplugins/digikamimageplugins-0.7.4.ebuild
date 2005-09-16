# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/digikamimageplugins/digikamimageplugins-0.7.4.ebuild,v 1.1 2005/09/16 19:54:56 cryos Exp $

inherit kde

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="DigikamImagePlugins are a collection of plugins for Digikam Image Editor."
HOMEPAGE="http://www.digikam.org/"
SRC_URI="mirror://sourceforge/digikam/${MY_P}.tar.bz2
	doc? ( mirror://sourceforge/digikam/${PN}-doc-${PV}.tar.bz2 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="doc"

DEPEND="=media-gfx/digikam-${PV}
	>=media-gfx/imagemagick-5.5.4
	>=media-video/mjpegtools-1.6.0
	virtual/opengl"

need-kde 3.2

src_compile(){
	kde_src_compile
	if use doc; then
		cd ${WORKDIR}/${PN}-doc-${PV}
		econf $(use_with arts) || die "econf failed for docs."
		emake || die "emake failed for docs."
	fi
}

src_install() {
	kde_src_install
	if use doc; then
		cd ${WORKDIR}/${PN}-doc-${PV}
		make install DESTDIR=${D} || "make install failed for docs."
	fi
}
