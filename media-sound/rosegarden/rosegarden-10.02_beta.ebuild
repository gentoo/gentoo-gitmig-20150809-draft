# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rosegarden/rosegarden-10.02_beta.ebuild,v 1.1 2009/12/25 20:53:43 ssuominen Exp $

EAPI=2
inherit fdo-mime multilib

MY_P=${P/_/-}

DESCRIPTION="MIDI and audio sequencer and notation editor"
HOMEPAGE="http://www.rosegardenmusic.com/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug"

DEPEND="x11-libs/qt-gui:4[qt3support]
	media-libs/ladspa-sdk
	x11-libs/libSM
	app-misc/lirc
	media-sound/jack-audio-connection-kit
	media-libs/alsa-lib
	media-libs/dssi
	media-libs/liblo
	media-libs/liblrdf
	=sci-libs/fftw-3*
	media-libs/libsamplerate[sndfile]"

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -i \
		-e 's:update-mime-database:true:g' Makefile.in || die
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
