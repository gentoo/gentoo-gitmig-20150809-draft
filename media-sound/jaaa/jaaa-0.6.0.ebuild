# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/jaaa/jaaa-0.6.0.ebuild,v 1.1 2010/04/12 08:59:35 aballier Exp $

inherit eutils toolchain-funcs

DESCRIPTION="The JACK and ALSA Audio Analyser is an audio signal generator and spectrum analyser"
HOMEPAGE="http://www.kokkinizita.net/linuxaudio"
SRC_URI="http://www.kokkinizita.net/linuxaudio/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="media-sound/jack-audio-connection-kit
	>=media-libs/libclalsadrv-2.0.0
	>=media-libs/libclthreads-2.2.1
	>=media-libs/libclxclient-3.3.2
	>=sci-libs/fftw-3.0.0
	>=x11-libs/gtk+-2.0.0"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-makefile.patch"
}

src_compile() {
	tc-export CC CXX
	emake PREFIX=/usr || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install || die
	dodoc AUTHORS README
}
