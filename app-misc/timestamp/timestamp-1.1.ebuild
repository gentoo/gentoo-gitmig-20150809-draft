# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/timestamp/timestamp-1.1.ebuild,v 1.1 2005/03/19 15:31:28 ka0ttic Exp $

DESCRIPTION="A text filtering pipe that marks each line with a timestamp"
HOMEPAGE="http://math.smsu.edu/~erik/software.php?id=95"
SRC_URI="http://math.smsu.edu/~erik/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/libc"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog
}
