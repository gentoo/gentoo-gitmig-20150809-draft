# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/MuSE/MuSE-0.7.2.ebuild,v 1.1 2003/03/08 11:26:56 jje Exp $

DESCRIPTION="Multiple Streaming Engine, an icecast source streamer"
HOMEPAGE="http://muse.dyne.org/"
LICENSE="GPL-2"
# Point to any required sources; these will be automatically downloaded by
# Portage.
SRC_URI="http://savannah.nongnu.org/download/muse/${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86"
IUSE="X"

DEPEND=">=media-libs/libogg-1.0
	>=media-libs/libvorbis-1.0-r1
	>=media-sound/lame-3.92"

S=${WORKDIR}/MuSE-0.7.2

src_compile() {
	econf
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	einstall
}

