# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libharu/libharu-2.2.1.ebuild,v 1.2 2011/07/10 15:49:38 jlec Exp $

EAPI=4

inherit eutils

DESCRIPTION="C/C++ library for PDF generation"
HOMEPAGE="http://www.libharu.org/"
SRC_URI="http://libharu.org/files/${P}.tar.bz2"

LICENSE="ZLIB"
SLOT="2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="png zlib static-libs"

DEPEND="
	png? ( media-libs/libpng )
	zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-libpng-1.5.patch
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_with png) \
		$(use_with zlib)
}

src_install() {
	emake \
		INSTALL_STRIP_FLAG="" \
		DESTDIR="${D}" install
	dodoc README
}
