# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rosegarden/rosegarden-10.04.ebuild,v 1.6 2010/07/30 11:34:26 hwoarang Exp $

EAPI=2
inherit autotools fdo-mime multilib

DESCRIPTION="MIDI and audio sequencer and notation editor"
HOMEPAGE="http://www.rosegardenmusic.com/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="debug lirc"

RDEPEND="x11-libs/qt-gui:4
	x11-libs/qt-qt3support:4
	media-libs/ladspa-sdk
	x11-libs/libSM
	media-sound/jack-audio-connection-kit
	media-libs/alsa-lib
	>=media-libs/dssi-1.0.0
	media-libs/liblo
	media-libs/liblrdf
	=sci-libs/fftw-3*
	media-libs/libsamplerate[sndfile]
	lirc? ( app-misc/lirc )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	x11-misc/makedepend"

src_prepare() {
	if ! use lirc; then
		sed -i \
			-e '/AC_CHECK_HEADER/s:lirc_client.h:dIsAbLe&:' \
			-e '/AC_CHECK_LIB/s:lirc_init:dIsAbLe&:' \
			configure.ac || die
	fi

	eautoreconf
}

src_configure() {
	export USER_CXXFLAGS="${CXXFLAGS}"

	local myconf
	use debug && myconf="--enable-debug"

	econf \
		--with-qtdir=/usr \
		--with-qtlibdir=/usr/$(get_libdir)/qt4 \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS CONTRIBUTING README
}

pkg_postinst() {
	fdo-mime_mime_database_update
}

pkg_postrm() {
	fdo-mime_mime_database_update
}
