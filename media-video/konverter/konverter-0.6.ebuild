# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/konverter/konverter-0.6.ebuild,v 1.4 2004/07/03 21:58:17 carlo Exp $

inherit kde

DESCRIPTION="A KDE MEncoder frontend for video-conversion."
HOMEPAGE="http://www.libsdl.de/projects/konverter/"
SRC_URI="http://p15108941.pureserver.info/libsdl/projects/${PN}/sources/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""


DEPEND="media-video/mplayer"
need-kde 3

src_install() {
	einstall || die
	dodoc ChangeLog TODO README NEWS INSTALL COPYING AUTHORS
}

