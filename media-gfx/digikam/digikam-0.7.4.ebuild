# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/digikam/digikam-0.7.4.ebuild,v 1.1 2005/09/16 19:50:42 cryos Exp $

inherit kde

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A digital photo management application for KDE."
HOMEPAGE="http://www.digikam.org/"
SRC_URI="mirror://sourceforge/digikam/${MY_P}.tar.bz2
	doc? ( mirror://sourceforge/digikam/${PN}-doc-${PV}.tar.bz2 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~x86"
IUSE="doc"

DEPEND=">=media-libs/libgphoto2-2
	>=media-libs/libkexif-0.2.1
	media-libs/libkipi
	media-libs/imlib2
	media-libs/tiff
	sys-libs/gdbm
	!media-plugins/digikamplugins"

need-kde 3.2

pkg_setup(){
	slot_rebuild "media-libs/libkipi media-libs/libkexif" && die
}

src_compile(){
	kde_src_compile
	if use doc; then
		cd ${WORKDIR}/${PN}-doc-${PV}
		econf $(use_with arts) || die "econf failed for docs."
		emake || die "emake failed for docs."
	fi
}

src_install(){
	kde_src_install
	if use doc; then
		cd ${WORKDIR}/${PN}-doc-${PV}
		make install DESTDIR=${D} || "make install failed for docs."
	fi
}
