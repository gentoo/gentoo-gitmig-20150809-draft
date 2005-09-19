# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvgrab/dvgrab-1.7.ebuild,v 1.6 2005/09/19 00:12:03 flameeyes Exp $

inherit eutils

DESCRIPTION="Digital Video (DV) grabber for GNU/Linux"
HOMEPAGE="http://kino.schirmacher.de/"
SRC_URI="http://kino.schirmacher.de/filemanager/download/43/${P}.tar.gz"
LICENSE="GPL-2"
IUSE="jpeg quicktime"

SLOT="0"
KEYWORDS="x86 amd64"

DEPEND="sys-libs/libavc1394
	>=media-libs/libdv-0.102
	jpeg? ( media-libs/jpeg )
	quicktime? ( media-libs/libquicktime )"

src_install () {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog README TODO NEWS || die "dodoc failed"
}
