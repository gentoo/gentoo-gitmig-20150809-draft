# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libzzub/libzzub-0.2.3.ebuild,v 1.4 2007/08/14 13:53:25 hanno Exp $

DESCRIPTION="Music tracking and sequencing library compatible to Jesokla Buzz"
HOMEPAGE="http://trac.zeitherrschaft.org/zzub/"
SRC_URI="mirror://sourceforge/aldrin/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND="media-sound/jack-audio-connection-kit
	media-libs/flac
	media-libs/libsndfile
	media-libs/alsa-lib"
DEPEND="${RDEPEND}
	>=dev-util/scons-0.96.94"

src_compile() {
	scons PREFIX=/usr configure || die
	scons PREFIX=/usr || die
}

src_install() {
	scons DESTDIR="${D}" install || die "emake install failed"
}
