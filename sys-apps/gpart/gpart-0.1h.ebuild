# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gpart/gpart-0.1h.ebuild,v 1.6 2004/06/30 02:36:52 vapier Exp $

inherit eutils

DESCRIPTION="Partition table rescue/guessing tool"
HOMEPAGE="http://www.stud.uni-hannover.de/user/76201/gpart/"
SRC_URI="http://www.stud.uni-hannover.de/user/76201/gpart/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

RDEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-errno.diff
}

src_compile() {
	emake || die
}

src_install() {
	dobin src/gpart || die
	doman man/gpart.8
	dodoc README CHANGES INSTALL LSM
}
