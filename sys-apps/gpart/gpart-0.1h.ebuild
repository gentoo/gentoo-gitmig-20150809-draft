# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gpart/gpart-0.1h.ebuild,v 1.3 2003/04/25 16:05:30 vapier Exp $

inherit eutils

DESCRIPTION="Partition table rescue/guessing tool"
SRC_URI="http://www.stud.uni-hannover.de/user/76201/gpart/${P}.tar.gz"
HOMEPAGE="http://www.stud.uni-hannover.de/user/76201/gpart/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-errno.diff
}

src_compile() {
	emake || die
}

src_install() {
	dobin src/gpart
	doman man/gpart.8
	dodoc README CHANGES COPYING INSTALL LSM
}
