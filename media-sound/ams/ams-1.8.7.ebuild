# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ams/ams-1.8.7.ebuild,v 1.1 2004/11/21 20:01:37 fvdpol Exp $

DESCRIPTION="Alsa Modular Software Synthesizer"
HOMEPAGE="http://alsamodular.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=media-libs/alsa-lib-0.9
	 media-sound/jack-audio-connection-kit
	 >=x11-libs/qt-3.0.0
	 =dev-libs/fftw-2*
	 media-libs/ladspa-sdk
	 media-libs/libclalsadrv"

DEPEND="${RDEPEND}
	sys-apps/sed"

SRC_URI="mirror://sourceforge/alsamodular/${P}.tar.bz2"
RESTRICT="nomirror"

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

	dodoc README INSTALL THANKS LICENSE

	docinto examples
	dodoc *.ams
}
