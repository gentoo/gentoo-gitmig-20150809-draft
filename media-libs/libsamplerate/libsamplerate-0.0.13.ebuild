# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsamplerate/libsamplerate-0.0.13.ebuild,v 1.3 2004/03/19 07:56:04 mr_bones_ Exp $

DESCRIPTION="a library for converting 44.1kHz CD Audio to 48kHz for DAT"
HOMEPAGE="http://www.mega-nerd.com/SRC/"
SRC_URI="http://www.mega-nerd.com/SRC/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="virtual/glibc
	>=dev-libs/fftw-2.0.0
	>=media-libs/libsndfile-1.0.0
	>=dev-util/pkgconfig-0.14.0"
S=${WORKDIR}/${P}

src_compile() {

	econf || die"configure failed"

	emake || die "compile failed"

}

src_install() {

	einstall || die "make install failed"

}
