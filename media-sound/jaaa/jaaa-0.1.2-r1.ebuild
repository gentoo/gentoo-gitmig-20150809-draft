# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/jaaa/jaaa-0.1.2-r1.ebuild,v 1.1 2004/11/28 13:30:31 fvdpol Exp $

inherit eutils

IUSE=""

DESCRIPTION="The JACK and ALSA Audio Analyser is an audio signal generator and spectrum analyser designed to make accurate measurements."
HOMEPAGE="http://users.skynet.be/solaris/linuxaudio"
SRC_URI="http://users.skynet.be/solaris/linuxaudio/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"

DEPEND="virtual/jack
	>=media-libs/libclalsadrv-1.0.1
	>=media-libs/libclthreads-1.0.2
	>=media-libs/libclxclient-1.0.1
	>=dev-libs/fftw-3.0.0
	>=x11-libs/gtk+-2.0.0"

src_unpack() {
	unpack ${A}

	# fix 32bit datatypes for amd64
	epatch ${FILESDIR}/${P}-amd64.patch
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin jaaa || die "dobin failed"
	dodoc AUTHORS INSTALL README
}
