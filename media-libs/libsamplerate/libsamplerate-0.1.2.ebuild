# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsamplerate/libsamplerate-0.1.2.ebuild,v 1.6 2005/03/28 19:31:40 hansmi Exp $

IUSE="sndfile static"

DESCRIPTION="Secret Rabbit Code (aka libsamplerate) is a Sample Rate Converter for audio"
HOMEPAGE="http://www.mega-nerd.com/SRC/"
SRC_URI="http://www.mega-nerd.com/SRC/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc ~sparc ~alpha ~ia64 ~amd64 ~ppc-macos ppc64"

DEPEND=">=sci-libs/fftw-3.0.1
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
