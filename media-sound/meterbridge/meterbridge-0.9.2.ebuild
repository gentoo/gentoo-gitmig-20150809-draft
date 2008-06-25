# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/meterbridge/meterbridge-0.9.2.ebuild,v 1.15 2008/06/25 16:37:17 aballier Exp $

inherit eutils autotools

IUSE=""

DESCRIPTION="Software meterbridge for the UNIX based JACK audio system."
HOMEPAGE="http://plugin.org.uk/meterbridge/"
SRC_URI="http://plugin.org.uk/meterbridge/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"

RDEPEND="media-sound/jack-audio-connection-kit
	media-libs/sdl-image"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc41.patch
	epatch "${FILESDIR}"/${P}-asneeded.patch
	epatch "${FILESDIR}"/${P}-cflags.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog
}
