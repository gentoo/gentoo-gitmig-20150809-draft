# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvgrab/dvgrab-1.5.ebuild,v 1.4 2004/07/31 18:05:54 malc Exp $

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

inherit eutils

# The following would be better but if it's satisfied by
# quicktime4linux then we need to use some special linker options
# (-ldl -lglib)
#	quicktime? ( virtual/quicktime )"

src_compile() {
	econf ${myconf} || die
	epatch ${FILESDIR}/dvgrab_gcc34_fix || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog README INSTALL TODO NEWS
}
