# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/aubio/aubio-0.3.2-r1.ebuild,v 1.10 2011/09/29 20:09:35 ssuominen Exp $

EAPI=4

inherit eutils autotools

DESCRIPTION="Library for audio labelling"
HOMEPAGE="http://aubio.piem.org"
SRC_URI="http://aubio.piem.org/pub/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ppc64 sparc x86"
IUSE="alsa doc jack lash static-libs"

RDEPEND="sci-libs/fftw:3.0
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

DOCS=( AUTHORS ChangeLog README TODO )

src_prepare() {
	epatch "${FILESDIR}"/aubio-0.3.2-multilib.patch
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_enable jack) \
		$(use_enable alsa) \
		$(use_enable lash)
}

src_compile() {
	default

	if use doc; then
		export VARTEXFONTS="${T}/fonts"
		cd "${S}"/doc
		doxygen user.cfg
		doxygen devel.cfg
		doxygen examples.cfg
	fi
}

src_install() {
	default

	doman doc/*.1
	if use doc; then
		mv doc/user/html doc/user/user
		dohtml -r doc/user/user
		mv doc/devel/html doc/devel/devel
		dohtml -r doc/devel/devel
		mv doc/examples/html doc/examples/examples
		dohtml -r doc/examples/examples
	fi

	find "${ED}"usr -name '*.la' -exec rm -f {} +
}
