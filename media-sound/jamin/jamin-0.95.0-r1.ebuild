# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/jamin/jamin-0.95.0-r1.ebuild,v 1.3 2005/06/09 00:55:57 mr_bones_ Exp $

inherit eutils

DESCRIPTION="JAMin is the JACK Audio Connection Kit (JACK) Audio Mastering interface"
HOMEPAGE="http://jamin.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="osc"

DEPEND=">=media-sound/jack-audio-connection-kit-0.80.0
	>=media-plugins/swh-plugins-0.4.6
	media-libs/ladspa-sdk
	>=sci-libs/fftw-3.0.1
	media-libs/libsndfile
	>=media-libs/alsa-lib-0.9.0
	>=dev-libs/libxml2-2.5.0
	>=x11-libs/gtk+-2.0.0
	osc? ( >=media-libs/liblo-0.5 )"

src_install() {
	make install DESTDIR=${D} || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
