# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvgrab/dvgrab-1.5.ebuild,v 1.5 2004/12/30 23:17:23 swegener Exp $

inherit eutils

DESCRIPTION="Digital Video (DV) grabber for GNU/Linux"
HOMEPAGE="http://kino.schirmacher.de/"
SRC_URI="http://kino.schirmacher.de/filemanager/download/20/${P}.tar.gz"
LICENSE="GPL-2"
IUSE="jpeg quicktime"

SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="sys-libs/libavc1394
	>=media-libs/libdv-0.98
	jpeg? ( media-libs/jpeg )
	quicktime? ( media-libs/libquicktime )"

# The following would be better but if it's satisfied by
# quicktime4linux then we need to use some special linker options
# (-ldl -lglib)
#	quicktime? ( virtual/quicktime )"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/dvgrab_gcc34_fix || die
}

src_install () {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS COPYING ChangeLog README INSTALL TODO NEWS \
		|| die "dodoc failed"
}
