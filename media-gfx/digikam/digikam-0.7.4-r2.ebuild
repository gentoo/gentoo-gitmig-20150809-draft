# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/digikam/digikam-0.7.4-r2.ebuild,v 1.2 2006/02/21 18:00:12 carlo Exp $

inherit kde

P_DOC="${PN}-doc-${PV}"
MY_P="${P/_/-}"
S="${WORKDIR}/${MY_P}"

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
	media-libs/libkipi
	media-libs/imlib2
	media-libs/tiff
	sys-libs/gdbm
	!media-plugins/digikamplugins"
RDEPEND="${DEPEND}
	|| ( kde-base/kgamma kde-base/kdegraphics )"
need-kde 3.2

pkg_setup(){
	slot_rebuild "media-libs/libkipi media-libs/libkexif" && die
}

src_compile(){
	kde_src_compile
	myconf=""
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
