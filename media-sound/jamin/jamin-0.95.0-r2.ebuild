# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/jamin/jamin-0.95.0-r2.ebuild,v 1.1 2006/01/14 11:51:04 fvdpol Exp $

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

src_compile() {
	econf `use_enable osc` || die "configure failed"
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
