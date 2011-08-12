# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qjackctl/qjackctl-0.3.7.ebuild,v 1.4 2011/08/12 18:51:07 xarthisius Exp $

EAPI=2

inherit qt4

DESCRIPTION="A Qt application to control the JACK Audio Connection Kit and ALSA sequencer connections."
HOMEPAGE="http://qjackctl.sourceforge.net/"
SRC_URI="mirror://sourceforge/qjackctl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"

IUSE="alsa dbus debug portaudio"

RDEPEND="alsa? ( media-libs/alsa-lib )
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	dbus? ( x11-libs/qt-dbus )
	portaudio? ( media-libs/portaudio )
	>=media-sound/jack-audio-connection-kit-0.109.2"
DEPEND="${RDEPEND}"

src_configure() {
	econf \
		$(use_enable alsa alsa-seq) \
		$(use_enable dbus) \
		$(use_enable debug) \
		$(use_enable portaudio)

	# Emulate what the Makefile does, so that we can get the correct
	# compiler used.
	eqmake4 ${PN}.pro -o ${PN}.mak || die "eqmake4 failed"
}

src_compile() {
	emake -f ${PN}.mak || die "emake failed"
	lupdate ${PN}.pro || die "lupdate failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc README ChangeLog TODO AUTHORS TRANSLATORS
}
