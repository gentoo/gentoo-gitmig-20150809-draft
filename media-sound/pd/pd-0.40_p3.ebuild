# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pd/pd-0.40_p3.ebuild,v 1.1 2007/07/30 20:07:40 drac Exp $

inherit eutils toolchain-funcs

MY_P=${P/_p/-}

DESCRIPTION="real-time music and multimedia environment"
HOMEPAGE="http://www-crca.ucsd.edu/~msp/software.html"
SRC_URI="http://www-crca.ucsd.edu/~msp/Software/${MY_P}.src.tar.gz"

LICENSE="|| ( BSD as-is )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="alsa debug fftw jack portaudio"

RDEPEND=">=dev-lang/tcl-8.3.3
	>=dev-lang/tk-8.3.3
	alsa? ( >=media-libs/alsa-lib-0.9.0_rc2 )
	jack? ( >=media-sound/jack-audio-connection-kit-0.99.0-r1 )
	fftw? ( sci-libs/fftw )
	portaudio? ( media-libs/portaudio )"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${MY_P}/src

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"/${MY_P}

	# Need to get some of this to upstream.
	epatch "${FILESDIR}"/${P}-gentoo.patch
}

src_compile() {
	econf $(use_enable alsa) $(use_enable jack) \
		$(use_enable debug) $(use_enable fftw) \
		$(use_enable portaudio)
	emake CC="$(tc-getCC)" || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."

	# Install private headers for developers.
	insinto /usr/include
	doins m_imp.h g_canvas.h
}
