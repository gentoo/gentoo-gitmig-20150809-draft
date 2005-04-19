# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/konverter/konverter-0.92_beta1.ebuild,v 1.1 2005/04/19 20:12:05 luckyduck Exp $

inherit kde

DESCRIPTION="A KDE MEncoder frontend for video-conversion."
HOMEPAGE="http://www.kraus.tk/projects/konverter/"
SRC_URI="http://www.kraus.tk/projects/${PN}/sources/${P/_/-}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

S=${WORKDIR}/${P/_/-}

DEPEND="media-video/mplayer"
need-kde 3

src_install() {
	einstall || die "make install failed"
	dodoc ChangeLog TODO README NEWS INSTALL AUTHORS
}

