# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpck/mpck-0.10.ebuild,v 1.1 2005/12/09 23:26:00 chainsaw Exp $

IUSE=""

DESCRIPTION="Checks MP3s for errors"
HOMEPAGE="http://mpck.linuxonly.nl/"
SRC_URI="http://mpck.linuxonly.nl/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64"

src_install () {
	make install DESTDIR="${D}" || die "Install failed!"
	dodoc ABOUT_FIXING AUTHORS ChangeLog HISTORY NEWS README TODO
}
