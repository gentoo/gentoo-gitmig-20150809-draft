# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/digikam/digikam-0.8.0-r1.ebuild,v 1.1 2005/12/03 20:10:00 carlo Exp $

inherit kde

P_DOC="${PN}-doc-${PV}"
MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A digital photo management application for KDE."
HOMEPAGE="http://www.digikam.org/"
SRC_URI="mirror://sourceforge/digikam/${MY_P}.tar.bz2
	mirror://sourceforge/digikam/${P_DOC}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~x86"
IUSE=""

DEPEND=">=media-libs/libgphoto2-2
	>=media-libs/libkexif-0.2.1
	>=dev-db/sqlite-3
	>=media-libs/libkipi-0.1.1
	media-libs/imlib2
	media-libs/tiff
	sys-libs/gdbm
	!media-plugins/digikamplugins"

need-kde 3.2

pkg_setup(){
	slot_rebuild "media-libs/libkipi media-libs/libkexif" && die
}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/digikam-0.8.0-gcc41.patch
}

src_compile(){
	kde_src_compile
	cd ${WORKDIR}/${P_POC}
	kde_src_compile
}

src_install(){
	kde_src_install
	cd ${WORKDIR}/${P_DOC}
	kde_src_install
}
