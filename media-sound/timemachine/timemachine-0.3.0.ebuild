# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/timemachine/timemachine-0.3.0.ebuild,v 1.6 2009/07/16 10:37:59 ssuominen Exp $

EAPI=2
inherit flag-o-matic eutils

DESCRIPTION="JACK client record button remembering the last 10 seconds when pressed."
HOMEPAGE="http://plugin.org.uk/timemachine/"
SRC_URI="http://plugin.org.uk/timemachine/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="sparc"
IUSE=""

RDEPEND=">=media-sound/jack-audio-connection-kit-0.80.0
	>=x11-libs/gtk+-2.2.4-r1
	>=media-libs/libsndfile-1.0.5"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf \
		--disable-ladcca
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog
}
