# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rosegarden/rosegarden-10.02.1.ebuild,v 1.5 2010/07/04 18:33:13 ssuominen Exp $

EAPI=2
inherit autotools eutils fdo-mime multilib

DESCRIPTION="MIDI and audio sequencer and notation editor"
HOMEPAGE="http://www.rosegardenmusic.com/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="debug"

RDEPEND="x11-libs/qt-gui:4[qt3support]
	media-libs/ladspa-sdk
	x11-libs/libSM
	app-misc/lirc
	media-sound/jack-audio-connection-kit
	media-libs/alsa-lib
	>=media-libs/dssi-1.0.0
	media-libs/liblo
	media-libs/liblrdf
	=sci-libs/fftw-3*
	media-libs/libsamplerate[sndfile]"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	x11-misc/makedepend"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-10.02-configure.ac.patch
	eautoreconf
}

src_configure() {
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
