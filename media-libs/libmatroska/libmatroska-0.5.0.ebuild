# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmatroska/libmatroska-0.5.0.ebuild,v 1.1 2003/09/05 16:32:51 mholzer Exp $

IUSE=""

S=${WORKDIR}/${PN}

DESCRIPTION="Extensible multimedia container format based on EBML."
SRC_URI="http://matroska.free.fr/downloads/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.matroska.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="virtual/glibc
	~media-libs/libebml-${PV}"

src_compile() {
	cd ${S}/make/linux
	make PREFIX=/usr \
		LIBEBML_INCLUDE_DIR=/usr/include/ebml \
		LIBEBML_LIB_DIR=/usr/lib || die "make failed"
}

src_install () {
	cd ${S}/make/linux
	einstall || die "make install failed"
}
