# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/aubio/aubio-0.3.2.ebuild,v 1.2 2007/11/20 22:54:11 corsair Exp $

IUSE="alsa doc jack lash"

DESCRIPTION="Library for audio labelling"
HOMEPAGE="http://aubio.piem.org"
SRC_URI="http://aubio.piem.org/pub/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

RDEPEND="=sci-libs/fftw-3*
	    >=dev-util/pkgconfig-0.9.0
		media-libs/libsndfile
		media-libs/libsamplerate
		>=dev-lang/swig-1.3.0
		dev-lang/python
		alsa? ( media-libs/alsa-lib )
		jack? ( media-sound/jack-audio-connection-kit )
		lash? ( media-sound/lash )"

DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen virtual/latex-base )"

src_compile() {
	econf $(use_enable jack) \
		$(use_enable alsa) \
		$(use_enable lash) \
		|| die "econf failed"
	emake || die "emake failed"
	if use doc; then
		export VARTEXFONTS="${T}/fonts"
		cd "${S}/doc"
		doxygen user.cfg || die "creating user doc failed"
		doxygen devel.cfg || die "creating devel doc failed"
		doxygen examples.cfg || die "creating examples doc failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README TODO
	doman doc/*.1
	if use doc; then
		mv doc/user/html doc/user/user
		dohtml -r doc/user/user
		mv doc/devel/html doc/devel/devel
		dohtml -r doc/devel/devel
		mv doc/examples/html doc/examples/examples
		dohtml -r doc/examples/examples
	fi

}
