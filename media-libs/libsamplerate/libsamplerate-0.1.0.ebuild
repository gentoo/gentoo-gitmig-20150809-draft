# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsamplerate/libsamplerate-0.1.0.ebuild,v 1.1 2004/05/28 05:55:21 eradicator Exp $

DESCRIPTION="a library for converting 44.1kHz CD Audio to 48kHz for DAT"
HOMEPAGE="http://www.mega-nerd.com/SRC/"
SRC_URI="http://www.mega-nerd.com/SRC/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~ia64 ~amd64"
IUSE="sndfile"
DEPEND=">=dev-libs/fftw-2.0.0
	sndfile? ( >=media-libs/libsndfile-1.0.2 )
	>=dev-util/pkgconfig-0.14.0"
#	This libs presence seems to have no effect
#	efence? ( dev-util/efence )

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog || die "dodoc failed"
}
