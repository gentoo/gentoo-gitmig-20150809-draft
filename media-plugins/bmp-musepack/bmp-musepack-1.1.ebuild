# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/bmp-musepack/bmp-musepack-1.1.ebuild,v 1.2 2005/01/29 22:05:58 chainsaw Exp $

inherit eutils
IUSE=""

DESCRIPTION="Beep Media Player plugin to play audio files encoded with Andree Buschmann's encoder Musepack (mpc, mp+, mpp)"
HOMEPAGE="http://www.musepack.net"
SRC_URI="http://www.saunalahti.fi/grimmel/musepack.net/linux/plugins/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"

DEPEND="media-sound/beep-media-player
	=media-libs/libmusepack-1.0.3"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PV}-includes.patch
}

src_install() {
	make DESTDIR="${D}" install
}
