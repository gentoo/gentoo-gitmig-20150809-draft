# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsamplerate/libsamplerate-0.1.2.ebuild,v 1.18 2006/10/20 19:50:49 gustavoz Exp $

DESCRIPTION="Secret Rabbit Code (aka libsamplerate) is a Sample Rate Converter for audio"
HOMEPAGE="http://www.mega-nerd.com/SRC/"
SRC_URI="http://www.mega-nerd.com/SRC/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 arm hppa ia64 mips ppc ~ppc-macos ppc64 sh sparc ~x86 ~x86-fbsd"
IUSE="sndfile fftw"

RDEPEND="fftw? ( >=sci-libs/fftw-3.0.1 )
	sndfile? ( >=media-libs/libsndfile-1.0.2 )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.14.0"

src_compile() {
	local myconf

	use fftw || myconf="${myconf} --disable-fftw"

	econf \
		${myconf} \
		--disable-dependency-tracking \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
	dohtml doc/*.html doc/*.css doc/*.png
}
