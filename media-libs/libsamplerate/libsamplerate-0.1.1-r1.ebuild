# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsamplerate/libsamplerate-0.1.1-r1.ebuild,v 1.2 2004/09/02 23:30:23 eradicator Exp $

IUSE="sndfile static"

DESCRIPTION="a library for converting 44.1kHz CD Audio to 48kHz for DAT"
HOMEPAGE="http://www.mega-nerd.com/SRC/"
SRC_URI="http://www.mega-nerd.com/SRC/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~ia64 ~amd64"

DEPEND=">=dev-libs/fftw-3.0.1
	sndfile? ( >=media-libs/libsndfile-1.0.2 )
	>=dev-util/pkgconfig-0.14.0"

src_compile() {
	local myconf=`use_enable static`

	# Unconditonal use of -fPIC (#55238).
	myconf="${myconf} --with-pic"

	econf $myconf || die "./configure failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README
	dohtml doc/*.html doc/*.css doc/*.png
}
