# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsamplerate/libsamplerate-0.0.14.ebuild,v 1.10 2004/07/01 08:00:04 eradicator Exp $

DESCRIPTION="a library for converting 44.1kHz CD Audio to 48kHz for DAT"
HOMEPAGE="http://www.mega-nerd.com/SRC/"
SRC_URI="http://www.mega-nerd.com/SRC/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc amd64"
IUSE=""
DEPEND="virtual/libc
	>=dev-libs/fftw-2.0.0
	>=media-libs/libsndfile-1.0.2
	>=dev-util/pkgconfig-0.14.0"

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog || die "dodoc failed"
}
