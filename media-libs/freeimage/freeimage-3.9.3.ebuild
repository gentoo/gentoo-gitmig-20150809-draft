# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/freeimage/freeimage-3.9.3.ebuild,v 1.1 2007/03/31 05:55:07 nyhm Exp $

inherit eutils toolchain-funcs multilib

MY_PN=FreeImage
MY_P=${MY_PN}${PV//.}
DESCRIPTION="Image library supporting many formats"
HOMEPAGE="http://freeimage.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip
	doc? ( mirror://sourceforge/${PN}/${MY_P}.pdf )"

LICENSE="GPL-2 FIPL-1.0"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

RDEPEND="media-libs/jpeg
	media-libs/tiff
	media-libs/libpng
	media-libs/libmng"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${MY_PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
	edos2unix gensrclist.sh genfipsrclist.sh
	sh ./gensrclist.sh || die "gensrclist failed"
	sh ./genfipsrclist.sh || die "genfipsrclist failed"
}

src_compile() {
	tc-export CC CXX AR
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" LIBDIR=/usr/$(get_libdir) install \
		|| die "emake install failed"
	dodoc README.linux Whatsnew.txt
	use doc && dodoc "${DISTDIR}"/${MY_P}.pdf
}
