# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/meterbridge/meterbridge-0.9.2.ebuild,v 1.12 2006/04/14 05:57:23 halcy0n Exp $

inherit eutils

IUSE=""

DESCRIPTION="Software meterbridge for the UNIX based JACK audio system."
HOMEPAGE="http://plugin.org.uk/meterbridge/"
SRC_URI="http://plugin.org.uk/meterbridge/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"

DEPEND="media-sound/jack-audio-connection-kit
	media-libs/sdl-image"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-gcc41.patch
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog
}
