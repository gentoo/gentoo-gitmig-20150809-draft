# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/pconsole/pconsole-1.0-r1.ebuild,v 1.1 2004/11/04 11:25:02 voxus Exp $

inherit eutils

DESCRIPTION="Tool for managing multiple xterms simultaneously."
HOMEPAGE="http://www.heiho.net/pconsole/"
SRC_URI="http://www.xs4all.nl/~walterj/pconsole/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND="virtual/ssh"

src_compile() {
	epatch ${FILESDIR}/${P}-exit-warn.patch || einfo "Never mind.."
	./configure --prefix=${D}/usr
	emake || die
}

src_install() {
	dobin pconsole pconsole.sh ssh.sh
	fperms 4111 /usr/bin/pconsole
	dodoc ChangeLog public_html/pconsole.html README.pconsole
}

pkg_postinst() {
	ewarn
	ewarn "Warning:"
	ewarn "pconsole installed with suid root!"
	ewarn
}
