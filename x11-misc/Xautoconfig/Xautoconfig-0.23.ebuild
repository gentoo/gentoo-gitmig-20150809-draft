# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/Xautoconfig/Xautoconfig-0.23.ebuild,v 1.1 2005/02/21 12:28:24 dholm Exp $

inherit eutils

DESCRIPTION="Xautoconfig is a PPC only config file generator for xfree86"
SRC_URI="http://ftp.penguinppc.org/projects/xautocfg/${P}.tar.gz"
HOMEPAGE="http://ftp.penguinppc.org/projects/xautocfg/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~ppc ~ppc64"
IUSE=""

DEPEND="sys-apps/pciutils"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch || die
}

src_compile() {
	make || die "sorry, failed to compile Xautoconfig (PPC-only ebuild)"
}

src_install() {
	dodir /usr/X11R6/
	into /usr/X11R6/
	dobin Xautoconfig

	dodoc ChangeLog

}
