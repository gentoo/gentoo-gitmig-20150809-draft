# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsamplerate/libsamplerate-0.1.2.ebuild,v 1.10 2005/07/27 20:10:34 gmsoft Exp $

DESCRIPTION="Secret Rabbit Code (aka libsamplerate) is a Sample Rate Converter for audio"
HOMEPAGE="http://www.mega-nerd.com/SRC/"
SRC_URI="http://www.mega-nerd.com/SRC/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ia64 ~mips ppc ~ppc-macos ppc64 ~sparc ~x86 hppa"
IUSE="sndfile static"
RDEPEND=">=sci-libs/fftw-3.0.1
	sndfile? ( >=media-libs/libsndfile-1.0.2 )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.14.0"

src_compile() {
	local myconf=$(use_enable static)

	# Unconditonal use of -fPIC (#55238).
	myconf="${myconf} --with-pic"

	econf $myconf || die "./configure failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README
	dohtml doc/*.html doc/*.css doc/*.png
}
