# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/jamin/jamin-0.9.0.ebuild,v 1.1 2004/08/18 00:38:44 fvdpol Exp $

inherit eutils

IUSE=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

DESCRIPTION="JAMin is the JACK Audio Connection Kit (JACK) Audio Mastering interface"
HOMEPAGE="http://jamin.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

DEPEND=">=media-sound/jack-audio-connection-kit-0.80.0
		>=media-plugins/swh-plugins-0.4.6
		media-libs/ladspa-sdk
		>=dev-libs/fftw-3.0.1
		media-libs/libsndfile
		>=media-libs/alsa-lib-0.9.0
		>=dev-libs/libxml2-2.5.0
		>=x11-libs/gtk+-2.0.0"

src_unpack() {
	unpack ${A}

	epatch ${FILESDIR}/${P}-scenes.patch
}

src_install() {
	make install DESTDIR=${D}
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README TODO
}
