# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/aubio/aubio-0.3.2-r1.ebuild,v 1.9 2010/12/02 18:41:32 flameeyes Exp $

inherit eutils autotools

IUSE="alsa doc jack lash"

DESCRIPTION="Library for audio labelling"
HOMEPAGE="http://aubio.piem.org"
SRC_URI="http://aubio.piem.org/pub/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ppc64 sparc x86"

RDEPEND="=sci-libs/fftw-3*
	media-libs/libsndfile
	media-libs/libsamplerate
	dev-lang/python
	alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )
	lash? ( media-sound/lash )"
DEPEND="${RDEPEND}
	>=dev-lang/swig-1.3.0
	dev-util/pkgconfig
	doc? ( app-doc/doxygen virtual/latex-base )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/aubio-0.3.2-multilib.patch
	eautoreconf
}

src_compile() {
	econf $(use_enable jack) $(use_enable alsa) $(use_enable lash)
	emake || die "emake failed."
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
