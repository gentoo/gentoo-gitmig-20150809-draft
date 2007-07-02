# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ams/ams-1.8.4.ebuild,v 1.7 2007/07/02 15:10:16 peper Exp $

DESCRIPTION="Alsa Modular Software Synthesizer"
HOMEPAGE="http://alsamodular.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc"
IUSE=""

RDEPEND=">=media-libs/alsa-lib-0.9
	 media-sound/jack-audio-connection-kit
	 =x11-libs/qt-3*
	 =sci-libs/fftw-2*
	 media-libs/ladspa-sdk"

DEPEND="${RDEPEND}
	sys-apps/sed"

SRC_URI="mirror://sourceforge/alsamodular/${P}.tar.bz2"
RESTRICT="mirror"

src_unpack() {
	unpack ${A} || die
	cd ${S}

	sed -i "s%QT_BASE_DIR=/usr/lib/qt3%QT_BASE_DIR=${QTDIR}%" Makefile || die "Makefile update failed."
}

src_compile() {
	make || die "Make failed."
}

src_install() {
	dobin ams

	dodoc README THANKS

	docinto examples
	dodoc *.ams
}
