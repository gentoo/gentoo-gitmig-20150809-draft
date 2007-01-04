# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpck/mpck-0.15.ebuild,v 1.1 2007/01/04 22:59:50 chainsaw Exp $

MY_P="checkmate-${PV}"
S=${WORKDIR}/${MY_P}
IUSE=""

DESCRIPTION="Checks MP3s for errors"
HOMEPAGE="http://mpck.linuxonly.nl/"
SRC_URI="http://checkmate.linuxonly.nl/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86 ~ppc"

src_install () {
	make install DESTDIR="${D}" || die "Install failed!"
	dodoc ABOUT_FIXING AUTHORS ChangeLog HISTORY README
}
