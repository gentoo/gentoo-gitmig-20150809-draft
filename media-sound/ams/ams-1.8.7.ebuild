# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ams/ams-1.8.7.ebuild,v 1.6 2006/10/05 06:57:20 flameeyes Exp $

inherit multilib

DESCRIPTION="Alsa Modular Software Synthesizer"
HOMEPAGE="http://alsamodular.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

RDEPEND=">=media-libs/alsa-lib-0.9
	 media-sound/jack-audio-connection-kit
	 =x11-libs/qt-3*
	 =sci-libs/fftw-2*
	 media-libs/ladspa-sdk
	 media-libs/libclalsadrv"

DEPEND="${RDEPEND}
	sys-apps/sed"

SRC_URI="mirror://sourceforge/alsamodular/${P}.tar.bz2"
RESTRICT="nomirror"

src_compile() {
	emake QT_BASE_DIR="${QTDIR}" QT_LIB_DIR="${QTDIR}/$(get_libdir)" || die "Make failed."
}

src_install() {
	dobin ams

	dodoc README THANKS

	docinto examples
	dodoc *.ams
}
