# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/timestamp/timestamp-1.1.ebuild,v 1.6 2008/10/29 16:15:59 pva Exp $

DESCRIPTION="A text filtering pipe that marks each line with a timestamp"
HOMEPAGE="http://math.smsu.edu/~erik/software.php?id=95"
SRC_URI="http://math.smsu.edu/~erik/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="!sys-apps/moreutils"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog
}
