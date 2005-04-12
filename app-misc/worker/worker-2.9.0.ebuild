# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/worker/worker-2.9.0.ebuild,v 1.3 2005/04/12 16:14:29 luckyduck Exp $

DESCRIPTION="Worker Filemanager: Amiga Directory Opus 4 clone"
HOMEPAGE="http://www.boomerangsworld.de/worker/"
SRC_URI="http://www.boomerangsworld.de/worker/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc amd64 ia64 ~sparc alpha ~hppa ~mips"
IUSE=""

DEPEND="virtual/x11"

src_install() {
	einstall || die "make install failed"
	doman man/worker.1
	dodoc AUTHORS ChangeLog INSTALL NEWS README README_LARGEFILES THANKS
}
